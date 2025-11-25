import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    def __init__(self):
        pass
    #alibaba-llm配置
    QWEN_API_KEY = os.getenv("DASHSCOPE_API_KEY")
    QWEN_BASE_URL = os.getenv("DASHSCOPE_BASE_URL")
    #moonshot-llm配置
    KIMI_API_KEY = os.getenv("MOONSHOT_API_KEY")
    KIMI_BASE_URL = os.getenv("MOONSHOT_BASE_URL")
    #StarRocks数据库配置
    DB_CONFIG = {
        'host': 'localhost',                    # 数据库主机地址
        'user': 'root',                         # 数据库用户名
        'password': '',                         # 数据库密码
        'db': 'kail0',                          # 数据库名称_final_algorithm_competition
        'port': 9030,                           # starrocks访问端口
        'charset': 'utf8mb4'
    }
    #阿里官方text-embedding-v4模型向量化的batch_size大小
    EMBEDDING_BATCH_SIZE = 10
    #记忆窗口大小
    MEMORY_WINDOW_SIZE = 3
    #中间文件位置
    DDL_embedding_cache_file_path: str = "data/DDL_embedding.npy"
    DDL_faiss_index_cache_file_path: str = "data/DDL_index.faiss"
    schemaddl_file_path: str = "data/schemaDDL.jsonl"
    schemaddl_index_file_path: str = "data/schemaDDLindex.jsonl"
    schemaddl_mapping_file_path: str = "data/schemaDDLmapping.json"
    #Few-shot示例
    FEW_SHOT_EXAMPLES = [
        {
            "sql_id": "sql_34",
            "question": "统计2024.9.17-2024.9.23 和 2024.10.8-2024.10.14    每天点击按钮后加入玩法，再之后点击确认的人数，以及这些人加入玩法的次数                                                       \n输出：日期(20240917、...、20240923、20241008、...、20241014)，人数，人次",
            "sql": "select\n    ds,\n    count(distinct vplayerid) as user_cnt,\n    count(distinct vplayerid, irank) as user_times\nfrom (\n    select\n        s2.ds,\n        s2.vplayerid,\n        s2.irank\n    from (\n        -- 获取411111事件（点击按钮）\n        select\n            dtstatdate as ds,\n            vplayerid,\n            dteventtime\n        from dws_jordass_buttonpress_pre_di\n        where buttontype = 411111\n        and  ((dtstatdate between '20240917' and '20240923') or (dtstatdate between '20241008' and '20241014'))\n    ) s1\n    join (\n        -- 获取411120事件（加入玩法）并编号\n        select\n            dtstatdate as ds,\n            vplayerid,\n            dteventtime,\n            row_number() over (partition by vplayerid order by dteventtime) as irank\n        from dws_jordass_buttonpress_pre_di\n        where buttontype = 411120\n        and ((dtstatdate between '20240917' and '20240923') or (dtstatdate between '20241008' and '20241014'))\n    ) s2 on s1.vplayerid = s2.vplayerid and s1.ds = s2.ds and s2.dteventtime > s1.dteventtime\n    join (\n        -- 获取411123事件（确认动作）\n        select\n            dtstatdate as ds,\n            vplayerid,\n            dteventtime\n        from dws_jordass_buttonpress_pre_di\n        where buttontype = 411123\n        and ((dtstatdate between '20240917' and '20240923') or (dtstatdate between '20241008' and '20241014'))\n    ) s3 on s2.vplayerid = s3.vplayerid and s2.ds = s3.ds and s3.dteventtime > s2.dteventtime\n)f \ngroup by ds\n;",
            "复杂度": "简单",
            "table_list": [
                "dws_jordass_buttonpress_pre_di"
            ],
            "knowledge": "buttontype为411111代表点击按钮，411120代表加入玩法，411123代表确认",
        }

    ]