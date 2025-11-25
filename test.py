import dashscope
from dashscope import Generation, TextEmbedding
from http import HTTPStatus
import traceback

from core.config import Config

dashscope.api_key = Config.QWEN_API_KEY

GEN_MODEL_NAME = "qwen-coder-plus-1106"

EMBED_MODEL_NAME = "text-embedding-v4"

def print_separator(title):
    print(f"\n{'=' * 20} {title} {'=' * 20}")


def test_generation():
    """测试文本生成模型 (LLM) 连接"""
    print_separator(f"测试生成模型: {GEN_MODEL_NAME}")

    messages = [
        {'role': 'system', 'content': 'You are a helpful assistant.'},
        {'role': 'user', 'content': '请回复：Text-to-SQL 连接测试成功！'}
    ]

    try:
        response = Generation.call(
            model=GEN_MODEL_NAME,
            messages=messages,
            result_format='message'  # 推荐使用 message 格式
        )

        if response.status_code == HTTPStatus.OK:
            content = response.output.choices[0]['message']['content']
            print("✅ [连接成功]")
            print(f"🤖 模型回复: {content}")
            print(f"💰 Token消耗: {response.usage}")
            return True
        else:
            print("❌ [请求失败]")
            print(f"错误码: {response.code}")
            print(f"错误信息: {response.message}")
            return False

    except Exception as e:
        print(f"❌ [发生异常]: {e}")
        return False


def test_embedding():
    """测试向量模型 (Embedding) 连接"""
    print_separator(f"测试向量模型: {EMBED_MODEL_NAME}")

    input_text = "hello world"

    try:
        response = TextEmbedding.call(
            model=EMBED_MODEL_NAME,
            input=input_text
        )

        if response.status_code == HTTPStatus.OK:
            dim = len(response)
            print("✅ [连接成功]")
            print(response)
            return True
        else:
            print("❌ [请求失败]")
            print(f"错误码: {response.code}")
            print(f"错误信息: {response.message}")
            return False

    except Exception as e:
        print(f"❌ [发生异常]: {e}")
        traceback.print_exc()
        return False



print("🚀 开始阿里云 DashScope 连接测试...\n")

gen_success = test_generation()
embed_success = test_embedding()

print_separator("测试总结")
if gen_success and embed_success:
    print("🎉 所有模型连接正常，你可以开始 Text-to-SQL 项目 Debug 了！")
else:
    print("⚠️ 部分模型连接失败，请检查 API Key 或 模型名称。")