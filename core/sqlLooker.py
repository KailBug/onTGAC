# 步骤 3：代码级后处理 (Python 代码优化)
# 在 SQLGenerator 或 SQLRefiner 的输出阶段，增加一个简单的字段映射器。这比单纯依赖模型重写更有效。


#执行SQL前添加一个looker节点

class sqlLooker:
    def __init__(self):
        pass

    def post_process_sql(self):
        pass

    def build(self):
        pass