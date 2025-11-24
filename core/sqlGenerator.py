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
        self.state = state
        self.user_prompt = self._generate_user_prompt()
        self.system_prompt = """
        
        """
        self.messages = []
        self.few_shot_examples = []
        self.response = None

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

    def _generate_user_prompt(self,):
        return f"""
                你是一位精通 starrocks/allin1-ubuntu:2.5.12 数据库的首席数据架构师。你的任务是将用户的自然语言问题转换为精确、高效的 SQL 查询。

                ### 1. 当前任务
                用户问题: {question}
                
                ### 2. 数据库 Schema 信息
                {schema}
        
                ### 3. 参考示例 (Few-shot)
                {few_shot_examples}
        
                ### 4. 对话上下文
                {history}                    
        
                ### 5. 核心指令 (必须严格遵守)
                1. **方言兼容**: 使用 StarRocks 3.1 语法（高度兼容 MySQL 协议）。注意日期函数的使用（如 `date_trunc`, `str_to_date` 等）需符合 StarRocks 规范。
                2. **Schema Linking**: 在生成 SQL 前，先仔细分析问题涉及的 Table 和 Column，不要通过幻觉生成不存在的字段。
                3. **格式约束**: 
                   - SQL 语句必须以 SELECT/INSERT/UPDATE/DELETE 开头。
                   - **严禁**使用 Markdown 代码块格式（如 ```sql ... ```），直接输出 SQL 文本。
                   - 确保 SQL 语句以分号 `;` 结尾。
        
                ### 6. 响应格式
                请严格按照以下格式输出，不要包含任何其他开场白或结束语：
        
                思考: [这里进行思维链推导：1.识别涉及的表和字段 -> 2.确定连接条件(JOIN) -> 3.确定筛选条件(WHERE) -> 4.确定聚合方式(GROUP BY)]
                SQL: [这里仅输出最终的 SQL 语句]
                """

    def _get_few_shot_examples(self):
        pass

    @retry(stop=stop_after_attempt(3), wait=wait_fixed(1))
    def _call_LLM(self):
        return Generation.call(
            model="qwen-coder-plus",
            messages=self.messages,
            result_format="message"
        )

    def build(self, state: AgentState) -> AgentState:
        """节点2: 思考并生成SQL (ReAct模式)"""
        few_shot_text = ""  # 准备Few-shot示例
        for item in Config.FEW_SHOT_EXAMPLES:
            few_shot_text += f"示例{item["sql_id"]}:\n"
            few_shot_text += f"\t问题:{item["question"]}\n"
            few_shot_text += f"\tSQL: {item['sql']}\n"
            few_shot_text += f"\tTable List: {item['table_list']}\n"
            few_shot_text += f"\tKnowledge: {item['knowledge']}\n"

        history = self.memory.get_recent_history(state)  # 获取对话历史

        prompt = self.react_prompt.format(  # 生成prompt
            question=state["question"],
            schema=state["schema"],
            few_shot_examples=few_shot_text,
            history=history
        )
        print(Fore.GREEN + "调用llm_cloud生成ing..." + Style.RESET_ALL)
        response = self.llm_cloud.invoke(prompt)

        sql = ""
        thinking = ""
        text = ""
        if isinstance(response, str):
            text = response
        else:
            text = getattr(response, 'content', str(response))

        # 正则表达式，其实也能达到_parse_output()的效果
        # match = re.search(r'(?i)sql[:：]\s*([\s\S]*?;)', text)
        # if match:
        #     sql = match.group(1).strip()
        # else:
        #     sql = ""

        sql = self._parse_output(text)  # 使用静态解析器

        state["sql"] = sql
        state["thinking"] = thinking
        state["action"] = "generate_sql"

        # 添加到对话历史
        self.memory.add_message(state, "user", state["question"])
        self.memory.add_message(state, "assistant", f"思考: {thinking}\nSQL: {sql}\n")

        return state