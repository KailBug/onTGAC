import re

from core.agentState import AgentState

class Knowledge2Rule:
    def __init__(self):
        pass
    def build(self, state: AgentState) -> str:
        """处理 item 中的 knowledge 字段，将其格式化为清晰的 If... Then... 规则。"""
        knowledge_raw = state.get("knowledge", "")

        # 判空处理：如果没有知识，返回空字符串或默认提示
        if not knowledge_raw or not knowledge_raw.strip():
            return ""
        knowledge_str = knowledge_raw.strip()
        formatted_rules = []
        # 尝试解析结构：检查是否存在 "标题：" 或 "Title:" 这种结构
        # 将文本按行分割
        lines = [line.strip() for line in knowledge_str.split('\n') if line.strip()]

        current_condition = None
        current_constraints = []
        rules_found = False

        for line in lines:
            # 匹配以冒号结尾的行，视为 Condition (例如 "竞品业务：")
            # 兼容中文冒号和英文冒号
            match = re.match(r"^(.+?)[:：]$", line)

            if match:
                # 如果之前已经积攒了一个规则，先保存之前的
                if current_condition:
                    rule_text = self._format_single_rule(current_condition, current_constraints)
                    formatted_rules.append(rule_text)
                # 开始新的一段规则
                current_condition = match.group(1)  # 获取冒号前的文字
                current_constraints = []
                rules_found = True
            else:
                # 如果没有 Condition，或者是在 Condition 之后的行，视为 Constraint
                current_constraints.append(line)
        # 收尾处理
        if current_condition:
            # 保存最后一段捕获的规则
            rule_text = self._format_single_rule(current_condition, current_constraints)
            formatted_rules.append(rule_text)
        elif not rules_found:
            # Fallback: 如果全文没有发现任何 "标题：" 结构，则将整段作为一个通用规则
            # 这种情况通常是通用过滤条件
            rule_text = self._format_single_rule("the question involves domain knowledge", lines)
            formatted_rules.append(rule_text)

        # 拼接最终输出，添加一些 Prompt Header 让 LLM 更重视
        final_output = "Reference the following External Knowledge rules:\n" + "\n".join(formatted_rules)

        return final_output

    def _format_single_rule(self, condition: str, constraints: list) -> str:
        """
        辅助函数：将条件和约束列表格式化为 Markdown 风格的 If-Then 文本
        """
        # 选择保留一定的换行结构，看起来更像代码块，便于 LLM 理解 SQL 语法
        constraints_block = "\n".join(constraints)

        return (
            f"- Rule: **IF** the user question asks about '{condition}', "
            f"**THEN** strictly apply the following SQL filters:\n"
            f"  ```sql\n"
            f"  {constraints_block}\n"
            f"  ```"
        )