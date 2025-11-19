#小功能测试用，不参与程序流程

import json
from pprint import pprint

golden_sql_file_path = "data/final_dataset_goldensql.json"
with open(golden_sql_file_path,"r",encoding="utf-8") as f:
    golden_sql = json.load(f)
    pprint(golden_sql[0]["sql"],width=40,sort_dicts=False)