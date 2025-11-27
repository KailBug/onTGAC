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

    #Common Knowledge
    COMMON_KNOWLEDGE = """
                    # 腾讯游戏数据仓库知识库 (Domain Knowledge Base)
                    
                    在编写 SQL 时，**必须**严格遵守以下业务规则、表名解析逻辑和 ID 关联规范。
                    
                    ## 1. 核心业务映射 (Entity Mapping)
                    
                    当用户提到以下游戏或业务名词时，使用对应的表前缀或筛选条件：
                    
                    | 业务实体 (中文) | 数据库代号 (Gamecode/Prefix) | 识别逻辑/筛选条件 | 说明 |
                    | :--- | :--- | :--- | :--- |
                    | **砺刃使者** | `jordass` | 表名包含 `jordass` | FPS游戏，包含“乐园”UGC玩法 |
                    | **勇者盟约** | `argothek` | 表名包含 `argothek` | FPS端游 |
                    | **峡谷 / 峡谷行动** | `initiatived` | 在大盘表中筛选 `sgamecode = 'initiatived'` | 来源于竞品表字段描述“峡谷手游活跃 initiatived” |
                    | **乐园** | `jordass` | 表名包含 `jordass` 且涉及 UGC/子玩法模式 | 砺刃使者下的UGC玩法模式 |
                    | **手游大盘 / 平台大盘** | `mgamejp` | 表名包含 `mgamejp` | 代表所有游戏的集合数据 |
                    
                    ## 2. 表名解析规范 (Table Naming Convention)
                    
                    表名格式通常为：`分层_业务代号_业务含义_后缀` (例如 `dws_jordass_login_di`)。
                    
                    ### 2.1 分层 (Layer)
                    * **dwd (明细层)**: 存储每一条行为事件的明细记录（如每一笔充值、每一局对局）。
                    * **dws (汇总层)**: 存储玩家粒度或聚合粒度的数据（如日活跃、累计充值）。
                    * **dim (维度层)**: 存储维度配表（如 ID 映射、物品字典）。
                    
                    ### 2.2 后缀 (Suffix) - 时间与更新策略
                    * **_di (Daily Increment)**: **日增量表**，`d` 代表按天分区，`i` 代表每天存储增量数据。查询时**必须**指定日期分区 (e.g., `dtstatdate` 或 `statis_date`)。
                    * **_df (Daily Full)**: **日全量表**。每天存储历史至今的全量快照。查询时通常取时间周期的**最后一天**分区。
                    * **_hi (Hourly Increment)**: **小时增量表**。通常用于 `dwd` 流水，包含 `dteventtime`。
                    * **_nf (No Partition)**: **无分区表**。通常是静态维度表或 ID 映射表。
                    
                    ## 3. ID 关联与转换规范 (ID Join Logic)
                    
                    不同游戏使用独立的 ID 体系，跨游戏或查询大盘数据时，**严禁直接 JOIN 不同的 PlayerID**，必须通过中间表转换。
                    
                    ### 3.1 核心 ID 定义
                    * **vplayerid / gplayerid / iuserid**: 游戏角色 ID（单游戏内唯一）。
                    * **suserid**: 平台账号 ID（QQ号或微信号，跨游戏唯一）。
                    * **uid**: 游戏内具体的角色 UID。
                    
                    ### 3.2 跨表关联路径 (Standard Join Paths)
                    **场景 1：勇者盟约 (`argothek`) 关联 平台大盘 (`mgamejp`)**
                    * **步骤**: `dws_argothek...` (iuserid) -> **`dim_argothek_gplayerid2qqwxid_df`** -> `dws_mgamejp...` (suserid)
                    * **关联键**: 源表 `iuserid` 关联转换表 `iuserid`，获取 `suserid`
                    
                    **场景 2：砺刃使者 (`jordass`) 关联 平台大盘 (`mgamejp`)**
                    * **步骤**: `dws_jordass...` (vplayerid) -> **`dim_jordass_playerid2suserid_nf`** -> `dws_mgamejp...` (suserid)
                    * **关联键**: 源表 `vplayerid` 关联转换表 `vplayerid`，获取 `suserid`
                    
                    **场景 3：微信 ID 与 QQ ID 互通**
                    * 使用表 **`dim_mgamejp_idconversion_wxid_qq_nf`** 进行 `swxid` 和 `iqq` 的转换。
                    
                    ## 4. 常用字段规范 (Field Mapping)
                    
                    在编写 SQL 时，优先使用以下字段命名习惯：
                    
                    * **日期分区**:
                        * 通常为 `dtstatdate` 或 `statis_date` (格式 YYYYMMDD, 类型 bigint/string)。
                        * **注意**: 不要幻觉出 `ds` 或 `partition_date`，除非 Schema 明确列出。
                    * **平台类型 (`platid`)**:
                        * `0`: iOS
                        * `1`: Android
                        * `255`: 所有平台/不区分平台
                    * **账号类型 (`saccounttype`)**:
                        * 在查询大盘 `mgamejp` 表时，取 `-100` 代表汇总账号类型。
                    * **活跃位图 (`cbitmap`)**:
                        * 100位字符串，左侧第一位代表当天。`1`=有行为，`0`=无行为。常用于计算留存。
                    * **流水/金额**:
                        * **流水 (Log)**: 指 `dwd_` 开头的明细表日志。
                        * **流水 (Money)**: 指充值金额，字段通常为 `imoney` (元) 或 `iamount` (代币)。
                    ## 5. 常用知识说明
                    * **cbitmap**:100位0和1组成的字符串，左侧第一位代表当天。1表示有对应行为，比如活跃或付费，0 表示未发生对应行为，比如未活跃或未付费。常常使用该字段统计流失、回流、留存等指标
                    * **DAU**:日活跃用户数
                    * **留存**:以次留为例，表示当天活跃第二天依然活跃的用户定义为次留，其他留存以此类推
                    * **新进**:注册
                    """
    CORE_COMMON_KNOWLEDGE = """
                        
                        ## 1. 核心业务映射 (Entity Mapping)

                        | 业务实体 (中文) | 数据库代号 (Gamecode/Prefix) | 识别逻辑/筛选条件 | 说明 |
                        | :--- | :--- | :--- | :--- |
                        | **砺刃使者** | `jordass` | 表名包含 `jordass` | FPS游戏，包含“乐园”UGC玩法 |
                        | **勇者盟约** | `argothek` | 表名包含 `argothek` | FPS端游 |
                        | **峡谷 / 峡谷行动** | `initiatived` | 在大盘表中筛选 `sgamecode = 'initiatived'` | 来源于竞品表字段描述“峡谷手游活跃 initiatived” |
                        | **乐园** | `jordass` | 表名包含 `jordass` 且涉及 UGC/子玩法模式 | 砺刃使者下的UGC玩法模式 |
                        | **手游大盘 / 平台大盘** | `mgamejp` | 表名包含 `mgamejp` | 代表所有游戏的集合数据 |

                        ## 2. 表名解析规范 (Table Naming Convention)

                        表名格式通常为：`分层_业务代号_业务含义_后缀` (例如 `dws_jordass_login_di`)。

                        ### 2.1 分层 (Layer)
                        * **dwd (明细层)**: 存储每一条行为事件的明细记录（如每一笔充值、每一局对局）。
                        * **dws (汇总层)**: 存储玩家粒度或聚合粒度的数据（如日活跃、累计充值）。
                        * **dim (维度层)**: 存储维度配表（如 ID 映射、物品字典）。

                        ### 2.2 后缀 (Suffix) - 时间与更新策略
                        * **_di (Daily Increment)**: **日增量表**，`d` 代表按天分区，`i` 代表每天存储增量数据。查询时**必须**指定日期分区 (e.g., `dtstatdate` 或 `statis_date`)。
                        * **_df (Daily Full)**: **日全量表**。每天存储历史至今的全量快照。查询时通常取时间周期的**最后一天**分区。
                        * **_hi (Hourly Increment)**: **小时增量表**。通常用于 `dwd` 流水，包含 `dteventtime`。
                        * **_nf (No Partition)**: **无分区表**。通常是静态维度表或 ID 映射表。

                        
                        ## 3. 常用知识说明
                        * **cbitmap**:100位0和1组成的字符串，左侧第一位代表当天。1表示有对应行为，比如活跃或付费，0 表示未发生对应行为，比如未活跃或未付费。常常使用该字段统计流失、回流、留存等指标
                        * **DAU**:日活跃用户数
                        * **留存**:以次留为例，表示当天活跃第二天依然活跃的用户定义为次留，其他留存以此类推
                        * **新进**:注册
                        """