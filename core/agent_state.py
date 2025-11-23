from typing import TypedDict, Dict, Annotated, List, NotRequired

class AgentState(TypedDict):
    query: str  # 原始问题
    schema: str  # 检索到的Schema
    thinking: str  # 当前思考
    action: str  # 当前动作(generate_sql/execute_sql/fix_sql)
    current_sql: str  # 生成的SQL
    execution_result: NotRequired[Dict]  # 执行结果
    error_count: NotRequired[int]  # 错误次数
    final_sql: NotRequired[str]  # 最终SQL
    conversation_history:NotRequired[List[Dict[str, str]]]