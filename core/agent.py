from langgraph.graph import StateGraph, END

from core.schemaRetriever import SchemaRetriever
from core.agentState import AgentState
from core.sqlExecutor import SQLExecutor
from core.sqlGenerator import SQLGenerator
from core.sqlRefiner import SQLRefiner


class Agent:
    """Agent节点定义"""
    def __init__(self,schema_file_path: str):
        self.schema_file_path = schema_file_path
        self.schemaRetriever = SchemaRetriever(schema_file_path=self.schema_file_path)
        self.sqlGenerator = SQLGenerator()
        self.sqlExecutor = SQLExecutor()
        self.sqlRefiner = SQLRefiner()
    # 更新state
    def schema_retrieve_node(self, state: AgentState) -> AgentState:
        knowledge_rules, schema = self.schemaRetriever.build(state=state)
        state["knowledge_rules"] = knowledge_rules
        state["schema"] = schema
        return state
    # 更新state
    def sql_generate_node(self, state: AgentState) -> AgentState:
        sql = self.sqlGenerator.build(state=state)
        state["current_sql"] = sql
        return state
    # 更新state
    def sql_execute_node(self, state: AgentState) -> AgentState:
        sql_state, error_msg, error_count = self.sqlExecutor.build(state=state)
        state["sql_state"] = sql_state
        state["error_count"] = error_count
        state["error_msg"] = error_msg
        return state
    # 更新state
    def sql_refine_node(self, state: AgentState) -> AgentState:
        sql = self.sqlRefiner.build(state=state)
        state["current_sql"] = sql
        return state
    @staticmethod
    def route_next(state: AgentState) -> str:
        error_count = state.get("error_count")
        sql_state = state.get("sql_state")
        # 优先级 1: 如果已经尝试了3次（或者当前是第3次失败），停止尝试
        if error_count >= 3:
            return END
        # 优先级 2: 错误处理循环
        if sql_state in ["execute_error", "Unexpected_error"]:
            return "sql_refine_node"
        return END

    def build_graph(self):
        workflow = StateGraph(AgentState)
        # 1. 添加节点
        workflow.add_node("schema_retrieve_node", self.schema_retrieve_node)
        workflow.add_node("sql_generate_node", self.sql_generate_node)
        workflow.add_node("sql_execute_node", self.sql_execute_node)
        workflow.add_node("sql_refine_node", self.sql_refine_node)

        # 2. 设置流程起点：schema_retrieve_node
        workflow.set_entry_point("schema_retrieve_node")

        # 3. 添加确定性边 (Deterministic Edges)
        # Schema -> Generate
        workflow.add_edge("schema_retrieve_node", "sql_generate_node")

        # Generate -> Execute
        workflow.add_edge("sql_generate_node", "sql_execute_node")

        # Refine -> Execute (这是修正后的闭环),修正完 SQL 后，必须再次去执行验证
        workflow.add_edge("sql_refine_node", "sql_execute_node")

        # 4. 添加条件边 (Conditional Edges),从 Execute 节点出来后，需要判断是结束还是去 Refine
        workflow.add_conditional_edges(
            source="sql_execute_node",  # 从哪个节点出来
            path=self.route_next,  # 调用哪个逻辑函数
            path_map={  # 函数返回值映射到节点名
                "sql_refine_node": "sql_refine_node",
                END: END
            }
        )
        # 5. 编译
        return workflow.compile()