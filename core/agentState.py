from typing import TypedDict, Dict, Annotated, List, NotRequired

class AgentState(TypedDict):
    sql_id: str  # id,初始化数据
    query: str  # 原始问题,初始化数据
    schema: list  # 检索到的Schema,rerank时更新
    knowledge_rules: str  #相关知识,初始化数据,rerank时更新
    thinking: NotRequired[str]  # 当前思考
    action: NotRequired[str]  # 最近执行动作(generate_sql/execute_sql/fix_sql),node中更新
    sql_state: str #success 或者 error,执行时更新
    current_sql: str  # 生成的SQL,refiner时更新
    error_msg: NotRequired[str] #执行错误信息,执行时更新
    execution_result: NotRequired[Dict] # 执行结果
    error_count: int # 初始赋值为0,错误次数，当错误次数为3时停止,执行时更新
    final_sql: NotRequired[str]  # 最终SQL,执行时更新，refined后更新，暂时不用这个字段
    conversation_history:NotRequired[List[Dict[str, str]]]