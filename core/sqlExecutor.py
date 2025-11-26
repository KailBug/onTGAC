"""
为了保持SQL处理过程一致，这里直接使用TGAC提供的官方normalize_numbers_in_result
修改如下：
1、删除了insert_data_with_pymysql方法
2、针对refiner需要的中间数据进行了对应修改，任何数据都不会进入dataset_exe_result.json
3、修改方法的输入输出，输入为单个SQL，输出为单个json，json中保存着执行结果
"""
import json
import pymysql
from decimal import Decimal
from datetime import datetime, date
from typing import Dict, List
from colorama import Fore, Style

from core.agentState import AgentState
from core.config import Config

#DecimalEncoder用于处理sql执行后返回的数据格式，保证精度和格式正确
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

#只传入SQL，state在node内根据execute_sql_with_pymysql返回值更新，不在SQLExecutor中更新
class SQLExecutor:
    """
    SQL执行器类，用于通过pymysql连接MySQL数据库并执行SQL语句。
    """
    def __init__(self, state:AgentState):
        self.state = state
        self.ret = None
        print(Fore.GREEN + "SQLExecutor.__init__完成" + Style.RESET_ALL)

    def _normalize_numbers_in_result(self, result_list: List[Dict]) -> List[Dict]:
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
            if isinstance(value, Decimal):  # 针对Decimal类型，同样保留两位小数
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

    def _execute_sql_with_pymysql(self, sql: str, db_config: Dict) -> dict:
        """
        连接到数据库执行传入的SQL字符串，并以字典形式直接返回结果。
        不涉及任何文件读写操作。
        Args:
            sql (str): 需要执行的SQL语句
            db_config (dict): 数据库连接配置字典，包含host、user、password等
        Returns:
            dict: 包含执行状态和结果的字典。
                  成功示例: {"status": "success", "sql": "...", "data": [...]}
                  失败示例: {"status": "error", "sql": "...", "error_message": "..."}
        """
        conn = None

        try:
            # 1. 连接数据库
            conn = pymysql.connect(**db_config)
            # 使用DictCursor以便返回字典形式的结果
            cursor = conn.cursor(pymysql.cursors.DictCursor)
            # 2. 执行SQL
            cursor.execute(sql)
            # 3. 获取查询结果
            query_result = cursor.fetchall()
            # 4. 对结果中的数字进行标准化处理 (调用原类中存在的方法)
            query_result = self._normalize_numbers_in_result(query_result)
            #处理sql执行后返回的数据格式，保证精度和格式正确
            result_str = json.dumps(query_result, ensure_ascii=False, indent=4, cls=DecimalEncoder)
            result = json.loads(result_str)
            # 5. 返回成功结果
            return {
                "sql": sql,
                "status": "execute_success",
                "insert": result
            }
        except pymysql.Error as e:
            # 处理数据库执行层面的错误 (如语法错误、表不存在等)
            return {
                "sql": sql,
                "status": "execute_error",
                "error_message": f"Error: {str(e)}"
            }
        except Exception as e:
            # 处理连接错误或其他意外异常
            return {
                "sql": sql,
                "status": "Unexpected_error",
                "error_message": f"Unexpected Error: {str(e)}"
            }
        finally:
            # 6. 确保关闭数据库连接
            if conn:
                conn.close()

    def build(self)->AgentState:
        #更新state
        self.ret = self._execute_sql_with_pymysql(self.state["current_sql"], Config.DB_CONFIG)
        self.state["sql_state"] = self.ret["status"]
        self.state["error_msg"] = self.ret.get("error_message","")
        if self.state["sql_state"] in ["execute_error", "Unexpected_error"]:
            self.state["error_count"] += 1
        return self.state