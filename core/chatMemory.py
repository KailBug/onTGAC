from colorama import Fore, Style

from core.agentState import AgentState
from core.config import Config

class ChatMemory:
    """管理对话历史,保留最近N轮"""
    def __init__(self):
        print(Fore.GREEN + "ConversationMemory.__init__完成" + Style.RESET_ALL)
        pass
    @staticmethod
    def add_message(state: AgentState, role: str, content: str) -> AgentState:
        """添加消息到历史"""
        message = {"role": role, "content": content}
        state["conversation_history"].append(message)
        return state

    @staticmethod
    def get_recent_history(state: AgentState, window_size: int = Config.MEMORY_WINDOW_SIZE) -> str:
        """获取最近的对话历史"""
        history = state.get("conversation_history", [])
        recent = history[-(window_size * 2):]  # 每轮包含user和assistant两条消息

        formatted = ""
        for msg in recent:
            formatted += f"{msg['role']}: {msg['content']}\n"
        return formatted