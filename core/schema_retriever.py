import os
import json
from tqdm import tqdm
import faiss
import numpy as np
from langchain_ollama import OllamaEmbeddings
from typing import List, Dict
from colorama import Fore, Style

from core.config import Config

class SchemaRetriever:
    """向量检索相关表和字段"""
    def __init__(self, schema_file_path: str):
        """
        :param schema_file_path:保存schema.json文件的路径
        """
        self.embeddings = OllamaEmbeddings(
            model=Config.EMBEDDING_MODEL,
            base_url=Config.OLLAMA_BASE_URL
        )
        print(Fore.GREEN + "OllamaEmbeddings构建完成" + Style.RESET_ALL)
        self.schema_file_path_4generate = schema_file_path              #用于_extract_schema_from_db(self) -> Dict
        print(Fore.GREEN + "(在SchemaRetriver中)schema_file_path_4generate: " + self.schema_file_path_4generate + Style.RESET_ALL)
        self.schema_data = self._load_schema(schema_file_path)
        print(Fore.GREEN + "schema_data加载完成: schema_data[0][table_name] = " +self.schema_data[0]["table_name"]+ Style.RESET_ALL)
        self.index = None
        self.schema_texts = []
        self._build_index()
        print(Fore.GREEN + "FAISS索引构建完成" + Style.RESET_ALL)

    def _load_schema(self, schema_file_path: str) -> List[Dict]:
        """加载schema.json"""
        if os.path.exists(schema_file_path):
            with open(schema_file_path, 'r', encoding='utf-8') as f:
                return json.load(f)
        else:
            print(Fore.RED+'schema_file_path 不存在'+Style.RESET_ALL)
            return []

    def _build_index(self):
        """构建FAISS索引"""
        for item in self.schema_data:                                                       #为每个表和字段生成描述文本
            table_name = item['table_name']
            columns = item['columns']
            table_desc = f"表名: {table_name}, 包含字段: {', '.join([col['col'] for col in columns])}\n"   #表级别描述
            self.schema_texts.append({
                "text": table_desc,
                "table_name": table_name,
                "type": "table"
            })
            for col in columns:
                col_desc = f"表 {table_name} 的字段 {col['col']}, 类型: {col['type']}, 说明: {col['description']}\n"     #字段级别描述
                self.schema_texts.append({
                    "text": col_desc,
                    "table_name": table_name,
                    "column": col['col'],
                    "type": "column"
                })

        embd_cache_file_path:str = "data/embd.npy"
        faiss_cache_file_path:str = "data/index.faiss"

        if os.path.isfile(embd_cache_file_path) and os.path.getsize(embd_cache_file_path) > 0:
            embedding = np.load(embd_cache_file_path)
            self.index = faiss.read_index(faiss_cache_file_path)
            if embedding is not None and self.index is not None:
                print(Fore.BLUE+"使用embedding cache和FAISS cache"+Style.RESET_ALL)

        else:
            print(Fore.BLUE+"未找到缓存，调用 Ollama 生成 embedding..."+Style.RESET_ALL)
            texts = [item['text'] for item in self.schema_texts]            #生成嵌入向量
            batch_size = 10
            embedding = []
            with tqdm(total=len(texts)) as pbar:
                for i in range(0, len(texts), batch_size):
                    batch = texts[i:i + batch_size]
                    batch_embeddings = self.embeddings.embed_documents(batch)
                    embedding.extend(batch_embeddings)
                    pbar.update(batch_size)
            print(Fore.GREEN + "embedding end" + Style.RESET_ALL)
            embedding_array = np.array(embedding).astype('float32')

            dimension = embedding_array.shape[1]                            #构建FAISS索引
            self.index = faiss.IndexFlatL2(dimension)
            self.index.add(embedding_array)

            np.save(embd_cache_file_path, embedding)                        #持久化保存到磁盘
            faiss.write_index(self.index, faiss_cache_file_path)

    def retrieve(self, question: str, top_k: int = 3) -> str:
        """
        检索相关Schema
        :param question: 问题
        :param top_k: 找出最近的top_k
        :return:
        """
        query_embedding = self.embeddings.embed_query(question)
        query_array = np.array([query_embedding]).astype('float32')

        distances, indices = self.index.search(query_array, top_k)

        retrieved_tables = set()
        retrieved_schema = {}

        for idx in indices[0]:
            item = self.schema_texts[idx]
            table = item['table_name']
            retrieved_tables.add(table)
            if table not in retrieved_schema:
                print(f"{Fore.BLUE}{table}{Style.RESET_ALL}")
                item = next((item for item in self.schema_texts if table == item['table_name']), None)
                retrieved_schema[table] = item      #用table为键，用整个Dict对象为值

        schema_str = "相关数据表结构:\n"               #格式化输出每一个question需要的schema信息
        for table, item in retrieved_schema.items():
            desc = item.get("text")
            schema_str += desc
        return schema_str