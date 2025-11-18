import json

class Raw_splitter:
    def __init__(self):
        pass
    def split(self, input_file_path:str, output_file_path0:str, output_file_path1:str):
        """
        对原始final_dataset.json进行预处理，
        将含有"goldensql"标签的数据输出到final_dataset_goldensql.json中,
        将不含有"goldensql"标签的数据输出到final_dataset_pure.json中.
        :param input_file_path: 原始final_dataset.json路径
        :param output_file_path0:含有"goldensql"标签的final_dataset_goldensql.json路径
        :param output_file_path1: 不含有"goldensql"标签的final_dataset_pure.json路径
        :return: 无返回值
        """
        with open(input_file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)

        list0 = []  # 包含 "golden_sql": true 的数据
        list1 = []  # 不包含 "golden_sql": true 的数据

        for item in data:
            if isinstance(item, dict) and item.get("golden_sql") is True:
                list0.append(item)
            else:
                list1.append(item)

        # 写入 output_file_path0：包含 golden_sql: true
        with open(output_file_path0, 'w', encoding='utf-8') as f0:
            json.dump(list0, f0, ensure_ascii=False, indent=2)

        # 写入 output_file_path1：不包含 golden_sql: true
        with open(output_file_path1, 'w', encoding='utf-8') as f1:
            json.dump(list1, f1, ensure_ascii=False, indent=2)