"""
把generator从agent抽离出来
将用于生成sql的prompt和LLM都放到这里
"""
import json
import re
import dashscope
from dashscope import Generation
from tenacity import retry, stop_after_attempt, wait_fixed
from colorama import Fore, Style
from http import HTTPStatus

from core.config import Config
from core.agentState import AgentState

dashscope.api_key = Config.QWEN_API_KEY

class SQLGenerator:
    def __init__(self):
        self.system_prompt = f"""
            你是一位精通 starrocks/allin1-ubuntu:2.5.12 数据库的首席数据架构师。
            你的任务是将用户的自然语言问题转换为正确的 SQL 查询。
            **下面是你工作时使用的知识和SQL生成规则**:
            
            {Config.COMMON_KNOWLEDGE}
            """
        self.response = None
        self.messages = None
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

    def _generate_user_prompt(self,question,schema,knowledge_rules,table_list_ddl):
        return f"""                
                ### 1. 用户问题: {question}                             
                
                ### 2. Schema 表信息: {schema}
                                     {table_list_ddl}
                
                ### 3. 执行的过滤条件: {knowledge_rules}                                 
        
                ### 4. 核心指令 (必须严格遵守)
                 **方言兼容**: 使用 StarRocks v2.5.12 语法;
                 **Schema Linking**: 在生成SQL前，先仔细分析问题涉及的Table和Column，在生成的SQL中使用的Table和Column必须在Schema信息表中**真实存在**;
                 **格式约束**: 确保 SQL 语句以分号 `;` 结尾;
        
                ### 5. 响应格式
                严格按照以下格式输出，不要包含任何其他内容:
        
                SQL: [这里仅输出最终的 SQL 语句]
                """

    def _get_few_shot_examples(self):
        #暂时采用静态few-shot
        return Config.FEW_SHOT_EXAMPLES

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

    @retry(stop=stop_after_attempt(3), wait=wait_fixed(1))
    def _call_LLM(self):
        return Generation.call(
            model="qwen3-coder-480b-a35b-instruct",
            messages=self.messages,
            result_format="message"
        )

    def build(self, state:AgentState):
        #few_shot_examples = self._get_few_shot_examples()      暂时先不用table_list
        user_prompt = self._generate_user_prompt(
            question=state.get("query"),
            schema=state.get("schema"),
            knowledge_rules=state.get("knowledge_rules"),
            table_list_ddl=self._get_table_list_ddl(state.get("table_list"))
        )
        self.messages = [{
            "role": "system",
            "content": f"{self.system_prompt}"
            },
            {
                "role": "user",
                "content": f"{user_prompt}",
            }]
        # 1. 调用大模型
        self.response = self._call_LLM()
        sql = ""
        text = ""
        # 2. 处理响应结果
        if isinstance(self.response, str):
            # 如果 mock 或者某些特殊情况直接返回了字符串
            text = self.response
        # 检查是否是 DashScope 的响应对象 (通常包含 status_code)
        elif hasattr(self.response, 'status_code'):
            if self.response.status_code == HTTPStatus.OK:
                # 路径: response -> output -> choices列表 -> 第一个元素 -> message -> content
                try:
                    text = self.response.output.choices[0].message.content
                except (AttributeError, IndexError, KeyError) as e:
                    print(f"API返回结构异常: {e}")
                    text = ""
            else:
                # 失败时，打印错误码和信息
                code = getattr(self.response, 'code', 'Unknown')
                msg = getattr(self.response, 'message', 'Unknown Error')
                print(f"API调用失败: Code={code}, Message={msg}")
                text = ""
        else:
            # 兜底逻辑：既不是字符串，也不是标准响应对象
            text = str(self.response)
        # 3. 解析文本提取 SQL
        # 增加一个非空判断，防止把空字符串传给解析器导致报错
        if text:
            sql = self._parse_output(text)
        else:
            print(f"{Fore.RED}警告: 模型输出为空或API出错，无法解析SQL{Style.RESET_ALL}")
            sql = ""  # 或者设置为 "SELECT 1" 等 fallback SQL
        print(f"{Fore.BLUE}SQLGenerator.build(){Style.RESET_ALL}")
        return sql