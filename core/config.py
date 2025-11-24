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
            "sql_id": "sql_28",
            "question": "统计各个玩法上线首周留存情况\n输出：玩法、上线首周首次玩的日期、第几天留存（0,1,2...7)、玩法留存用户数\n\n各玩法首周上线日期：\n\"广域战场\": \"20240723\",\n\"消灭战\": \"20230804\",\n\"幻想混战\": \"20241115\",\n\"荒野传说\": \"20240903\",\n\"策略载具\": \"20241010\",\n\"炎夏混战\": \"20240625\",\n\"单人装备\": \"20240517\",\n\"交叉堡垒\": \"20240412\"",
            "sql": "select  a.itype,\n        a.dtstatdate,\n        datediff(b.dtstatdate,a.dtstatdate) as idaynum,\n        count(distinct a.vplayerid)           as iusernum\nfrom (                      \n    select\n        itype,\n        min(dtstatdate) as dtstatdate,\n        vplayerid\n    from  (\n        select '广域战场'      as itype,\n                min(dtstatdate) as dtstatdate,\n                vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20240723' and dtstatdate <= date_add('20240723',6)\n        and submodename = '广域战场模式'\n        group by vplayerid\n\n        union all\n        select '消灭战', min(dtstatdate), vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20230804' and dtstatdate <= date_add('20230804',6)\n        and modename='组队竞技' and submodename like '%消灭战模式%'\n        group by vplayerid\n\n        union all\n        select '幻想混战', min(dtstatdate), vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20241115' and dtstatdate <= date_add('20241115',6)\n        and modename='创意创作间' and submodename='幻想混战'\n        group by vplayerid\n\n        union all\n        select '荒野传说', min(dtstatdate), vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20240903' and dtstatdate <= date_add('20240903',6)\n        and modename='休闲模式' and submodename in ('荒野传说','荒野沙漠')\n        group by vplayerid\n\n        union all\n        select '策略载具', min(dtstatdate), vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20241010' and dtstatdate <= date_add('20241010',6)\n        and modename='休闲模式' and submodename like '%策略载具%'\n        group by vplayerid\n\n        union all\n        select '炎夏混战', min(dtstatdate), vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20240625' and dtstatdate <= date_add('20240625',6)\n        and modename='创意创作间' and submodename like '%炎夏混战%'\n        group by vplayerid\n\n        union all\n        select '单人装备', min(dtstatdate), vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20240517' and dtstatdate <= date_add('20240517',6)\n        and modename='组队竞技' and submodename like '%单人装备%'\n        group by vplayerid\n\n        union all\n        select '交叉堡垒', min(dtstatdate), vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20240412' and dtstatdate <= date_add('20240412',6)\n        and modename='组队竞技' and submodename like '%交叉堡垒%'\n        group by vplayerid\n    ) t\n    group by itype, vplayerid\n) a\nleft join (\n        select '广域战场' as itype, dtstatdate, vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20240723' and dtstatdate <= date_add('20240723',13)\n          and submodename = '广域战场模式'\n        group by dtstatdate, vplayerid\n\n        union all\n        select '消灭战', dtstatdate, vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20230804' and dtstatdate <= date_add('20230804',13)\n          and modename='组队竞技' and submodename like '%消灭战模式%'\n        group by dtstatdate, vplayerid\n\n        union all\n        select '幻想混战', dtstatdate, vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20241115' and dtstatdate <= date_add('20241115',13)\n          and modename='创意创作间' and submodename='幻想混战'\n        group by dtstatdate, vplayerid\n\n        union all\n        select '荒野传说', dtstatdate, vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20240903' and dtstatdate <= date_add('20240903',13)\n          and modename='休闲模式' and submodename in ('荒野传说','荒野沙漠')\n        group by dtstatdate, vplayerid\n\n        union all\n        select '策略载具', dtstatdate, vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20241010' and dtstatdate <= date_add('20241010',13)\n          and modename='休闲模式' and submodename like '%策略载具%'\n        group by dtstatdate, vplayerid\n\n        union all\n        select '炎夏混战', dtstatdate, vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20240625' and dtstatdate <= date_add('20240625',13)\n          and modename='创意创作间' and submodename like '%炎夏混战%'\n        group by dtstatdate, vplayerid\n\n        union all\n        select '单人装备', dtstatdate, vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20240517' and dtstatdate <= date_add('20240517',13)\n          and modename='组队竞技' and submodename like '%单人装备%'\n        group by dtstatdate, vplayerid\n\n        union all\n        select '交叉堡垒', dtstatdate, vplayerid\n        from dws_jordass_mode_roundrecord_di\n        where dtstatdate >= '20240412' and dtstatdate <= date_add('20240412',13)\n          and modename='组队竞技' and submodename like '%交叉堡垒%'\n        group by dtstatdate, vplayerid\n) b\n  on  a.itype      = b.itype\nand  a.vplayerid    = b.vplayerid\nwhere datediff(b.dtstatdate,a.dtstatdate) between 0 and 7\ngroup by a.itype, a.dtstatdate, datediff(b.dtstatdate,a.dtstatdate);\n",
            "复杂度": "中等",
            "table_list": [
                "dws_jordass_mode_roundrecord_di"
            ],
            "knowledge": "说明：\n广域战场 （2024/7/23）submodename= '广域战场模式'，\n消灭战（2023/8/4） modename='组队竞技' and submodename like '%消灭战模式%'，\n幻想混战（2024/11/15）modename='创意创作间' and submodename='幻想混战'，\n荒野传说（2024-09-03）modename='休闲模式' and submodename in ('荒野传说','荒野沙漠')，\n策略载具（2024-10-10）modename='休闲模式' and submodename like '%策略载具%'，\n炎夏混战（2024-06-25）modename='创意创作间' and submodename like '%炎夏混战%'，\n单人装备（2024.5.17）modename='组队竞技' and submodename like '%单人装备%'，\n交叉堡垒（2024.4.12） modename='组队竞技' and submodename like '%交叉堡垒%'\n\n第几天留存：0表示当天参与、1表示当天参与在第2天也参与、2表示当天参与在第3天也参与，依此类推",
        },
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