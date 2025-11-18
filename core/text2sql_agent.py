import sys

from langchain_core.prompts import PromptTemplate
from langchain_ollama import OllamaLLM
from langgraph.graph import StateGraph, END
from colorama import Fore, Style

from core.config import Config
from core.schema_retriever import SchemaRetriever
from core.conversation_memory import ConversationMemory
from core.agent_state import AgentState

class Text2SQLAgent:
    """Agent节点定义"""
    def __init__(self,schema_file_path: str):
        self.llm = OllamaLLM(
            model=Config.QWEN_MODEL,
            base_url=Config.OLLAMA_BASE_URL,
            temperature=0.1
        )
        print(Fore.GREEN + "OllamaLLM构建完成" + Style.RESET_ALL)
        self.schema_retriever = SchemaRetriever(schema_file_path)
        print(Fore.GREEN + "SchemaRetriever构建完成" + Style.RESET_ALL)
        self.memory = ConversationMemory()
        print(Fore.GREEN + "ConversationMemory构建完成" + Style.RESET_ALL)
        self.react_prompt = PromptTemplate(
            input_variables=["question", "schema", "few_shot_examples", "history"],
            template="""你是一个专业的SQL生成专家,使用StarRocks 3.1数据库。

                    Few-shot示例:
                    {few_shot_examples}
                    
                    数据库Schema:
                    {schema}
                    
                    对话历史:
                    {history}
                    
                    当前问题: {question}
                    
                    请按照以下格式回答:
                    
                    思考: [你对问题的分析和SQL生成策略]
                    SQL: [生成的SQL语句,必须以SELECT/INSERT/UPDATE/DELETE开头]
                    
                    注意:
                    1. 只生成完整的SQL语句
                    2. 使用标准的StarRocks SQL语法
                    3. 确保表名和字段名正确
                    4. 思考并且SQL之间必须换行
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

    def retrieve_schema_node(self, state: AgentState) -> AgentState:
        """节点1: 检索相关Schema"""
        question = state["question"]
        schema = self.schema_retriever.retrieve(question, top_k=5)
        state["schema"] = schema
        # print(f"{Fore.GREEN}{state.get("schema")}{Style.RESET_ALL}")
        # sys.exit()
        state["error_count"] = 0
        state["conversation_history"] = []
        return state

    def think_and_generate_node(self, state: AgentState) -> AgentState:
        """节点2: 思考并生成SQL (ReAct模式)"""
        few_shot_text = ""      #准备Few-shot示例
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
        print(Fore.GREEN + "调用LLM生成ing..." + Style.RESET_ALL)
        response = self.llm.invoke(prompt)  #调用llm

        print(response)

        thinking = ""
        sql = ""
        lines = response.strip().split('\n')
        #调整返回的数据格式
        for i, line in enumerate(lines):
            if line.startswith('思考:'):
                thinking = line.replace('思考:', '').strip()
                if not thinking and i + 1 < len(lines):     #可能思考内容在下一行
                    thinking = lines[i + 1].strip()
            elif line.startswith('SQL:'):
                sql = line.replace('SQL:', '').strip()
                if not sql and i + 1 < len(lines):          #SQL可能在下一行
                    sql = lines[i + 1].strip()

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
