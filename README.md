
![Logo](asset/pic.png)

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)


# onTGAC

### 本仓库为独自参加2025年腾讯游戏算法大赛Text2SQL（第三赛道）的项目代码仓库，即针对游戏业务场景下的复杂查询需求，设计并实现基于LLM的Text2SQL自动生成系统。

### 本人独自完成了包括DDL数据预处理、schema检索粗选、精选、SQL生成、SQL执行、SQL Refine和Agent架构设计，项目采用双模型分级处理架构。

## 项目信息
- 搭建基于RAG的**多阶段**推理框架,针对游戏数据领域**专有词汇**构建领域知识库，包含数据预处理、schema检索、SQL生成、执行与修正主要模块
- 设计schema linking策略，利用FAISS配合文本嵌入模型进行向量检索完成schema**初选**(re-rank)，再使用LLM对re-rank得到的schema经行**精选**(re-call)，得到最终的**top-k**
- 引入self-correction机制，通过捕捉SQL执行报错信息反馈给**二级LLM**进行Refine，提升了复杂SQL的执行成功率
- 迭代优化Prompt Engineering，采用Few-Shot Learning策略，通过**动态**向Prompt中注入Golden-sql案例，提升模型对于复杂嵌套查询的生成准确率
- 基于Docker容器化技术搭建本地评测环境，配置StarRocks数据库，实现从数据导入到推理评测的**全流程自动化**
- Python、LangGraph-1.0、Qwen3、Kimi k2、StarRocks-v2.5.12、Docker

## 代码内部环境变量

要运行这个项目，你将需要：
- 在你的本地 .env 文件中添加自定义的API_KEY
- 修改config.py文件中对应的LLM配置数据

## 环境创建

```python
conda create -n tgac-track-3 python=3.11 -y
conda activate tgac-track-3 
pip install -r requirements.txt
```

## 给自己说的话

从一无所知的text2sql小白，到独自完成Agent落地，你已经很不错了。接下来你要做的是学习优秀方案和复现前沿论文，备战2026的TAAC和TGAC，顺势而为，严于律己，加油💪！
