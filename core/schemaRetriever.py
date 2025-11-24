import os
import json
import faiss
import numpy as np
import dashscope
from dashscope import TextEmbedding
from dashscope import Generation
from typing import List, Dict
from colorama import Fore, Style
from langchain_core.prompts import PromptTemplate
from http import HTTPStatus
from tenacity import retry, stop_after_attempt, wait_fixed

from core.config import Config
from core.schema2DDL import Schema2DDL
from core.embedding import EmbeddingDDL
from core.knowledge2rules import Knowledge2Rule

dashscope.api_key = Config.QWEN_API_KEY

class SchemaRetriever:
    """向量检索相关表和字段"""
    def __init__(self, schema_file_path: str):
        """
        :param schema_file_path:保存schema.json文件的路径
        """
        self.schema_data = self._load_schema(schema_file_path)
        self.index = None
        self.recalled_data:list[dict] = []
        self._build_index()
        self.rerank_prompt = PromptTemplate(
            input_variables=["query","knowledge_in_rules","question_table_list","recalled_data"],
            template="""
                    你是一个专业的数据库管理员和 SQL 专家，你的工作环境使用starrocks/allin1-ubuntu:2.5.12。
                    你的任务是根据用户的自然语言问题，从给定的候选数据表中筛选出**真正需要**使用的表。
                    
                    **任务要求：**
                    1. 仔细阅读用户的查询和提供的候选表结构（DDL）。
                    2. 分析每个表是否包含回答问题所需的列（注意查看列的 COMMENT 注释）。
                    3. 如果一个表是多余的或与问题无关，请不要选择它。
                    4. 就算表名看起来相关，如果缺少核心字段，也不要选择。
                    
                    **用户问题：**
                    {query}
                    
                    **用户问题相关知识：**
                    {knowledge_in_rules}
                    
                    **用户问题相关表格：**
                    {question_table_list}
                    
                    **候选表结构：**
                    table_name:{recalled_data[0][table_name]} DDL:{recalled_data[0][ddl]} coarse_recall_score:{recalled_data[0][coarse_score]};
                    table_name:{recalled_data[1][table_name]} DDL:{recalled_data[1][ddl]} coarse_recall_score:{recalled_data[1][coarse_score]};
                    table_name:{recalled_data[2][table_name]} DDL:{recalled_data[2][ddl]} coarse_recall_score:{recalled_data[2][coarse_score]};
                    table_name:{recalled_data[3][table_name]} DDL:{recalled_data[3][ddl]} coarse_recall_score:{recalled_data[3][coarse_score]};
                    table_name:{recalled_data[4][table_name]} DDL:{recalled_data[4][ddl]} coarse_recall_score:{recalled_data[4][coarse_score]};
                    table_name:{recalled_data[5][table_name]} DDL:{recalled_data[5][ddl]} coarse_recall_score:{recalled_data[5][coarse_score]};
                    table_name:{recalled_data[6][table_name]} DDL:{recalled_data[6][ddl]} coarse_recall_score:{recalled_data[6][coarse_score]};
                    table_name:{recalled_data[7][table_name]} DDL:{recalled_data[7][ddl]} coarse_recall_score:{recalled_data[7][coarse_score]};
                    table_name:{recalled_data[8][table_name]} DDL:{recalled_data[8][ddl]} coarse_recall_score:{recalled_data[8][coarse_score]};
                    table_name:{recalled_data[9][table_name]} DDL:{recalled_data[9][ddl]} coarse_recall_score:{recalled_data[9][coarse_score]};
                    table_name:{recalled_data[10][table_name]} DDL:{recalled_data[10][ddl]} coarse_recall_score:{recalled_data[10][coarse_score]};
                    table_name:{recalled_data[11][table_name]} DDL:{recalled_data[11][ddl]} coarse_recall_score:{recalled_data[11][coarse_score]};
                    table_name:{recalled_data[12][table_name]} DDL:{recalled_data[12][ddl]} coarse_recall_score:{recalled_data[12][coarse_score]};
                    table_name:{recalled_data[13][table_name]} DDL:{recalled_data[13][ddl]} coarse_recall_score:{recalled_data[13][coarse_score]};
                    table_name:{recalled_data[14][table_name]} DDL:{recalled_data[14][ddl]} coarse_recall_score:{recalled_data[14][coarse_score]};
                    table_name:{recalled_data[15][table_name]} DDL:{recalled_data[15][ddl]} coarse_recall_score:{recalled_data[15][coarse_score]};
                    table_name:{recalled_data[16][table_name]} DDL:{recalled_data[16][ddl]} coarse_recall_score:{recalled_data[16][coarse_score]};
                    table_name:{recalled_data[17][table_name]} DDL:{recalled_data[17][ddl]} coarse_recall_score:{recalled_data[17][coarse_score]};
                    table_name:{recalled_data[18][table_name]} DDL:{recalled_data[18][ddl]} coarse_recall_score:{recalled_data[18][coarse_score]};
                    table_name:{recalled_data[19][table_name]} DDL:{recalled_data[19][ddl]} coarse_recall_score:{recalled_data[19][coarse_score]};
                    
                    **输出格式要求：**
                    请仅输出一个 JSON 对象，不要包含 markdown 格式（如 ```json ... ```），格式如下：
                    {
                        "reasoning": "在此处简要分析为什么选择这些表，排除那些表...",
                        "selected_tables": ["table_name_A", "table_name_B"]
                    }
                    """
        )
        print(Fore.GREEN + "SchemaRetriever.__init__完成" + Style.RESET_ALL)

    def _load_schema(self, schema_file_path: str) -> List[Dict]:
        """加载schema.json"""
        if os.path.exists(schema_file_path):
            with open(schema_file_path, 'r', encoding='utf-8') as f:
                print(Fore.GREEN + "schema_data加载完成" + Style.RESET_ALL)
                return json.load(f)
        else:
            print(Fore.RED+'schema_file_path 不存在'+Style.RESET_ALL)
            return []

    def _build_index(self):
        """构建FAISS索引"""
        DDL_embedding_cache_file_path:str = Config.DDL_embedding_cache_file_path
        DDL_faiss_index_cache_file_path:str = Config.DDL_faiss_index_cache_file_path
        schemaddl_file_path:str = Config.schemaddl_file_path

        if os.path.isfile(DDL_embedding_cache_file_path) and os.path.getsize(DDL_embedding_cache_file_path) > 0:
            embedding = np.load(DDL_embedding_cache_file_path)
            self.index = faiss.read_index(DDL_faiss_index_cache_file_path)
            if embedding is not None and self.index is not None:
                print(Fore.BLUE+"使用embedding cache和FAISS cache"+Style.RESET_ALL)
        else:
            print(Fore.BLUE+"未找到缓存，调用 embedding_cloud 生成 embedding..."+Style.RESET_ALL)
            # 转换为DDL
            Schema2DDL(self.schema_data, schemaddl_file_path).build()
            # 映射为向量
            EmbeddingDDL(schemaddl_file_path, DDL_embedding_cache_file_path).embedding()
            embedding = np.load(DDL_embedding_cache_file_path)
            embedding_array = np.array(embedding).astype('float32')
            # 归一化 (L2 Normalize)
            # text-embedding-v4 使用余弦相似度效果最好。
            # FAISS 计算 InnerProduct (IP) 前,先对向量做 L2 归一化，结果等价于余弦相似度。
            faiss.normalize_L2(embedding_array)
            # 构建FAISS索引
            dimension = embedding_array.shape[1]
            self.index = faiss.IndexFlatIP(dimension)
            self.index.add(embedding_array)
            # 持久化保存到磁盘
            faiss.write_index(self.index, DDL_faiss_index_cache_file_path)

    def _recall(self, query: str, top_k: int = 20) -> list[dict]:
        """
        粗排，使用FAISS进行相似性搜索，检索相关SchemaDDL，得到大范围DDL结果
        :param query: 结合信息的问题
        :param top_k: 找出最近的top_k
        :return:
        """
        schemaddl_index_file_path: str = Config.schemaddl_index_file_path
        schemaddl_file_path: str = Config.schemaddl_file_path

        recalled_candidates = []
        schemaDDL_dataindex = []
        schemaDDL_data = []

        with open(schemaddl_index_file_path, "r", encoding="utf-8") as f:
            schemaDDL_dataindex = [json.loads(line) for line in f]
        with open(schemaddl_file_path, "r", encoding="utf-8") as f:
            schemaDDL_data = [json.loads(line) for line in f]
        # 查询也要向量化
        q_resp = TextEmbedding.call(
            model=TextEmbedding.Models.text_embedding_v4,
            input=query,
            dimension=1536,
            text_type="query",
            #instruct="Given a research paper query, retrieve relevant research paper"
        )
        q_vec = np.array([q_resp.output['embeddings'][0]['embedding']], dtype='float32')
        faiss.normalize_L2(q_vec)  # 查询向量也要归一化
        # 搜索 Top 20
        distances, indices = self.index.search(q_vec, top_k)

        for rank, index in enumerate(indices[0],1):
            if index == -1:
                continue
            score = distances[0][index]
            table_name = schemaDDL_dataindex[index]
            DDL_text = schemaDDL_data[index]
            candidate = {
                "table_name": table_name,
                "ddl": DDL_text,
                "coarse_score": float(score),
                "rank": rank
            }
            recalled_candidates.append(candidate)

        return recalled_candidates

    def _build_query(self, item: dict)->str:
        # 获取基础问题，去除首尾空白
        question = item.get('question', '').strip()
        # 获取业务知识 (External Knowledge)
        knowledge = item.get('knowledge', '').strip()
        # 构建组合 Query
        # 如果有 knowledge，将其作为补充信息拼接到问题后面
        # 使用分隔符或标签让 Embedding 模型理解这是上下文补充
        if knowledge:
            # 这里的格式可以灵活调整，目的是让模型知道下面是业务定义或字段提示
            full_query = f"{question}\n\n### 业务逻辑与字段提示 ###\n{knowledge}"
        else:
            full_query = question
        return full_query

    @retry(stop=stop_after_attempt(3), wait=wait_fixed(1))
    def _call_LLM(self):
        return Generation.call(
                model='qwen-max',  # 或'qwen-plus'，kimi-k2
                messages={'role': 'user', 'content': self.rerank_prompt},
                result_format='message',  # 使用 message 格式
        )

    def rerank(self, item: dict, top_k: int) -> list:
        '''
        精排，使用MODEL，进行精确性检查，带有纠察机制
        :param item: 整个sql问题
        :param top_k:精排数量
        :return:
        '''
        final_schema = []
        query: str = self._build_query(item)
        self.recalled_data = self._recall(query)
        knowledge_in_rules = Knowledge2Rule.build(item)
        self.rerank_prompt.format(
            query=query,
            knowledge_in_rules=knowledge_in_rules,
            question_table_list=item["table_list"],
            table_list = self.recalled_data
        )

        response = self._call_LLM()

        if response.status_code == HTTPStatus.OK:
            content = response.output.choices[0].message.content
            try:
                # 清洗和解析 JSON, 有时候模型会带上 ```json ... ```，需要去掉
                content = content.replace("```json", "").replace("```", "").strip()
                result_json = json.loads(content)

                print(f"{Fore.GREEN}--- 精排推理过程 ---{Style.RESET_ALL}")
                print(result_json.get("reasoning"))

                final_schema = result_json.get("selected_tables", [])
                return final_schema
            except json.JSONDecodeError:
                print(f"{Fore.RED}JSON 解析失败，模型输出为: {content}{Style.RESET_ALL}")
                return []  # 或者返回 fallback 策略
        else:
            print(f"{Fore.RED}API 调用失败: {response.code} - {response.message}{Style.RESET_ALL}")
            return []