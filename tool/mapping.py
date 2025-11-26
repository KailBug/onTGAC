import json
import sys
import traceback
from colorama import Fore, Style

from core.agent import Agent
from core.agentState import AgentState

#打分前的最后一步,将题目映射为SQL，并保存到final_dataset_with_mapping.json
class Mapping:
    def __init__(self,schema_file_path: str):
        self.schema_file_path = schema_file_path

    def trans_final_mapping(self, input_file_path:str, output_file_path:str):
        """
        对final_dataset_pure.json使用该方法，将一个个问题映射为SQL语句，并存储到final_dataset_with_mapping.json.
        :param input_file_path: final_dataset_pure.json的路径
        :param output_file_path: final_dataset_with_mapping.json
        :return: 无返回值
        """

        agent = Agent(self.schema_file_path)

        graph = agent.build_graph()
        questions_data_mapping = []

        with open(input_file_path, "r", encoding="utf-8") as f:
            questions_data = json.load(f)

        for index, item in enumerate(questions_data, 1):
            sql_id  = item.get("sql_id")
            question = item.get("question")
            print(f"\n[{index}/{len(questions_data)} {sql_id}] Question: {question}")

            initial_state:AgentState = {
                "sql_id": item.get("sql_id"),  # id,初始化数据
                "query": item.get("question"),  # 原始问题,初始化数据
                "table_list": item.get("table_list"),  # json中的table_list，初始化数据
                "knowledge": item.get("knowledge"), # json中原始knowledge，初始化更新
                "复杂度": item.get("复杂度"),  # json中原始数据，初始化更新
                "schema": "",  # 检索到的Schema,rerank时更新
                "knowledge_rules": "",  # 相关知识,初始化数据,rerank时更新
                "thinking": "",  # 当前思考
                "action": "",  # 最近执行动作(generate_sql/execute_sql/fix_sql),node中更新
                "sql_state": "",  # success 或者 error,执行时更新
                "current_sql": "",  # 生成的SQL,refiner时更新
                "error_msg": "",  # 执行错误信息,执行时更新
                "execution_result": {},  # 执行结果
                "error_count": 0,  # 初始赋值为0,错误次数，当错误次数为3时停止,执行时更新
                "final_sql": ""  # 最终SQL,执行时更新，refined后更新，暂时不用这个字段
            }
            try:
                final_state = graph.invoke(initial_state)
                sql = final_state.get("sql")
                print(Fore.GREEN+f"生成SQL: {sql}"+Style.RESET_ALL)

                questions_data_mapping.append({
                    "sql_id":sql_id,
                    "question":question,
                    "sql":sql,
                    "复杂度":item.get("复杂度"),
                    "table_list":item.get("table_list"),
                    "knowledge":item.get("knowledge")
                })
            except Exception as e:
                print(Fore.RED + f"处理错误: {str(e)}" + Style.RESET_ALL)
                traceback.print_exc()
                if hasattr(e, "response"):
                    print(f"API Response Body: {e.response}")
                if hasattr(e, 'request'):
                    print(f"API Request URL: {e.request.url}")

                questions_data_mapping.append({
                    "sql_id": sql_id,
                    "question": question,
                    "sql": "",
                    "复杂度": item.get("复杂度"),
                    "table_list": item.get("table_list"),
                    "knowledge": item.get("knowledge")
                })
            sys.exit()


        with open(output_file_path, "w", encoding="utf-8") as f:
            json.dump(questions_data_mapping, f, ensure_ascii=False, indent=4)

        print(Fore.GREEN+f"\n处理结束，结果已保存到: {output_file_path}\n"+Style.RESET_ALL)