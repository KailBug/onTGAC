# 腾讯游戏数据仓库知识库 (Domain Knowledge Base)

在编写 SQL 时，**必须**严格遵守以下业务规则、表名解析逻辑和 ID 关联规范。

## 1. 核心业务映射 (Entity Mapping)

当用户提到以下游戏或业务名词时，请使用对应的表前缀或筛选条件：

| 业务实体 (中文) | 数据库代号 (Gamecode/Prefix) | 识别逻辑/筛选条件 | 说明 |
| :--- | :--- | :--- | :--- |
| **砺刃使者** | `jordass` | 表名包含 `jordass` | FPS游戏，包含“乐园”UGC玩法 |
| **勇者盟约** | `argothek` | 表名包含 `argothek` | FPS端游 |
| **峡谷 / 峡谷行动** | `initiatived` | 在大盘表中筛选 `sgamecode = 'initiatived'` | 来源于竞品表字段描述“峡谷手游活跃 initiatived” |
| **乐园** | `jordass` | 表名包含 `jordass` 且涉及 UGC/子玩法模式 | 砺刃使者下的UGC玩法模式 |
| **手游大盘 / 平台大盘** | `mgamejp` | 表名包含 `mgamejp` | 代表所有游戏的集合数据 |

## 2. 表名解析规范 (Table Naming Convention)

表名格式通常为：`分层_业务代号_业务含义_后缀` (例如 `dws_jordass_login_di`)。

### 2.1 分层 (Layer)
* **dwd (明细层)**: 存储每一条行为事件的明细记录（如每一笔充值、每一局对局）。
* **dws (汇总层)**: 存储玩家粒度或聚合粒度的数据（如日活跃、累计充值）。
* **dim (维度层)**: 存储维度配表（如 ID 映射、物品字典）。

### 2.2 后缀 (Suffix) - 时间与更新策略
* **_di (Daily Increment)**: **日增量表**，`d` 代表按天分区，`i` 代表每天存储增量数据。查询时**必须**指定日期分区 (e.g., `dtstatdate` 或 `statis_date`)。
* **_df (Daily Full)**: **日全量表**。每天存储历史至今的全量快照。查询时通常取时间周期的**最后一天**分区。
* **_hi (Hourly Increment)**: **小时增量表**。通常用于 `dwd` 流水，包含 `dteventtime`。
* **_nf (No Partition)**: **无分区表**。通常是静态维度表或 ID 映射表。

## 3. ID 关联与转换规范 (ID Join Logic)

不同游戏使用独立的 ID 体系，跨游戏或查询大盘数据时，**严禁直接 JOIN 不同的 PlayerID**，必须通过中间表转换。

### 3.1 核心 ID 定义
* **vplayerid / gplayerid / iuserid**: 游戏角色 ID（单游戏内唯一）。
* **suserid**: 平台账号 ID（QQ号或微信号，跨游戏唯一）。
* **uid**: 游戏内具体的角色 UID。

### 3.2 跨表关联路径 (Standard Join Paths)
**场景 1：勇者盟约 (`argothek`) 关联 平台大盘 (`mgamejp`)**
* **步骤**: `dws_argothek...` (iuserid) -> **`dim_argothek_gplayerid2qqwxid_df`** -> `dws_mgamejp...` (suserid)
* **关联键**: 源表 `iuserid` 关联转换表 `iuserid`，获取 `suserid`

**场景 2：砺刃使者 (`jordass`) 关联 平台大盘 (`mgamejp`)**
* **步骤**: `dws_jordass...` (vplayerid) -> **`dim_jordass_playerid2suserid_nf`** -> `dws_mgamejp...` (suserid)
* **关联键**: 源表 `vplayerid` 关联转换表 `vplayerid`，获取 `suserid`

**场景 3：微信 ID 与 QQ ID 互通**
* 使用表 **`dim_mgamejp_idconversion_wxid_qq_nf`** 进行 `swxid` 和 `iqq` 的转换。

## 4. 常用字段规范 (Field Mapping)

在编写 SQL 时，请优先使用以下字段命名习惯：

* **日期分区**:
    * 通常为 `dtstatdate` 或 `statis_date` (格式 YYYYMMDD, 类型 bigint/string)。
    * **注意**: 不要幻觉出 `ds` 或 `partition_date`，除非 Schema 明确列出。
* **平台类型 (`platid`)**:
    * `0`: iOS
    * `1`: Android
    * `255`: 所有平台/不区分平台
* **账号类型 (`saccounttype`)**:
    * 在查询大盘 `mgamejp` 表时，取 `-100` 代表汇总账号类型。
* **活跃位图 (`cbitmap`)**:
    * 100位字符串，左侧第一位代表当天。`1`=有行为，`0`=无行为。常用于计算留存。
* **流水/金额**:
    * **流水 (Log)**: 指 `dwd_` 开头的明细表日志。
    * **流水 (Money)**: 指充值金额，字段通常为 `imoney` (元) 或 `iamount` (代币)。
## 5. 常用知识说明
* **cbitmap**:100位0和1组成的字符串，左侧第一位代表当天。1表示有对应行为，比如活跃或付费，0 表示未发生对应行为，比如未活跃或未付费。常常使用该字段统计流失、回流、留存等指标
* **DAU**:日活跃用户数
* **留存**:以次留为例，表示当天活跃第二天依然活跃的用户定义为次留，其他留存以此类推
* **新进**:注册