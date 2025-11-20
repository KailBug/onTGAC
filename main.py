import json
import pymysql
from decimal import Decimal
from datetime import datetime, date
from pathlib import Path
from typing import List, Dict
from colorama import  Fore, Style

from tool.mapping import Mapping

class DecimalEncoder(json.JSONEncoder):
    """
    自定义 JSON 编码器，用于处理 Decimal、datetime、date 类型。
    
    由于标准JSON编码器无法处理Decimal类型和日期时间类型，
    这个自定义编码器将这些特殊类型转换为JSON兼容的格式。
    """
    def default(self, obj):
        """
        重写default方法，处理特殊数据类型。
        
        Args:
            obj: 需要编码的对象
            
        Returns:
            编码后的值，如果无法处理则调用父类方法
        """
        if isinstance(obj, Decimal):
            # 检查 Decimal 值是否为整数（即小数点后全是零）
            # 如果是整数则转为int，否则转为float
            return int(obj) if obj == obj.to_integral_value() else float(obj)
        elif isinstance(obj, (datetime, date)):
            # 将日期时间对象转为ISO格式字符串
            return obj.isoformat()
        # 其他类型使用父类的默认处理方式
        return super().default(obj)

class execute_sql_with_pymysql:
    """
    SQL执行器类，用于通过pymysql连接MySQL数据库并执行SQL语句。
    
    这个类提供了两个主要功能：
    1. execute_sql_with_pymysql: 执行查询SQL并返回结果
    2. insert_data_with_pymysql: 执行insert语句
    """

    def __init__(self):
        pass

    def execute_sql_with_pymysql(self, input_file_path:str, output_file_path:str, db_config:Dict):
        """
        执行SQL查询语句的主要方法。
        
        从输入JSON文件中读取SQL语句列表，连接到数据库执行这些SQL，
        并将执行结果保存到输出JSON文件中。
        
        Args:
            input_file_path (str): 输入JSON文件路径，包含要执行的SQL语句，文件内部数据格式应为list[dict]
            output_file_path (str): 输出JSON文件路径，用于保存执行结果，文件保存格式为list[dict]
            db_config (dict): 数据库连接配置字典，包含host、user、password等
        """
        results = []  # 存储所有SQL执行结果的列表
        conn = None   # 数据库连接对象
        
        try:
            # 1. 连接数据库
            conn = pymysql.connect(**db_config)
            # 使用DictCursor以便返回字典形式的结果
            cursor = conn.cursor(pymysql.cursors.DictCursor)

            # 2. 读取输入 JSON 文件
            sql_list = json.loads(Path(input_file_path).read_text(encoding="utf-8"))
                
            # 验证输入数据格式是否正确
            if not isinstance(sql_list, list):
                print("错误：输入的 JSON 文件格式不正确，应为列表。")
                return
                
            # 3. 遍历SQL语句列表，逐个执行
            for item in sql_list:
                # 检查当前item是否包含sql字段
                if 'sql' in item:
                    print(f"正在执行{item['sql_id']}的sql")
                    sql_statement = item['sql']
                    try:
                        # 执行SQL语句
                        cursor.execute(sql_statement)
                        # 获取查询结果
                        query_result = cursor.fetchall()
                        # 对结果中的数字进行标准化处理
                        query_result = self.normalize_numbers_in_result(query_result)
                        # 将成功结果添加到结果列表
                        results.append({
                            "sql_id":item['sql_id'],
                            "sql": sql_statement,
                            "status": "success",
                            "insert": query_result
                        }) 
                    except pymysql.Error as e:
                        # 如果执行出错，记录错误信息
                        results.append({
                            "sql_id":item['sql_id'],
                            "sql": sql_statement,
                            "status": "error",
                            "error_message": str(e)
                        })
                else:
                    # 如果item缺少sql字段，记录格式错误
                    results.append({
                        "sql": None,
                        "status": "error",
                        "error_message": "JSON 元素缺少 'sql' 键"
                    })
        except FileNotFoundError:
            print(f"错误：文件未找到 - {input_file_path}")
            return
        except json.JSONDecodeError:
            print(f"错误：JSON 解码失败，请检查 {input_file_path} 文件格式。")
            return
        except pymysql.Error as e:
            # 处理数据库连接或操作异常
            print(f"数据库连接或操作错误：{e}")
            return
        finally:
            if conn:
                conn.close()

        # 5. 将结果写入输出 JSON 文件
        try:
            # 引入 pathlib 处理路径
            output_path = Path(output_file_path)
            output_path.parent.mkdir(parents=True, exist_ok=True) # 确保父级目录已经存在
            output_path.write_text(json.dumps(results, ensure_ascii = False, indent = 4, cls = DecimalEncoder),encoding="utf-8") # 写入文件
            print(f"执行结果已成功保存到 {output_file_path}")
        except Exception as e:
            # 捕获文件写入过程中可能发生的其他异常（如权限不足等）
            print(f"写入输出文件时发生错误：{e}")

    def insert_data_with_pymysql(self, input_file_path:str, output_file_path:str, db_config:Dict):
        """
        执行SQL插入语句的方法。
        
        从一个包含SQL插入语句的JSON文件中读取数据，连接到数据库执行这些SQL，
        并将执行结果保存到输出JSON文件中。与查询方法的主要区别是不需要返回查询结果。
        
        Args:
            input_file_path (str): 输入JSON文件路径，包含要执行的插入SQL语句,文件内部结果为list[dict]
            output_file_path (str): 输出JSON文件路径，用于保存执行结果,文件保存格式为list[dict]
            db_config (dict): 数据库连接配置字典
        """
        results = []  # 存储执行结果的列表
        conn = None   # 数据库连接对象

        try:
            # 1. 连接数据库
            conn = pymysql.connect(**db_config)
            cursor = conn.cursor(pymysql.cursors.DictCursor)

            # 2. 读取输入 JSON 文件
            sql_list = json.loads(Path(input_file_path).read_text(encoding="utf-8"))
            
            # 验证输入数据格式
            if not isinstance(sql_list, list):
                print("错误：输入的 JSON 文件格式不正确，应为列表。")
                return

            # 3. 遍历SQL语句列表，逐个执行
            for item in sql_list:
                # 检查当前item是否包含insert_sql字段
                if 'insert_sql' in item:
                    print(f"正在执行{item['sql_id']}的insert sql")
                    sql_statement = item['insert_sql']
                    try:
                        # 执行插入SQL语句
                        cursor.execute(sql_statement)
                        # 插入操作不需要返回结果，只记录状态
                        results.append({
                            "sql_id":item['sql_id'],
                            "insert_sql": sql_statement,
                            "status": "success",
                        })
                    except pymysql.Error as e:
                        # 记录执行错误
                        results.append({
                            "sql_id":item['sql_id'],
                            "insert_sql": sql_statement,
                            "status": "error",
                            "error_message": str(e)
                        })
                else:
                    # 记录格式错误
                    results.append({
                        "sql_id":item['sql_id'],
                        "insert_sql": None,
                        "status": "error",
                        "error_message": "JSON 元素缺少 'sql' 键"
                    })
                    
        except FileNotFoundError:
            print(f"错误：文件未找到 - {input_file_path}")
            return
        except json.JSONDecodeError:
            print(f"错误：JSON 解码失败，请检查 {input_file_path} 文件格式。")
            return
        except pymysql.Error as e:
            print(f"数据库连接或操作错误：{e}")
            return
        finally:
            # 确保数据库连接被关闭
            if conn:
                conn.close()

        # 5. 将结果写入输出 JSON 文件
        try:
            # 引入 pathlib 处理路径
            output_path = Path(output_file_path)
            output_path.parent.mkdir(parents=True, exist_ok=True) # 确保父级目录已经存在
            output_path.write_text(json.dumps(results, ensure_ascii = False, indent = 4),encoding="utf-8") # 写入文件
            print(f"执行结果已成功保存到 {output_file_path}")
        except Exception as e:
            # 捕获文件写入过程中可能发生的其他异常（如权限不足等）
            print(f"写入输出文件时发生错误：{e}")
    
    def normalize_numbers_in_result(self, result_list: List[Dict]) -> List[Dict]:
        """
        对查询结果中的数字进行标准化处理 (使用生成式精简版)。
        
        遍历查询结果，将float类型中实际为整数的值转为int，否则保留两位小数。
        """
        
        # 内部辅助函数，用于处理单个键值对的标准化逻辑
        def _normalize_value(value):
            if isinstance(value, float):
                # 如果是浮点数但无小数部分，则转为整数
                if value.is_integer():
                    return int(value)
                else:
                    # 保留两位小数
                    return round(value, 2)
            if isinstance(value, Decimal): # 针对Decimal类型，同样保留两位小数
                return round(value, 2)
            else:
                # 其他类型保持原样
                return value

        # 使用列表生成式迭代行 (row)，内部使用字典生成式迭代列 (key, value)
        normalized = [
            {
                key: _normalize_value(value)
                for key, value in row.items()
            }
            for row in result_list
        ]
        
        return normalized


if __name__ == '__main__':

    #模式变量 INSERT、 EXECUTE、 OTHER
    MODE  = "OTHER"

    sql_executor = execute_sql_with_pymysql()
    db_configuration = {
        'host': 'localhost',                    # 数据库主机地址
        'user': 'root',                         # 数据库用户名
        'password': '',                         # 数据库密码
        'db': 'kail0',                          # 数据库名称_final_algorithm_competition
        'port': 9030                            # starrocks访问端口
    }

    if MODE == "INSERT":
        # 执行插入操作
        print("执行插入操作")
        insert_file_path = "insert/insert_sql.json"
        insert_result_file_path = "insert/insert_result.json"
        sql_executor.insert_data_with_pymysql(insert_file_path, insert_result_file_path, db_config=db_configuration)
    elif MODE == "EXECUTE":
        # 执行查询操作
        print("执行查询操作")
        dataset_file_path = "data/final_dataset_with_mapping.json"
        dataset_result_file_path = "胡辣汤/dataset_exe_result.json"
        sql_executor.execute_sql_with_pymysql(dataset_file_path, dataset_result_file_path, db_config=db_configuration)
    elif MODE == "OTHER":
        #自定义操作
        print(Fore.GREEN+'执行自定义功能'+Style.RESET_ALL)
        schema_file_path = "data/schema.json"
        print(Fore.GREEN + schema_file_path + Style.RESET_ALL)
        Mapping = Mapping(schema_file_path)
        input_file_path = "data/final_dataset_pure.json"
        output_file_path = "data/final_dataset_with_mapping.json"
        Mapping.trans_final_mapping(input_file_path, output_file_path)
    else:
        print("未指定MODE: INSERT、 EXECUTE or OTHER.")
