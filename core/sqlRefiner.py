"""
暂时采用方案A
方案A:使用qwen-coder-plus
方案B:使用qwen-coder-plus + kimi-k2-thinking
"""
import json
import re
from http import HTTPStatus
from tenacity import retry, stop_after_attempt, wait_fixed
from colorama import Fore, Style
from openai import OpenAI

from core.config import Config
from core.agentState import AgentState

class SQLRefiner:
    def __init__(self):
        """
        接收AgentState，提取错误的SQL让LLM生成新的SQL，更新AgentState返回
        """
        self.fix_system_prompt = f"""
            你是一位精通 starrocks/allin1-ubuntu:2.5.12 数据库的首席数据架构师,
            你的任务是根据**错误消息**和**提供的正确表模式**修复SQL，得到一个正确的SQL。
            
            ## 下面是你掌握的业务知识和使用的SQL生成规则:
            {Config.COMMON_KNOWLEDGE}
        """
        self.response = None
        self.messages = None
        print(Fore.GREEN + "SQLRefiner.__init__完成" + Style.RESET_ALL)

    @retry(stop=stop_after_attempt(3), wait=wait_fixed(1))
    def _call_LLM(self):
        client = OpenAI(
            api_key=Config.KIMI_API_KEY,
            base_url=Config.KIMI_BASE_URL,
        )

        try:
            completion = client.chat.completions.create(
                # 注意：Kimi 标准公开模型通常为 "moonshot-v1-8k" 等。
                model="kimi-k2-thinking-turbo",
                messages=self.messages,
                temperature=0.1,  # SQL 修复任务建议降低温度以保证严谨性
            )
            # 直接提取内容字符串赋值给 self.response
            # 下游的 _parse_output 方法中有 `if isinstance(response, str)` 的判断，可以完美兼容
            self.response = completion.choices[0].message.content

        except Exception as e:
            print(f"{Fore.RED}Kimi API Call Error: {e}{Style.RESET_ALL}")
            # 抛出异常以触发 @retry 重试机制
            raise e

    def _generate_fix_prompt(self, question, wrong_sql, error_msg, schema_info, knowledge,table_list_ddl):
        """
        构造用于修复SQL的 Prompt
        """
        return f"""                
                **用户原始问题**: {question}
                **Table和Schema信息**: {schema_info}
                                  {table_list_ddl}
                
                **执行的过滤条件**:{knowledge}               
                
                **执行后的报错信息**: {error_msg}
                **执行失败的SQL语句**: {wrong_sql}
                
                ### 严格核心指令
                1. 根据报错信息，仔细检查Table Schema中的信息，找到正确的Table和Column名称，新生成的SQL中使用的Table和Column必须**真实存在**;
                2. 确保生成的SQL以";"结尾;
                3. 确保SQL与StarRocks v2.5.12兼容。
                
                ###严格按照以下格式输出，不要包含任何其他内容：            
                SQL: [这里仅输出最终的 SQL 语句]
                """

    def _get_table_list_ddl(self, table_list):
        """根据 table_list 从 json 映射文件中提取 DDL 并合并为一个字符串。"""
        try:
            # 读取 JSON 文件
            with open(Config.schemaddl_mapping_file_path, 'r', encoding='utf-8') as f:
                ddl_mapping = json.load(f)

            result_parts = []
            # 遍历列表并提取 DDL
            for table_name in table_list:
                if table_name in ddl_mapping:
                    ddl_content = ddl_mapping[table_name]
                    # 可以在这里加一个注释头，方便区分（可选）
                    result_parts.append(f"{table_name}\n{ddl_content}")
                else:
                    # 如果找不到对应的表，记录一条警告注释
                    result_parts.append(f"")
            # 4用换行符拼接所有 DDL
            return "\n\n".join(result_parts)

        except json.JSONDecodeError:
            return f"Error: 文件 '{Config.schemaddl_mapping_file_path}' 不是有效的 JSON 格式。"
        except Exception as e:
            return f"Error: 发生未知错误 - {str(e)}"

    @staticmethod
    def _parse_output(response):
        """
        从模型输出中鲁棒地提取 SQL
        """
        text = ""
        # 1. 字符串情况 (Mock 或 已经提取过的内容)
        if isinstance(response, str):
            text = response
        # 2. DashScope 响应对象情况
        elif hasattr(response, 'status_code'):
            if response.status_code == HTTPStatus.OK:
                try:
                    text = response.output.choices[0].message.content
                except (AttributeError, KeyError, IndexError):
                    # 如果返回结构不符合预期，降级为字符串
                    text = str(response)
            else:
                # API 调用失败，打印日志并返回空字符串
                code = getattr(response, 'code', 'Unknown')
                msg = getattr(response, 'message', 'Unknown Error')
                print(f"Refiner API Error: {code} - {msg}")
                return ""  # 无法提取 SQL，直接返回空
        # 3. 其他未知类型兜底
        else:
            text = str(response)
        # 如果 text 为空，直接返回
        if not text:
            return ""

        # 尝试提取 'SQL:' 之后的内容
        pattern = r"SQL:\s*(.*)"
        match = re.search(pattern, text, re.DOTALL)

        sql_content = ""
        if match:
            sql_content = match.group(1).strip()
        else:
            # 如果模型忘了写 'SQL:'，尝试找常见的 SQL 关键字
            sql_content = text.strip()

        # 清理可能残留的 Markdown,例如```sql
        sql_content = sql_content.replace("```sql", "").replace("```", "").strip()

        # 清理行尾可能多余的解释性文字
        # 这里假设 SQL 以分号结尾，取最后一个分号之前的内容
        if ";" in sql_content:
            sql_content = sql_content.split(";")[0] + ";"

        return sql_content

    def build(self, state:AgentState):
        fix_prompt = self._generate_fix_prompt(
            question=state.get("query"),
            schema_info=state.get("schema"),
            error_msg=state.get("error_msg"),
            wrong_sql=state.get("current_sql"),
            knowledge=state.get("knowledge_rules"),
            table_list_ddl=self._get_table_list_ddl(state.get("table_list"))
        )
        self.messages = [
            {
                "role": "system",
                "content": f"{self.fix_system_prompt}"
            },
            {
                "role": "user",
                "content": f"{fix_prompt}",
            }
        ]
        self._call_LLM()
        current_sql = self._parse_output(self.response)
        print(f"{Fore.BLUE}SQLRefiner.build(){Style.RESET_ALL}")
        return current_sql
