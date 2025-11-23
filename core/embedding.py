import json
import sys
import time
import dashscope
import numpy as np
from dashscope import TextEmbedding
from colorama import Fore, Style

from core.config import Config

dashscope.api_key = Config.QWEN_API_KEY

class EmbeddingDDL:
    def __init__(self,schemaddl_file_path:str,ddl_embedding_path:str):
        '''
        初始化
        :param schemaddl_file_path: 保存DDL数据的文件路径
        :param ddl_embedding_path: 保存DDL向量化后的数据文件路径
        '''
        self.schemaddl_file_path = schemaddl_file_path
        self.ddl_embedding_path = ddl_embedding_path
    def embedding(self):
        '''
        向量化,自动处理分批调用的 Embedding 函数
        :return:
        '''
        with open(self.schemaddl_file_path,"r",encoding='utf-8') as f:
            ddl_data = [json.loads(line) for line in f]

        all_embeddings = []
        total = len(ddl_data)
        print(f"开始对DDL向量化处理，共 {total} 条数据，每批 {Config.EMBEDDING_BATCH_SIZE} 条...")
        for i in range(0, total, Config.EMBEDDING_BATCH_SIZE):
            batch_texts = ddl_data[i: i + Config.EMBEDDING_BATCH_SIZE]
            try:
                #调用 阿里text-embedding-v4
                resp = TextEmbedding.call(
                    model=TextEmbedding.Models.text_embedding_v4,
                    input=batch_texts,
                    dimension=1536,  #v4可选维度，通常选 1024,这里选 1536 以获得较高精度
                    text_type="document",
                    #instruct="Given a research paper query, retrieve relevant research paper"
                )

                if resp.status_code == 200:
                    batch_embs = [item['embedding'] for item in resp.output['embeddings']]
                    all_embeddings.extend(batch_embs)
                    print(f"  - 批次 {i // Config.EMBEDDING_BATCH_SIZE + 1} 完成 ({len(batch_embs)} 条)")
                else:
                    print(f"  - 批次 {i // Config.EMBEDDING_BATCH_SIZE + 1} 失败: {resp.code} - {resp.message}")

            except Exception as e:
                print(f"  - 请求异常: {e}")
            # 避免触发 QPS 限制，简单休眠一下（根据您的账号等级调整）
            time.sleep(0.5)

        if not all_embeddings:
            print(f"{Fore.RED}all_embeddings空{Style.RESET_ALL}")
            sys.exit(0)

        #存储到ddl_embedding_path路径文件中
        np.save(self.ddl_embedding_path, all_embeddings)
        print(f"{Fore.GREEN}all_embeddings缓存完成{Style.RESET_ALL}")