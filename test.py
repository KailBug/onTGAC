from langchain_ollama import OllamaEmbeddings
import numpy as np
import faiss

from core.config import Config
#
# embeddings = OllamaEmbeddings(
#     model=Config.EMBEDDING_MODEL,
#     base_url=Config.OLLAMA_BASE_URL
# )
#
# texts = ["hello","world"]
# vec = embeddings.embed_documents(texts)
# embedding_array = np.array(vec).astype('float32')
# print(embedding_array)
# print("长度:", len(vec))
# print("前5维:", vec[:5])
# print("类型:", type(vec[0]))

embd_cache_file_path: str = "data/embd.npy"
faiss_cache_file_path: str = "data/index.faiss"

embedding = np.load(embd_cache_file_path)
embedding_array = np.array(embedding).astype('float32')

dimension = embedding_array.shape[1]
index = faiss.IndexFlatL2(dimension)
index.add(embedding_array)

faiss.write_index(index, faiss_cache_file_path)