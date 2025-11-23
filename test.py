#小功能测试用，不参与程序流程
from openai import OpenAI
import os
from core.config import Config

#阿里云 API Key
api_key =  Config.QWEN_API_KEY

client = OpenAI(
    api_key=api_key,
    base_url="https://dashscope.aliyuncs.com/compatible-mode/v1", # 确认 URL
)

try:
    completion = client.chat.completions.create(
        model="qwen3-coder-480b-a35b-instruct", # 确认阿里云的模型名
        messages=[{'role': 'user', 'content': '测试一下连通性'}]
    )
    print(completion.choices[0].message.content)
except Exception as e:
    print(f"连接测试失败: {e}")


