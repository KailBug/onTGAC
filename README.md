
![Logo](asset/pic.png)

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)


# onTGAC

### 本仓库作为参加2025年腾讯游戏算法大赛Text2SQL（第三赛道）的项目代码仓库
#### 项目采用双模型驱动，整体流程包括DDL数据预处理、schema检索粗选、精选、SQL生成、SQL执行、SQL Refine和分数评价这几部分。


## 前置环境变量

要运行这个项目，你将需要：
- 在你的本地 .env 文件中添加自定义的API_KEY
- 修改config.py文件中对应的LLM配置数据

## 环境创建

```python
conda create -n tgac-track-3 python=3.11 -y
conda activate tgac-track-3 
pip install -r requirements.txt
```
