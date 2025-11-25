"""
暂时采用方案A
方案A:使用qwen-coder-plus
方案B:使用qwen-coder-plus + kimi-k2-thinking
"""
import re
import dashscope
from dashscope import Generation
from tenacity import retry, stop_after_attempt, wait_fixed

from core.config import Config
from core.agentState import AgentState

dashscope.api_key = Config.QWEN_API_KEY

class SQLRefiner:
    def __init__(self,state:AgentState):
        """
        接收AgentState，提取错误的SQL让LLM生成新的SQL，更新AgentState返回
        """
        self.state = state
        self.fix_prompt = self._generate_fix_prompt(
                                question=self.state.get("query"),
                                schema_info=self.state.get("schema"),
                                error_msg=self.state.get("error_msg"),
                                wrong_sql=self.state.get("current_sql"),
                                knowledge=self.state.get("knowledge_rules")
        )
        self.fix_system_prompt = """
            你是一位精通 starrocks/allin1-ubuntu:2.5.12 数据库的首席数据架构师,给用户生成的SQL查询执行错误，
            你的任务是根据**错误消息**和**提供的正确表模式**修复SQL，得到一个正确的SQL。
        """
        self.messages = messages=[
            {
                "role": "system",
                "content": f"{self.fix_system_prompt}"
            },
            {
                "role": "user",
                "content": f"{self.fix_prompt}",
            }
        ]
        self.response = None

    @retry(stop=stop_after_attempt(3), wait=wait_fixed(1))
    def _call_LLM(self):
        self.response = Generation.call(
            model="qwen-coder-plus",
            messages=self.messages,
            result_format="message"
        )

    def _generate_fix_prompt(self, question, wrong_sql, error_msg, schema_info, knowledge):
        """
        构造用于修复SQL的 Prompt
        """
        return f"""                                
                ### 内容
                - **用户问题**: {question}
                - **Table Schema**: {schema_info}
                
                ### 用户问题相关知识
                - **Knowledge**: {knowledge}
                
                ### 执行后反馈信息
                - **Error SQL**: {wrong_sql}
                - **报错信息**: {error_msg}
                
                ### Requirement
                1. 分析错误发生的原因（例如，列名错误、语法错误）。
                2. 仔细检查“Table Schema”以找到正确的列名或语法。
                3. 在"SQL:"后面只输出正确的SQL查询。
                4. 确保SQL与StarRocks v2.5.12兼容。
                
                ###请严格按照以下格式输出，不要包含任何其他开场白或结束语：            
                思考: [这里进行给出你的分析原因]
                SQL: [这里仅输出最终的 SQL 语句]
                """

    @staticmethod
    def _parse_output(response):
        """
        从模型输出中鲁棒地提取 SQL
        """
        text = []
        if isinstance(response, str):
            text = response
        else:
            #text = response.output.choices[0].message.content
            text = getattr(response, 'content', str(response))

        # 尝试提取 'SQL:' 之后的内容
        pattern = r"SQL:\s*(.*)"
        match = re.search(pattern, text, re.DOTALL)

        sql_content = ""
        if match:
            sql_content = match.group(1).strip()
        else:
            # 如果模型忘了写 'SQL:'，尝试找常见的 SQL 关键字
            sql_content = text.strip()

        # 清理可能残留的 Markdown,别再生成```sql了，尊敬的LLM大人...
        sql_content = sql_content.replace("```sql", "").replace("```", "").strip()

        # 清理行尾可能多余的解释性文字
        # 这里假设 SQL 以分号结尾，取最后一个分号之前的内容
        if ";" in sql_content:
            sql_content = sql_content.split(";")[0] + ";"

        return sql_content

    def build(self)->AgentState:
        self._call_LLM()
        current_sql = self._parse_output(self.response)
        #更新state
        self.state.current_sql = current_sql
        return self.state