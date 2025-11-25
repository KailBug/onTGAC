"""
把generator从agent抽离出来
将用于生成sql的prompt和LLM都放到这里
"""
import re
import dashscope
from dashscope import Generation
from tenacity import retry, stop_after_attempt, wait_fixed
from colorama import Fore, Style

from core.config import Config
from core.agentState import AgentState

dashscope.api_key = Config.QWEN_API_KEY

class SQLGenerator:
    def __init__(self, state: AgentState):
        self.few_shot_examples = self._get_few_shot_examples()
        self.state = state
        self.user_prompt = self._generate_user_prompt(
            question=self.state.get("query"),
            schema=self.state.get("schema"),
            knowledge=self.state.get("knowledge_rules"),
            few_shot_examples=self.few_shot_examples
        )
        self.system_prompt = """
            你是一位精通 starrocks/allin1-ubuntu:2.5.12 数据库的首席数据架构师。
            你的任务是将用户的自然语言问题转换为精确、高效的 SQL 查询。
            """
        self.messages = [{
                "role": "system",
                "content": f"{self.system_prompt}"
            },
            {
                "role": "user",
                "content": f"{self.user_prompt}",
            }]
        self.response = None
        print(f"{Fore.GREEN}SQLGenerator.__init__完成{Style.RESET_ALL}")

    @staticmethod
    def _parse_output(llm_response: str):
        """
        从模型输出中鲁棒地提取 SQL
        """
        # 尝试提取 'SQL:' 之后的内容
        pattern = r"SQL:\s*(.*)"
        match = re.search(pattern, llm_response, re.DOTALL)

        sql_content = ""
        if match:
            sql_content = match.group(1).strip()
        else:
            # 如果模型忘了写 'SQL:'，尝试找常见的 SQL 关键字
            sql_content = llm_response.strip()

        # 清理可能残留的 Markdown,别再生成```sql了，尊敬的LLM大人...
        sql_content = sql_content.replace("```sql", "").replace("```", "").strip()

        # 清理行尾可能多余的解释性文字
        # 这里假设 SQL 以分号结尾，取最后一个分号之前的内容
        if ";" in sql_content:
            sql_content = sql_content.split(";")[0] + ";"

        return sql_content

    def _generate_user_prompt(self,question,schema,knowledge,few_shot_examples):
        return f"""
                ### 1. 用户问题: {question}
                
                ### 2. 数据库 Schema 信息: {schema}
                
                ### 3. 问题相关knowledge 信息: {knowledge}
        
                ### 4. 参考示例 (Few-shot): {few_shot_examples}                   
        
                ### 5. 核心指令 (必须严格遵守)
                1. **方言兼容**: 使用 StarRocks v2.5.12 语法（高度兼容 MySQL 协议）。注意日期函数的使用（如 `date_trunc`, `str_to_date` 等）需符合 StarRocks 规范。
                2. **Schema Linking**: 在生成 SQL 前，先仔细分析问题涉及的 Table 和 Column，严格遵守schema和knowledge信息，不要通过幻觉生成不存在的字段。
                3. **格式约束**: 
                   - SQL 语句必须以 SELECT/INSERT/UPDATE/DELETE 开头。
                   - **严禁**使用 Markdown 代码块格式（如 ```sql ... ```），直接输出 SQL 文本。
                   - 确保 SQL 语句以分号 `;` 结尾。
        
                ### 7. 响应格式
                请严格按照以下格式输出，不要包含任何其他开场白或结束语：
        
                思考: [这里进行思维链推导：1.识别涉及的表和字段 -> 2.确定连接条件(JOIN) -> 3.确定筛选条件(WHERE) -> 4.确定聚合方式(GROUP BY)]
                SQL: [这里仅输出最终的 SQL 语句]
                """

    def _get_few_shot_examples(self):
        #暂时采用静态few-shot
        return Config.FEW_SHOT_EXAMPLES

    @retry(stop=stop_after_attempt(3), wait=wait_fixed(1))
    def _call_LLM(self):
        return Generation.call(
            model="qwen-coder-plus",
            messages=self.messages,
            result_format="message"
        )

    def build(self) -> AgentState:

        self.response = self._call_LLM()

        sql = ""
        text = ""
        if isinstance(self.response, str):
            text = self.response
        else:
            text = getattr(self.response, 'content', str(self.response))

        # 正则表达式，其实也能达到_parse_output()的效果
        # match = re.search(r'(?i)sql[:：]\s*([\s\S]*?;)', text)
        # if match:
        #     sql = match.group(1).strip()
        # else:
        #     sql = ""
        sql = self._parse_output(text)  # 使用静态解析器

        #更新state
        self.state["current_sql"] = sql

        # # 添加到对话历史
        # self.memory.add_message(state, "user", state["question"])
        # self.memory.add_message(state, "assistant", f"思考: {thinking}\nSQL: {sql}\n")
        return self.state