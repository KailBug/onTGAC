import re
from langchain_core.prompts import PromptTemplate
from langgraph.graph import StateGraph
from langchain_openai import ChatOpenAI
from colorama import Fore, Style
from tenacity import retry, stop_after_attempt, wait_fixed

from core.config import Config
from core.schema_retriever import SchemaRetriever
from core.conversation_memory import ConversationMemory
from core.agent_state import AgentState

class Text2SQLAgent:
    """Agent节点定义"""
    def __init__(self,schema_file_path: str):
        # self.llm = OllamaLLM(
        #     model=Config.QWEN_MODEL,
        #     base_url=Config.OLLAMA_BASE_URL,
        #     temperature=0.1
        # )
        self.llm_cloud = ChatOpenAI(
            model="qwen3-coder-480b-a35b-instruct",
            openai_api_key=Config.API_KEY,
            openai_api_base=Config.BASE_URL,
            temperature=0,
            #max_tokens=4096,
            timeout=60,                                 #设置云端超时限制，防止网络问题等待
        )
        print(Fore.GREEN + "llm_cloud构建完成" + Style.RESET_ALL)
        self.schema_retriever = SchemaRetriever(schema_file_path)
        print(Fore.GREEN + "SchemaRetriever构建完成" + Style.RESET_ALL)
        self.memory = ConversationMemory()
        print(Fore.GREEN + "ConversationMemory构建完成" + Style.RESET_ALL)
        self.react_prompt = PromptTemplate(
            input_variables=["question", "schema", "few_shot_examples", "history"],
            template="""你是一位精通 StarRocks 3.1 数据库的首席数据架构师。你的任务是将用户的自然语言问题转换为精确、高效的 SQL 查询。

                    ### 1. 数据库 Schema 信息
                    {schema}
            
                    ### 2. 参考示例 (Few-shot)
                    {few_shot_examples}
            
                    ### 3. 对话上下文
                    {history}
            
                    ### 4. 当前任务
                    用户问题: {question}
            
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
        )

        self.fix_prompt = PromptTemplate(
            input_variables=["sql", "error", "schema", "suggestion"],
            template="""之前生成的SQL执行出错,需要修复。

                    原SQL: {sql}
                    
                    错误信息: {error}
                    
                    修复建议: {suggestion}
                    
                    数据库Schema:
                    {schema}
                    
                    请生成修复后的SQL:
                    
                    思考: [分析错误原因]
                    SQL: [修复后的SQL语句]
                    """
        )
    @staticmethod
    def _parse_output(llm_response: str):
        """
        从模型输出中鲁棒地提取 SQL
        """
        #尝试提取 'SQL:' 之后的内容
        pattern = r"SQL:\s*(.*)"
        match = re.search(pattern, llm_response, re.DOTALL)

        sql_content = ""
        if match:
            sql_content = match.group(1).strip()
        else:
            #如果模型忘了写 'SQL:'，尝试找常见的 SQL 关键字
            sql_content = llm_response.strip()

        #清理可能残留的 Markdown,别再生成```sql了，尊敬的LLM大人
        sql_content = sql_content.replace("```sql", "").replace("```", "").strip()

        # 清理行尾可能多余的解释性文字
        # 这里假设 SQL 以分号结尾，取最后一个分号之前的内容
        if ";" in sql_content:
            sql_content = sql_content.split(";")[0] + ";"

        return sql_content

    def retrieve_schema_node(self, state: AgentState) -> AgentState:
        """节点:检索相关Schema"""
        question = state["question"]
        schema = self.schema_retriever.retrieve(question, top_k=5)
        state["schema"] = schema
        state["error_count"] = 0
        state["conversation_history"] = []
        return state

    @retry(stop=stop_after_attempt(3), wait=wait_fixed(1))
    def think_and_generate_node(self, state: AgentState) -> AgentState:
        """节点2: 思考并生成SQL (ReAct模式)"""
        few_shot_text = ""                                              #准备Few-shot示例
        for item in Config.FEW_SHOT_EXAMPLES:
            few_shot_text += f"示例{item["sql_id"]}:\n"
            few_shot_text += f"\t问题:{item["question"]}\n"
            few_shot_text += f"\tSQL: {item['sql']}\n"
            few_shot_text += f"\tTable List: {item['table_list']}\n"
            few_shot_text += f"\tKnowledge: {item['knowledge']}\n"

        history = self.memory.get_recent_history(state)     #获取对话历史

        prompt = self.react_prompt.format(                  #生成prompt
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

        #正则表达式，其实也能达到_parse_output()的效果
        # match = re.search(r'(?i)sql[:：]\s*([\s\S]*?;)', text)
        # if match:
        #     sql = match.group(1).strip()
        # else:
        #     sql = ""

        sql = self._parse_output(text)                      #使用静态解析器

        state["sql"] = sql
        state["thinking"] = thinking
        state["action"] = "generate_sql"

        # 添加到对话历史
        self.memory.add_message(state, "user", state["question"])
        self.memory.add_message(state, "assistant", f"思考: {thinking}\nSQL: {sql}\n")

        return state

    def route_next(self, state: AgentState) -> str:
        """路由到下一个节点"""
        action = state.get("action", "finish")
        if action == "execute_sql":
            return "execute"
        elif action == "fix_sql":
            return "fix"
        else:
            return "end"

    def build_graph(self) -> StateGraph:
        """构建LangGraph工作流"""
        workflow = StateGraph(AgentState)
        #添加节点
        workflow.add_node("retrieve_schema", self.retrieve_schema_node)
        workflow.add_node("think_and_generate", self.think_and_generate_node)
        # 设置入口
        workflow.set_entry_point("retrieve_schema")
        # 添加边
        workflow.add_edge("retrieve_schema", "think_and_generate")

        return workflow.compile()
