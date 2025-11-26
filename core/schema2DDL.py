import json
from colorama import Fore, Style

from core.config import Config

class Schema2DDL:
    def __init__(self, schema_data:list[dict]):
        '''
        初始化
        :param schema_data: schema数据
        :param schemaddl_file_path: 保存DDL数据文件路径
        '''
        self.schema_data = schema_data
        self.schema_length = len(self.schema_data)
    def build(self):
        '''
        执行函数,将加载到schema_data的schema数据中的每一项处理为DDL，再存入schemaDDL_file_path所指定的文件中,同时保存了对应的索引文件
        :return:无返回值
        '''
        DDL_corpus = []
        DDL_index = []
        DDL_mapping = {}
        for item in self.schema_data:
            DDL = self._generate_DDL_from_item(item)
            DDL_corpus.append(DDL)
            DDL_index.append(item.get("table_name",""))
            DDL_mapping[item.get("table_name","")] = DDL
        #检查是否数目一致，否则计算错误
        if len(DDL_corpus) == self.schema_length:
            with open(Config.schemaddl_file_path, "w", encoding='utf-8') as f:
                f.writelines(f"{json.dumps(s)}\n" for s in DDL_corpus)
            with open(Config.schemaddl_index_file_path, "w", encoding='utf-8') as f:
                f.writelines(f"{json.dumps(s)}\n" for s in DDL_index)
            with open(Config.schemaddl_mapping_file_path, 'w', encoding='utf-8') as f:
                json.dump(DDL_mapping, f, ensure_ascii=False, indent=2)
        else:
            print(f"{Fore.RED}DDL数目:{len(DDL_corpus)} != schema数目:{len(self.schema_data)}{Style.RESET_ALL}")


    def _generate_DDL_from_item(self, item:dict) -> str:
        '''
        将json格式的schema转变成DDL
        :param item: schema的某一个json项输入
        :return: 一个DDL
        '''
        table_name = item.get("table_name", "unknown_table")
        table_desc = item.get("table_description", "")
        columns = item.get("columns", [])

        #开始构建 DDL，将表名和表描述结合，有助于模型理解表的整体含义
        ddl_lines = [f"CREATE TABLE {table_name} ("]

        for col_item in columns:
            col_name = col_item.get("col", "")
            col_type = col_item.get("type", "")
            col_desc = col_item.get("description", "")

            #构建列定义，格式: col_name col_type COMMENT 'col_desc',
            line = f"  {col_name} {col_type}"
            if col_desc:
                #清洗一下描述中的特殊字符，防止 SQL 语法错误
                clean_desc = col_desc.replace("'", "")
                line += f" COMMENT '{clean_desc}'"
            line += ","
            ddl_lines.append(line)

        #处理结尾
        if columns:
            ddl_lines[-1] = ddl_lines[-1].rstrip(",")  # 移除最后一列的逗号

        #将表描述也加到 DDL 的 COMMENT 中
        ddl_lines.append(f") COMMENT '{table_desc}';")

        return "\n".join(ddl_lines)
