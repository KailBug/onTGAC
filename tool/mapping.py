import json
import traceback
from colorama import Fore, Style

from core.text2sql_agent import Text2SQLAgent
from core.agent_state import AgentState

#打分前的最后一步,将题目映射为SQL，并保存到final_dataset_with_mapping.json
class Mapping:
    def __init__(self,schema_file_path: str):
        self.schema_file_path = schema_file_path
        print(Fore.GREEN + self.schema_file_path + " - Mapping 构建完成" + Style.RESET_ALL)
    def trans_final_mapping(self, input_file_path:str, output_file_path:str):
        """
        对final_dataset_pure.json使用该方法，将一个个问题映射为SQL语句，并存储到final_dataset_with_mapping.json.
        :param input_file_path: final_dataset_pure.json的路径
        :param output_file_path: final_dataset_with_mapping.json
        :return: 无返回值
        """
        print(Fore.GREEN + "进入trans_final_mapping" + Style.RESET_ALL)
        agent = Text2SQLAgent(self.schema_file_path)
        print(Fore.GREEN + "Agent构建完成" + Style.RESET_ALL)
        graph = agent.build_graph()
        print(Fore.GREEN + "Graph构建完成" + Style.RESET_ALL)
        questions_data_mapping = []

        with open(input_file_path, "r", encoding="utf-8") as f:
            questions_data = json.load(f)
            print(f"{Fore.GREEN}加载question_data: len(question_data) = {len(questions_data)}{Style.RESET_ALL}")

        for index, item in enumerate(questions_data, 1):
            sql_id  = item.get("sql_id","sql_id_error")
            question = item.get("question", "question_error")
            print(f"\n[{index}/{len(questions_data)} {sql_id}] Question: {question}")

            initial_state:AgentState = {
                "question": question,
                "schema":"",
                "thinking":"",
                "action":"",
                "sql":"",
                "execution_result":{},
                "error_count":0,
                "final_sql":"",
                "conversation_history":[]
            }
            try:
                final_state = graph.invoke(initial_state)
                sql = final_state.get("sql","")
                print(Fore.GREEN+f"生成SQL: {sql}"+Style.RESET_ALL)

                questions_data_mapping.append({
                    "sql_id":sql_id,
                    "question":question,
                    "sql":sql,
                    "复杂度":item.get("复杂度","复杂度_error"),
                    "table_list":item.get("table_list","table_list_error"),
                    "knowledge":item.get("knowledge","knowledge_error")
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
                    "复杂度": item.get("复杂度","复杂度_error"),
                    "table_list": item.get("table_list","table_list_error"),
                    "knowledge": item.get("knowledge","knowledge_error")
                })


        with open(output_file_path, "w", encoding="utf-8") as f:
            json.dump(questions_data_mapping, f, ensure_ascii=False, indent=4)

        print(Fore.GREEN+f"\n处理结束，结果已保存到: {output_file_path}\n"+Style.RESET_ALL)