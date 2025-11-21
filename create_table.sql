
    CREATE TABLE IF NOT EXISTS `dim_mgamejp_tbplayerid2wxid_nf` (
        `dtstatdate` bigint COMMENT "统计日期YYYYMMDD",
        `sappid` string COMMENT "游戏id",
        `splayerid` string COMMENT "playerid",
        `swxid` string COMMENT "帐号"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_argothek_ce1_login_di` (
        `dtstatdate` string COMMENT "统计日期",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "0 ios,1 android, 255 所有平台",
        `vplayerid` string COMMENT "玩家ID",
        `ilevel` bigint COMMENT "等级",
        `ionlinetime` bigint COMMENT "在线时长(秒)",
        `ilogincount` bigint COMMENT "登录次数",
        `friendcount` bigint COMMENT "好友数量",
        `clientversion` string COMMENT "客户端版本",
        `channel` bigint COMMENT "渠道",
        `uuid` string COMMENT "唯一标识",
        `deviceid` string COMMENT "设备ID",
        `dtlogintime` string COMMENT "当日最早登录时间"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_payrespond_hi` (
        `tdbank_imp_date` string COMMENT "",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID",
        `billno` string COMMENT "订单号",
        `res` string COMMENT "错误码",
        `balance` bigint COMMENT "点券余额",
        `amount` bigint COMMENT "amount",
        `source` bigint COMMENT "请求点券的请求源",
        `is_online` bigint COMMENT "应答当时玩家是否在线",
        `gen_balance` bigint COMMENT "gen_balance",
        `used_gen_amt` bigint COMMENT "used_gen_amt",
        `submode` string COMMENT "ugc模式",
        `devicetype` bigint COMMENT "DeviceType "
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_pcgame_dayact_di` (
        `statis_date` bigint COMMENT "statis_date",
        `game_id` string COMMENT "game_id",
        `iuserid` string COMMENT "iuserid",
        `ionlinetime` bigint COMMENT "ionlinetime",
        `ilevel` bigint COMMENT "ilevel",
        `useridtype` string COMMENT "账号类型"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`statis_date`)
    DISTRIBUTED BY HASH (`statis_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_gameresultrecord_hi` (
        `tdbank_imp_date` string COMMENT "",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID",
        `battleid` string COMMENT "对局id",
        `ugcmodeid` bigint COMMENT "模式ID",
        `ugcmodename` string COMMENT "模式名",
        `roundtime` bigint COMMENT "对局时长(秒)",
        `startime` bigint COMMENT "开局时刻",
        `endtime` bigint COMMENT "结束时刻",
        `playernumber` bigint COMMENT "玩家数",
        `teammemberlist` string COMMENT "大厅组队队友List",
        `friendcount` bigint COMMENT "大厅组队队友中的好友数量",
        `isvip` bigint COMMENT "是否乐园通行证会员0,1",
        `ugcisgray` bigint COMMENT "是否为ugc灰度玩法。默认为0：非灰度；1：灰度",
        `kills` bigint COMMENT "击杀数",
        `damageamount` bigint COMMENT "总伤害量，浮点数，乘以100存入",
        `move` bigint COMMENT "移动距离",
        `reachedarchives` bigint COMMENT "达到存档数",
        `devicetype` bigint COMMENT "DeviceType "
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_extract_311381_conf` (
        `vplayerid` string COMMENT ""
    )
    ENGINE=OLAP
    DUPLICATE KEY (`vplayerid`)
    DISTRIBUTED BY HASH (`vplayerid`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_argothek_oss_login_di` (
        `statis_date` bigint COMMENT "统计时间",
        `iuserid` string COMMENT "用户ID",
        `ilogintime` bigint COMMENT "登录时间",
        `ionlinetime` bigint COMMENT "在线时长",
        `ilevel` bigint COMMENT "玩家等级",
        `iplaytime` bigint COMMENT "游戏时长",
        `iloginway` bigint COMMENT "登录渠道",
        `ilogincount` bigint COMMENT "登录次数"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`statis_date`)
    DISTRIBUTED BY HASH (`statis_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_jordass_useralltag_df` (
        `ds` string COMMENT "统计日期格式YYYYMMDD",
        `playerid` string COMMENT "玩家id",
        `actv_label_7d` bigint COMMENT "周活跃度标签",
        `actv_label_30d` bigint COMMENT "月活跃度标签",
        `month_actv_days_label` bigint COMMENT "月活跃天数标签",
        `month_actv_time_label` bigint COMMENT "月活跃时长标签",
        `week_actv_layer_label` bigint COMMENT "周活跃分层标签",
        `actv_period_label_7d` bigint COMMENT "周主要活跃时段标签",
        `only_actv_period_label_7d` bigint COMMENT "周仅活跃时段标签",
        `battle_actv_period_label` bigint COMMENT "对局活跃时间段标签",
        `evening_peak_label` bigint COMMENT "晚高峰标签",
        `actv_type_label_7d` bigint COMMENT "周活跃类型标签",
        `oldnew_player_label` bigint COMMENT "新老用户标签",
        `actv_type_label_14d` bigint COMMENT "双周活跃类型标签",
        `actv_type_label_30d` bigint COMMENT "月活跃类型标签",
        `month_actv_change_label` bigint COMMENT "月活跃度变化标签",
        `shorte_cycle_label` bigint COMMENT "当前最短周期",
        `cycle_label` string COMMENT "当前所有周期",
        `long_actv_period_label` bigint COMMENT "长线活跃时段标签",
        `pay_level_1y` bigint COMMENT "近一年付费水平",
        `pay_rlevel_1m` bigint COMMENT "月付费分R",
        `pay_rlevel_td` bigint COMMENT "历史付费分R",
        `pay_silence_w` bigint COMMENT "付费沉默-周",
        `pay_silence_m` bigint COMMENT "付费沉默-月",
        `pay_rlevel_season` bigint COMMENT "赛季付费水平",
        `mainplay_model_label` bigint COMMENT "主玩模式标签",
        `vsteam_play_label` bigint COMMENT "组竞玩法标签",
        `play_exclusive_label` bigint COMMENT "玩法独占标签",
        `social_play_label` bigint COMMENT "社交玩法标签",
        `latest_segment` bigint COMMENT "当前段位",
        `history_max_segment` bigint COMMENT "历史最高段位",
        `szn_max_segment` bigint COMMENT "当前赛季最高段位",
        `last_szn_max_segment` bigint COMMENT "上赛季最高段位",
        `last_3_szn_max_segment` bigint COMMENT "上3赛季最高段位",
        `latest_segment_merge` bigint COMMENT "当前段位-合并",
        `history_max_segment_merge` bigint COMMENT "历史最高段位-合并",
        `szn_max_segment_merge` bigint COMMENT "当前赛季最高段位-合并",
        `last_szn_max_segment_merge` bigint COMMENT "上赛季最高段位-合并",
        `last_3_szn_max_segment_merge` bigint COMMENT "上3赛季最高段位-合并",
        `szn_segment_grow_type` bigint COMMENT "赛季段位成长类型",
        `kd_value_dist` bigint COMMENT "KD值分布",
        `frustrated_ability` bigint COMMENT "受挫能力",
        `mainplay_model_flow` bigint COMMENT "主玩模式流转",
        `play_habit_label` bigint COMMENT "打法习惯",
        `home_play_label` bigint COMMENT "领地活跃标签",
        `pagerank_social_level` bigint COMMENT "Pagerank社交等级",
        `belong_cmty_id` bigint COMMENT "当前所属社群ID",
        `belong_cmty_scale` bigint COMMENT "当前所属社群规模",
        `belong_cmty_stability` bigint COMMENT "当前所属社群稳定性",
        `platfriend_cnt_label` bigint COMMENT "平台好友数标签",
        `gamefriend_cnt_label` bigint COMMENT "游戏好友数标签",
        `platactv_friend_cnt_label` bigint COMMENT "平台活跃好友数标签",
        `gameactv_friend_cnt_label` bigint COMMENT "游戏活跃好友数标签",
        `teamup_habit` bigint COMMENT "开黑习惯",
        `battle_mic_label` bigint COMMENT "对局开麦标签",
        `social_ability` bigint COMMENT "社交能力",
        `no_cmty_probability` bigint COMMENT "下下周无社群概率",
        `cmty_influence_level` bigint COMMENT "社群内影响力等级",
        `spread_influence_level` bigint COMMENT "传播影响力等级",
        `is_yingdi_user` bigint COMMENT "是否营地用户",
        `season_main_play1` bigint COMMENT "前3赛季主玩",
        `season_main_play2` bigint COMMENT "前2赛季主玩",
        `season_main_play3` bigint COMMENT "前1赛季主玩",
        `season_main_play4` bigint COMMENT "当前赛季主玩",
        `gender` bigint COMMENT "自然人性别",
        `province` string COMMENT "省份",
        `city` string COMMENT "自然人城市",
        `city_level` string COMMENT "自然人城市等级",
        `yingdi_actv_type_30d` bigint COMMENT "是否营地30天内活跃用户",
        `comm1` string COMMENT "预留字段1",
        `comm2` string COMMENT "预留字段2",
        `comm3` string COMMENT "预留字段3",
        `comm4` string COMMENT "预留字段4",
        `comm5` string COMMENT "预留字段5",
        `comm6` string COMMENT "预留字段6",
        `comm7` string COMMENT "预留字段7",
        `comm8` string COMMENT "预留字段8",
        `comm9` string COMMENT "预留字段9",
        `comm10` string COMMENT "预留字段10",
        `comm11` string COMMENT "预留字段11",
        `comm12` string COMMENT "预留字段12",
        `comm13` string COMMENT "预留字段13",
        `comm14` string COMMENT "预留字段14",
        `comm15` string COMMENT "预留字段15"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`ds`)
    DISTRIBUTED BY HASH (`ds`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_roundflow_hi` (
        `tdbank_imp_date` string COMMENT "小时分区字段，格式YYYYMMDDHH",
        `gamesvrid` string COMMENT "登录的游戏服务器编号",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "玩家",
        `uid` string COMMENT "玩家UID",
        `battleid` string COMMENT "对局ID",
        `battletype` bigint COMMENT "战斗类型对应BATTLETYPE,其它说明参考FAQ文档",
        `roundscore` bigint COMMENT "本局分数,无得分的填0",
        `roundtime` bigint COMMENT "对局时长(秒)",
        `result` bigint COMMENT "单局结果，参考 Result",
        `gold` bigint COMMENT "金钱变化值",
        `level` bigint COMMENT "等级变化值",
        `seasonid` bigint COMMENT "所属赛季ID",
        `mode` bigint COMMENT "101：传统模式第三人称单排	102：传统模式第三人称双排	103：传统模式第三人称四排	401：传统模式第一人称单排	402：传统模式第一人称双排	403：传统模式第一人称四排	603：创意创作间计分模式第三人称四排(含极能形态模式、极限追猎、特种作战等子模式)",
        `submode` bigint COMMENT "子模式",
        `map` bigint COMMENT "地图",
        `weather` bigint COMMENT "天气",
        `startime` bigint COMMENT "开局时刻",
        `endtime` bigint COMMENT "结束时刻",
        `playernumber` bigint COMMENT "玩家数",
        `realplayernumber` bigint COMMENT "真人玩家数",
        `teamnumber` bigint COMMENT "小队数",
        `teammemberlist` string COMMENT "队友id解析字段teammemberlist步骤：	使用lateral VIEW explode(split(teammemberlist,'\\+')) adTable AS buttontype 函数通过 \\+截取进行行转列进行计算。",
        `escapecheckup` bigint COMMENT "是否逃跑",
        `totalchangedpointvalue` bigint COMMENT "综合积分变化值",
        `changedratingvalue` bigint COMMENT "rating分变化值",
        `ratingvalueallianceforceterchanged` bigint COMMENT "rating分变化后的值",
        `changedkillratingvalue` bigint COMMENT "kill rating分变化值",
        `killratingvalueallianceforceterchanged` bigint COMMENT "kill rating分变化后的值",
        `changedwinratingvalue` bigint COMMENT "win rating分变化值",
        `winratingvalueallianceforceterchanged` bigint COMMENT "win rating分变化后的值",
        `playergetexperience` bigint COMMENT "玩家获得的经验值",
        `currentroundrank` bigint COMMENT "当局名次",
        `killingcount` bigint COMMENT "击杀",
        `assistcount` bigint COMMENT "助攻次数",
        `survivaltime` bigint COMMENT "存活总时间(秒)",
        `damageamount` bigint COMMENT "总伤害量,浮点数，乘以100存入",
        `healtimes` bigint COMMENT "救人次数",
        `healamount` bigint COMMENT "治疗量，浮点数，乘以100存入",
        `movingdistance` bigint COMMENT "前进距离，单位米",
        `dyingflow` string COMMENT "濒死流水，暂无",
        `deadflow` string COMMENT "死亡流水 死亡坐标/死亡类型/死亡时间",
        `headshotcounts` bigint COMMENT "爆头数",
        `gunkillingtimes` bigint COMMENT "枪械击杀数，暂无",
        `meleekilltimes` bigint COMMENT "近战击杀数，暂无",
        `rangeddamagedamount` bigint COMMENT "远程武器伤害量，暂无",
        `meleedamageamount` bigint COMMENT "近战伤害量，暂无",
        `obtianeditemflow` bigint COMMENT "获得的物品流水，暂无",
        `obtianedairdroptimes` bigint COMMENT "获得空投次数",
        `vehicledestoryedtimes` bigint COMMENT "摧毁载具次数",
        `landingcoordinate` bigint COMMENT "落地点坐标,弃用，之前定义的类型是int，应该是字符串",
        `killingflow` string COMMENT "击杀流水 :击杀目标ID\t击杀类型\t是否爆头\t击杀距离\t使用的武器ID\t击杀者（角色自己）位置  新增：\t被击杀者位置\t击杀时间（从进入小岛开始到击杀时的毫秒数）\t造成伤害量\t是否移动\t击杀区域ID(-1表示区域表中不记录)\t状态(1:卧倒)\t被击倒的武器id\t击杀圈数\t被击杀者名字\t是否灭队\t是否为ai\tAI的类型\t击倒者uid\t击杀者uid",
        `creepingtime` bigint COMMENT "匍匐时间",
        `swimmingtime` bigint COMMENT "游泳时间，暂无",
        `divingtime` bigint COMMENT "潜水时间，暂无",
        `drivingtime` bigint COMMENT "驾驶载具时间",
        `ridingtime` bigint COMMENT "乘坐载具时间，暂无",
        `walkingdistance` bigint COMMENT "步行距离，单位米",
        `staytimeinpoisonedarea` bigint COMMENT "吃毒时间",
        `damageindex` bigint COMMENT "击杀指数,乘100后四舍五入",
        `luckyindex` bigint COMMENT "幸运指数，弃用无效",
        `collectindex` bigint COMMENT "物资指数,乘100后四舍五入",
        `survivalindex` bigint COMMENT "生存指数,乘100后四舍五入",
        `movingindex` bigint COMMENT "前进指数，弃用无效",
        `creepindex` bigint COMMENT "伏地指数，弃用无效",
        `accuracyindex` bigint COMMENT "精准指数，弃用无效",
        `deliveryindex` bigint COMMENT "快递指数，弃用无效",
        `sneakattackindex` bigint COMMENT "偷袭指数，弃用无效",
        `healindex` bigint COMMENT "支援指数,乘100后四舍五入",
        `boxindex` bigint COMMENT "盒子指数，弃用无效",
        `assaultindex` bigint COMMENT "伤害指数,乘100后四舍五入",
        `totalpoint` bigint COMMENT "综合积分变化后的值",
        `ratinglevel` bigint COMMENT "流水评价等级",
        `titleidlist` string COMMENT "当局获得的称号Id",
        `itemuseflow` string COMMENT "装备的物品流水",
        `medicineuseflow` string COMMENT "使用的药品流水",
        `gunhittimes` bigint COMMENT "枪械命中次数",
        `gunshottimes` bigint COMMENT "枪械射击次数",
        `teamrank` bigint COMMENT "队伍名次",
        `curecount` bigint COMMENT "治疗次数",
        `drivingdistance` bigint COMMENT "行驶距离，单位米",
        `totalscorerank` bigint COMMENT "综合评分排名，弃用无效",
        `rating` bigint COMMENT "鸡分",
        `killrating` bigint COMMENT "消灭鸡分",
        `winrating` bigint COMMENT "排名鸡分",
        `ratingrank` bigint COMMENT "鸡分排名，弃用无效",
        `killingratingrank` bigint COMMENT "消灭鸡分排名，弃用无效",
        `winratingrank` bigint COMMENT "排名鸡分排名，弃用无效",
        `totalround` bigint COMMENT "赛季分人称几排总场数",
        `totalkill` bigint COMMENT "赛季分人称几排总杀敌数",
        `totalwin` bigint COMMENT "赛季分人称几排总胜利数",
        `top10times` bigint COMMENT "前十数",
        `totalheadshotrate` bigint COMMENT "赛季分人称几排总爆头率",
        `averagesurvivaltimeperround` bigint COMMENT "场均存活时间",
        `healfriendtimes` bigint COMMENT "救助队友次数",
        `averagemovedistanceperround` bigint COMMENT "场均移动距离",
        `maxdamageinoneround` bigint COMMENT "单局最高伤害",
        `maxkillinginoneround` bigint COMMENT "单局最高击杀",
        `maxsurvivaltime` bigint COMMENT "最长存活时间",
        `maxmovingdistance` bigint COMMENT "最长移动距离",
        `contributionrankrating` bigint COMMENT "单排总积分贡献分",
        `contributionkillrating` bigint COMMENT "单排击败积分贡献分",
        `contributionwinrating` bigint COMMENT "单排生存积分贡献分",
        `oldsegmentlevel` bigint COMMENT "旧段位",
        `newsegmentlevel` bigint COMMENT "新段位",
        `teamid` bigint COMMENT "小队ID",
        `landlocation` string COMMENT "落地点坐标,有效字段,单位cm",
        `totaldeadtimes` bigint COMMENT "赛季分人称几排总死亡数",
        `sumscore` bigint COMMENT "流水总评分，乘以100后存入",
        `seasonsurvivalindex` bigint COMMENT "赛季参赛指数",
        `seasontop1index` bigint COMMENT "赛季获胜率指数",
        `seasonratingindex` bigint COMMENT "赛季总积分指数",
        `seasonassaultindex` bigint COMMENT "赛季竞赛指数",
        `seasonhealindex` bigint COMMENT "赛季支援指数",
        `seasonmovingindex` bigint COMMENT "赛季前进指数",
        `seasonsumscore` bigint COMMENT "赛季总评分，乘以100后存入",
        `seasonratinglevel` bigint COMMENT "赛季评价等级",
        `modesurvivalindex` bigint COMMENT "当前模式参赛指数",
        `modetop1index` bigint COMMENT "当前模式获胜率指数",
        `moderatingindex` bigint COMMENT "当前模式总积分指数",
        `modeassaultindex` bigint COMMENT "当前模式竞赛指数",
        `modehealindex` bigint COMMENT "当前模式支援指数",
        `modemovingindex` bigint COMMENT "当前模式前进指数",
        `modesumscore` bigint COMMENT "当前模式总评分，乘以100后存入",
        `moderatinglevel` bigint COMMENT "当前模式评价等级",
        `flowratinglevel` string COMMENT "当局游戏的评价等级，前面有个Int类型的，但是非要求加一个字符串类型的",
        `rolename` string COMMENT "玩家角色名",
        `totaldamage` bigint COMMENT "赛季分人称几排总伤害量",
        `totalheal` bigint COMMENT "赛季分人称几排总治疗量",
        `matchtype` bigint COMMENT "匹配模式0：手机 1模拟器 8小黑屋 9新手局",
        `duocontributionrankrating` bigint COMMENT "双人总积分贡献分",
        `duocontributionkillrating` bigint COMMENT "双人击败积分贡献分",
        `duocontributionwinrating` bigint COMMENT "双人生存积分贡献分",
        `squadcontributionrankrating` bigint COMMENT "四人总积分贡献分",
        `squadcontributionkillrating` bigint COMMENT "四人击败积分贡献分",
        `squadcontributionwinrating` bigint COMMENT "四人生存积分贡献分",
        `famousid` bigint COMMENT "名人名言tips ID",
        `dsendtime` string COMMENT "新结束时间字段，ds传过来的字符串",
        `equipmentinfo` string COMMENT "装备信息:头盔ID\t防弹衣ID\t背包ID\t主武器1ID\t主武器1配件ID列表(以,分隔)\t主武器2ID\t主武器2配件ID列表(以,分隔)\t副武器ID\t副武器配件ID列表(以,分隔)\t近战武器ID\t投掷武器ID\t是否佩戴吉利服",
        `segmentprotect` bigint COMMENT "段位保护标记，1为触发了该段位的段位保护，0为没有触发",
        `ismvp` bigint COMMENT "不是mvp 0/是mvp 1",
        `pronetime` bigint COMMENT "趴地时间",
        `followstate` bigint COMMENT "跳伞跟随  0不跟随，也不被跟随；1是被跟随；2是跟随",
        `touchdownareaid` bigint COMMENT "降落地点类型, 参见赛季任务降落地点类型表",
        `getpropsnumfromteammates` bigint COMMENT "接受队友道具数",
        `sendpropsnumtoteammates` bigint COMMENT "赠送队友道具数",
        `starttorescuetimes` bigint COMMENT "开始救援次数",
        `avatargamegender` bigint COMMENT "Avatar性别",
        `avatarhairid` bigint COMMENT "Avatar发型",
        `avatarheadid` bigint COMMENT "Avatar脸型",
        `avatarfeaturenum` bigint COMMENT "Avatar时装个数",
        `avatarfeaturelist_1` bigint COMMENT "Avatar时装",
        `avatarfeaturelist_2` bigint COMMENT "Avatar时装",
        `avatarfeaturelist_3` bigint COMMENT "Avatar时装",
        `avatarfeaturelist_4` bigint COMMENT "Avatar时装",
        `avatarfeaturelist_5` bigint COMMENT "Avatar时装",
        `avatarfeaturelist_6` bigint COMMENT "Avatar时装",
        `avatarfeaturelist_7` bigint COMMENT "Avatar时装",
        `avatarfeaturelist_8` bigint COMMENT "Avatar时装",
        `avatarfeaturelist_9` bigint COMMENT "Avatar时装",
        `avatarfeaturelist_10` bigint COMMENT "Avatar时装",
        `avatarweaponid` bigint COMMENT "Avatar枪械",
        `avatarweaponskinid` bigint COMMENT "Avatar枪械皮肤",
        `killeruid` string COMMENT "击杀者UID",
        `killerweaponid` bigint COMMENT "击杀者使用武器ID",
        `killerdistance` bigint COMMENT "击杀者距离",
        `lobbyteamid` string COMMENT "大厅队伍id,ug字段，兼容保留",
        `makefiresnum` bigint COMMENT "生火成功次数,极寒模式",
        `isregress` bigint COMMENT "是否回流",
        `topxtipsresponse` bigint COMMENT "未进入前5:-1;不点击:0;继续战斗:1;退出竞赛:2",
        `signalhealamount` bigint COMMENT "信号治疗量",
        `drivinghelicoptertime` bigint COMMENT "驾驶直升飞机时间",
        `inhelicoptertime` bigint COMMENT "乘坐直升飞机时间",
        `noreductratingscore` bigint COMMENT "是否触发了不掉分活动",
        `changedtrueratingvalue` bigint COMMENT "true rating分变化值",
        `trueratingvalueallianceforceterchanged` bigint COMMENT "true rating分变化后的值",
        `teammemberrelalist` string COMMENT "与TeamMemberList相对应，与其他队员之间的好友关系（0非好友，1平台好友，2为游戏好友）拼接，多个好友之间用+拼接。例如1+2+2",
        `teammembersexlist` string COMMENT "与TeamMemberList相对应，其他队员的性别拼接（1表示男，2表示女），多个好友之间用+拼接。例如1+2+2",
        `friendcount` bigint COMMENT "队友中的好友数量",
        `maxhurtweaponid` bigint COMMENT "最大伤害的武器ID",
        `maxdamage` bigint COMMENT "武器的最大伤害",
        `allianceforceterlevel` bigint COMMENT "结算后等级",
        `isobexit` bigint COMMENT "是否观战退出",
        `noreductrating` bigint COMMENT "是否触发不掉分活动",
        `extraaddrating` bigint COMMENT "是否触发首战加分活动",
        `protectrating` bigint COMMENT "是否触发保分机制",
        `doublescore` bigint COMMENT "是否触发双倍上分活动",
        `fateaddscore` bigint COMMENT "是否触发缘分队友加分活动",
        `isnewaistrategy` bigint COMMENT "是否新的AI策略",
        `lobbymemberlist` string COMMENT "大厅组队队友列表",
        `ratingtype` bigint COMMENT "计算的排位积分类型",
        `killername` string COMMENT "击杀我的人的名字",
        `changekd` bigint COMMENT "当局结算引起的KD变化值，乘100后存入",
        `friendteamaddscore` bigint COMMENT "是否触发好友四排组队加分活动",
        `xuanwunoreductrating` bigint COMMENT "是否触发玄武不掉分活动",
        `gunmateriallist` string COMMENT "枪匠模式对局带出的改装件",
        `bountynum` bigint COMMENT "枪匠模式的赏金数量",
        `evacuatetype` bigint COMMENT "枪匠模式的逃脱类型。0 没有逃脱，1 直升机， 2 地堡， 3 的士",
        `triggerrepeatkilllimit` bigint COMMENT "触发重复击杀限制",
        `doublescoretimes` bigint COMMENT "是否触发双倍上分次数活动",
        `teammembertmrelalist` string COMMENT "Avatar时装",
        `device_type` bigint COMMENT "设备类型0为手机 1为模拟器 2 键鼠 3 手柄"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_argothek_playerloadout_sprayslots_hi` (
        `tdbank_imp_date` string COMMENT "分区字段",
        `dteventtime` string COMMENT "AP 事件时间: YYYY-MM-DD HH:MM:SS",
        `apeventid` string COMMENT "AP 事件标识符，由 TLIS 生成",
        `apchildid` string COMMENT "AP 子标识符，由 TLIS 生成，并在主条目 apPlayerLoadout.spraySlots 中引用",
        `apchildindex` bigint COMMENT "AP 子索引，由 TLIS 生成",
        `sprayslotid` string COMMENT "喷漆槽位 ID - 喷漆槽位标识符",
        `sprayid` string COMMENT "喷漆 ID - 喷漆标识符",
        `spraylevelid` string COMMENT "喷漆等级 ID - 喷漆等级标识符",
        `subject` string COMMENT "RSO PUUID - RFC 0214g - RSO 玩家 ID: Riot 玩家的全局唯一 ID",
        `matchinfoversion` string COMMENT "Ares 构建版本 - Ares 二进制文件的完整构建版本",
        `matchinfomatchid` string COMMENT "Ares 匹配 ID - Ares 匹配的 ID 字符串",
        `matchinfogamemode` string COMMENT "Ares 游戏模式 - 正在进行的比赛类型",
        `matchinfomapid` string COMMENT "Ares 地图 - Ares 地图的名称",
        `matchinfoqueueid` string COMMENT "Ares 队列 ID - Ares 队列的 ID 字符串",
        `matchinfoisranked` bigint COMMENT "布尔值 - 一个布尔值",
        `matchinfoprvflowid` string COMMENT "配置流程 ID - 已配置的游戏类型。例如：技能测试、匹配等"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_jordass_matchlog_stat_di` (
        `dtstatdate` string COMMENT "分区，参与乐园日期，格式YYYYMMDD",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android255:所有平台",
        `vplayerid` string COMMENT "玩家ID",
        `imode` bigint COMMENT "乐园子玩法：	255-所有玩法，'用户问题'未提到明确的子玩法时，默认为所有玩法	1282371711108385024-跑酷：成神之路	1281086178576044544-传媒群岛	1305619333337074432-狂热派对	1251206313870885120-砺刃运动会5.0	1313754433693158656-手球特攻（原足球游戏）	1296730563346958080-盔仔泡泡小队	1294279575841283072-夺宝行动	1310822585431254784-桥梁争夺	1278160113246405632-砺刃大亨	1313047366167692288-逆转平底锅	1298874468735655936-战车突袭	1278948391311645952-能量争夺战	1295942084687041792-趣味飞盘	1282101477461985024-盔仔总动员	1278144466094392064-黑五模拟器	1313046652157690624-盔仔斗魔王（原盔仔大乱斗）	1289446028099979264-佣兵阵线	1309453077449826304-星星争夺战（原名：金币大作战）	1298445174154728192-停车大作战	1294211358396518400-特技大乱斗	1280302176000803840-卧底行动	1307095884553538304-超级隐匿（原广阔天地隐匿模式）1297394991875754752-守卫生命线	1278170390282112000-星球守护者	1287652322611036928-拼图狂欢	1273928195100380928-特种兵训练	1300845150154531840-星之继承者	1302344773925865984-彩色争夺战	1296062239742105856-抱团冲冲冲	1281781308570207232-狙击精英",
        `teamnum` bigint COMMENT "组队人数",
        `icnt` bigint COMMENT "对局次数",
        `itemp1` bigint COMMENT "对局时长",
        `itemp2` bigint COMMENT "itemp2",
        `vtemp1` string COMMENT "vtemp1",
        `vtemp2` string COMMENT "vtemp2"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_playerlogout_hi` (
        `tdbank_imp_date` string COMMENT "小时分区字段，格式YYYYMMDDHH",
        `gamesvrid` string COMMENT "登录的游戏服务器编号",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "玩家ID",
        `uid` string COMMENT "玩家UID",
        `onlinetime` bigint COMMENT "本次登录在线时间(秒)",
        `level` bigint COMMENT "等级",
        `playerfriendsnum` bigint COMMENT "玩家好友数量",
        `clientversion` string COMMENT "客户端版本",
        `loginchannel` bigint COMMENT "登录渠道",
        `deviceid` string COMMENT "设备ID",
        `ticket` bigint COMMENT "点券",
        `itemcoin` bigint COMMENT "物资币",
        `luckycoin` bigint COMMENT "幸运币",
        `ironcoin` bigint COMMENT "荣耀勋章",
        `diamond` bigint COMMENT "服饰币",
        `corpsid` string COMMENT "联盟ID",
        `corpsname` string COMMENT "联盟名称",
        `clannum` bigint COMMENT "玩家战队数量",
        `clanid1` bigint COMMENT "战队ID1",
        `clanid2` bigint COMMENT "战队ID2",
        `clanid3` bigint COMMENT "战队ID3",
        `logoutreason` string COMMENT "登出原因",
        `gameid` string COMMENT "当前正在游戏的对局id",
        `rolesettingstr` string COMMENT "RoleSetting设置, 当为空字符串时表示该字段获取异常,否则为以+分隔的rolesetting值，具体字段值咨询开发",
        `historytotalcharm` bigint COMMENT "历史总魅力值",
        `device_type` bigint COMMENT "设备类型0为手机,1为模拟器, 2键鼠, 3手柄, 5是PC客户端,也是高清模拟器。",
        `clientostype` string COMMENT "客户端系统类型：and ios win hm"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_vplayerid_vies_df` (
        `dtstatdate` string COMMENT "统计日期",
        `vgameappid` string COMMENT "系统",
        `vplayerid` string COMMENT "gplayerid",
        `suserid` string COMMENT "suserid",
        `suserid_type` string COMMENT "suserid类型",
        `itag` string COMMENT "用户分层标签",
        `is_reg` bigint COMMENT "是否当日新进",
        `is_actv` bigint COMMENT "是否当日活跃",
        `is_neibu` bigint COMMENT "是否内部玩家",
        `is_lowfps` bigint COMMENT "是否新进低帧率",
        `cbitmap` string COMMENT "活跃位图最左最新活跃",
        `gender` string COMMENT "性别",
        `province` string COMMENT "省份",
        `city` string COMMENT "城市",
        `city_level` string COMMENT "城市等级",
        `iregdate` string COMMENT "注册日期",
        `iregdate_agamek6` string COMMENT "注册日期_端游",
        `lastdate` string COMMENT "最后活跃日期",
        `lastdate_agamek6` string COMMENT "最后活跃日期_端游",
        `lastdays` bigint COMMENT "当日距离最后活跃的天数",
        `lastdays_agamek6` bigint COMMENT "当日距离最后活跃的天数_未注册为-1_当日活跃为1_上日活跃为2",
        `lastdays_fps` bigint COMMENT "FPS手游",
        `lastdays_vie1` bigint COMMENT "战役先锋手游 esports",
        `lastdays_vie2` bigint COMMENT "突出重围 mobile_live",
        `lastdays_vie3` bigint COMMENT "枪火争锋手游 allianceforce",
        `lastdays_vie4` bigint COMMENT "豪杰对决 strategy",
        `lastdays_vie5` bigint COMMENT "砺刃使者 jordass",
        `lastdays_vie6` bigint COMMENT "天弈 su ",
        `lastdays_vie7` bigint COMMENT "勇士召唤手游 playzone ",
        `lastdays_vie8` bigint COMMENT "峡谷手游活跃 initiatived",
        `lastdays_vie9` bigint COMMENT "峡谷全量活跃 initiatived",
        `lastdays_vie10` bigint COMMENT "峡谷端游活跃 initiatived",
        `lastdays_vie11` bigint COMMENT "预留",
        `lastdays_vie12` bigint COMMENT "预留",
        `lastdays_vie13` bigint COMMENT "预留",
        `lastdays_vie14` bigint COMMENT "预留",
        `lastdays_vie15` bigint COMMENT "预留",
        `vtemp1` string COMMENT "预留",
        `vtemp2` string COMMENT "预留",
        `vtemp3` string COMMENT "预留",
        `itemp1` bigint COMMENT "预留",
        `itemp2` bigint COMMENT "预留",
        `itemp3` bigint COMMENT "预留"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_jordass_submodeonline_nf` (
        `matchsubmodegroup` bigint COMMENT "子玩法",
        `matchsubmodegroupname` string COMMENT "子玩法名",
        `onlinedate` string COMMENT "上线日期",
        `itemp1` bigint COMMENT "预留数字1",
        `itemp2` bigint COMMENT "预留数字2",
        `vtemp1` string COMMENT "预留字符1",
        `vtemp2` string COMMENT "预留字符2"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`matchsubmodegroup`)
    DISTRIBUTED BY HASH (`matchsubmodegroup`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_mgamejp_idconversion_wxid_qq_nf` (
        `dtstatdate` bigint COMMENT "统计日期YYYYMMDD",
        `swxid` string COMMENT "微信wxid",
        `iqq` bigint COMMENT "QQ号"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_argothek_abilityinfo_effects_hi` (
        `tdbank_imp_date` string COMMENT "分区字段",
        `dteventtime` string COMMENT "AP 事件时间: YYYY-MM-DD HH:MM:SS",
        `apeventid` string COMMENT "AP 事件标识符，由 TLIS 生成",
        `apchildid` string COMMENT "AP 子标识符，由 TLIS 生成，并在主条目 apAbilityUseEvent.AbilityInfoAbilityEffects 中引用",
        `apchildindex` bigint COMMENT "AP 子索引，由 TLIS 生成",
        `tag` string COMMENT "技能效果标签 - 技能效果的标签",
        `amount` double COMMENT "效果计数 - 技能效果的总值",
        `allianceforcefectedtargets` string COMMENT "AP 子标识符，指向子结构：apAbilityUseEvent_AbilityInfoAbilityEffects_AffectedTargets",
        `matchinfomatchid` string COMMENT "Ares 匹配 ID - Ares 匹配的 ID 字符串",
        `playerinfosubject` string COMMENT "RSO PUUID - RFC 0214g - RSO 玩家 ID: Riot 玩家的全局唯一 ID",
        `roundinforoundnumber` bigint COMMENT "回合编号 - Ares 匹配的回合编号",
        `playerinfoteamid` string COMMENT "Ares 队伍 ID - Ares 队伍 ID"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_friendlist_hi` (
        `tdbank_imp_date` string COMMENT "",
        `gamesvrid` string COMMENT "登录的游戏服务器编号",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID",
        `type` bigint COMMENT "好友类型(1 平台 2 游戏内), 两种类型的好友可能重合",
        `num` bigint COMMENT "好友总个数",
        `list` string COMMENT "当前段好友列表",
        `seg` bigint COMMENT "当前是第几段"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_jordass_leyuan_participate_cdf_nf` (
        `dtstatdate` string COMMENT "日期格式YYYYMMDD",
        `matchsubmodegroup` bigint COMMENT "乐园子玩法id",
        `vplayerid` string COMMENT "playerid",
        `cbitmap` string COMMENT "活动参与位图",
        `dregdate` string COMMENT "首次参与该子玩法日期",
        `itemp1` bigint COMMENT "预留数字1",
        `itemp2` bigint COMMENT "预留数字2",
        `vtemp1` string COMMENT "预留字符1",
        `vtemp2` string COMMENT "预留字符2"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_mgamejp_login_user_activity_di` (
        `dtstatdate` bigint COMMENT "统计日期YYYYMMDD",
        `saccounttype` string COMMENT "帐号类型:QQ号或者微信",
        `suserid` string COMMENT "帐号",
        `suseridtype` string COMMENT "帐号类型:qq wxid playerid ",
        `sgamecode` string COMMENT "业务 ",
        `splattype` string COMMENT "平台类型(大平台)。枚举值为Android/ iOS，取汇总时取-100 ",
        `splat` string COMMENT "平台(小平台)。备注：写死的-100",
        `sgameparam` string COMMENT "场次",
        `schannel` string COMMENT "不可用字段，用户可以忽略 ",
        `sip` string COMMENT "实际上是当日登录的最小时间戳，即最早登录时间",
        `sclientver` string COMMENT "客户端版本",
        `ilevel` bigint COMMENT "用户等级。不可用",
        `iviplevel` bigint COMMENT "Vip等级。不可用",
        `itimes` bigint COMMENT "活跃总次数。备注：该字段表示用户在T日的当日活跃总次数",
        `ionlinetime` bigint COMMENT "活跃总时间。备注：该字段表示用户在T日的当日活跃总时间"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_argothek_ce1_cbt2_vplayerid_suserid_di` (
        `dtstatdate` string COMMENT "统计日期",
        `vgameappid` string COMMENT "无汇总",
        `platid` bigint COMMENT "0 - Android,1,255",
        `vplayerid` string COMMENT "gplayerid",
        `suserid` string COMMENT "suserid",
        `suserid_type` string COMMENT "suserid的类型",
        `iregdate` string COMMENT "注册日期",
        `iregway` string COMMENT "注册渠道-不区分platid",
        `iloginway` string COMMENT "活跃渠道",
        `sourcename` string COMMENT "开白渠道",
        `itag` string COMMENT "用户分层标签",
        `ilevel` bigint COMMENT "最新等级",
        `ionlinetime` string COMMENT "在线时长秒",
        `iroundtime` string COMMENT "游戏时长秒",
        `iroundcnt` string COMMENT "对局次数",
        `fps_avg` string COMMENT "当日平均帧率-gplayerid维度",
        `is_reg` string COMMENT "是否当日新进",
        `is_lowfps` string COMMENT "是否低帧率-新进首日平均帧率不高于40且没有帧率数据的用户不计入",
        `is_match` string COMMENT "是否当日对局",
        `vtemp1` string COMMENT "预留",
        `vtemp2` string COMMENT "预留",
        `vtemp3` string COMMENT "预留",
        `itemp1` bigint COMMENT "预留",
        `itemp2` bigint COMMENT "预留",
        `itemp3` bigint COMMENT "预留"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_argothek_oss_portaltransaction_di` (
        `statis_date` string COMMENT "统计时间",
        `iworldid` bigint COMMENT "portal一般获取不到大区ID,建议不要使用此数据做分大区统计",
        `iuserid` string COMMENT "用户ID",
        `vspoaid` string COMMENT "支付业务代码",
        `ftrantime` string COMMENT "支付发生时间",
        `ftranplat` string COMMENT "支付平台",
        `ftransource` string COMMENT "支付渠道,非业务侧定义的用户渠道",
        `ftranrealamt` bigint COMMENT "折前支付金额",
        `ftranamt` bigint COMMENT "折后支付金额",
        `vpf` string COMMENT "支付PF字段",
        `ext_str1` string COMMENT "支付信息字段",
        `vusertype` string COMMENT "用户类型,qq或wx",
        `extcol1` bigint COMMENT "玩家等级",
        `vextcol1` string COMMENT "游戏时长",
        `offerid` string COMMENT "offerid"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`statis_date`)
    DISTRIBUTED BY HASH (`statis_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_vsteam_roundrecord_hi` (
        `tdbank_imp_date` string COMMENT "小时分区字段，格式YYYYMMDDHH",
        `gamesvrid` string COMMENT "登录的游戏服务器编号",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "玩家",
        `uid` string COMMENT "玩家UID",
        `battleid` string COMMENT "对局ID",
        `mode` bigint COMMENT "模式",
        `submode` bigint COMMENT "子模式",
        `map` bigint COMMENT "地图",
        `startime` bigint COMMENT "开局时刻",
        `endtime` bigint COMMENT "结束时刻",
        `escapecheckup` bigint COMMENT "是否逃跑，0否；1是",
        `roundtime` bigint COMMENT "对局时长(秒)",
        `gold` bigint COMMENT "金钱变化值",
        `level` bigint COMMENT "等级变化值",
        `playernumber` bigint COMMENT "玩家数",
        `realplayernumber` bigint COMMENT "真人玩家数",
        `teamid` bigint COMMENT "红蓝队ID",
        `teammemberlist` string COMMENT "队友List，包括自己的uid，\t间隔",
        `teamrank` bigint COMMENT "队伍排名，结合Result看结果，因为有可能平局",
        `sumscore` bigint COMMENT "KDA评分*1000",
        `ismvp` bigint COMMENT "mvp标识 0否；1是",
        `killingcount` bigint COMMENT "击杀",
        `assistcount` bigint COMMENT "助攻次数",
        `gunkillingtimes` bigint COMMENT "枪械击杀数",
        `meleekilltimes` bigint COMMENT "近战击杀数",
        `headshotcounts` bigint COMMENT "爆头数",
        `damageamount` bigint COMMENT "总伤害量,浮点数，乘以100存入",
        `rangeddamagedamount` bigint COMMENT "远程武器伤害量，暂无",
        `meleedamageamount` bigint COMMENT "近战伤害量",
        `gunhittimes` bigint COMMENT "枪械命中次数",
        `gunshottimes` bigint COMMENT "枪械射击次数",
        `movingdistance` bigint COMMENT "前进距离",
        `healamount` bigint COMMENT "治疗量，浮点数，乘以100存入",
        `curecount` bigint COMMENT "治疗次数",
        `medicineuseflow` string COMMENT "使用的药品流水",
        `changedratingvalue` bigint COMMENT "组队竞技rating分变化值,如果是极能形态极能形态组竞或者消灭战组竞这种有独立积分的，就是对应模式独立积分的变化值",
        `ratingvalueallianceforceterchanged` bigint COMMENT "组队竞技rating分变化后的值,如果是极能形态极能形态组竞或者消灭战组竞这种有独立积分的，就是对应模式独立积分的变化后的值",
        `result` string COMMENT "游戏结果(Win,Draw,OneScoreWin,Landslide,这四个胜利，Fail失败,空:逃跑)",
        `maxcontinuoukills` bigint COMMENT "最大连杀",
        `supergodnum` bigint COMMENT "超神次数",
        `killingflow` string COMMENT "击杀流水 死者ID\t击杀类型\t是否爆头\t击杀距离\t击杀使用物品id\t击杀者坐标\t被击杀者坐标\t击杀时间（倒计时开始到击杀时的毫秒数）\t造成伤害量\t是否移动\t区域id(-1表示区域表中不记录)\t被击倒的武器id\t击杀圈数\t被击杀者名字\t是否灭队\t是否为ai\tAI的类型\t击倒者uid\t击杀者uid",
        `medallist` string COMMENT "勋章列表 勋章1id\t勋章1数量\t勋章2id\t勋章2数量\t...",
        `vsteamlevel` bigint COMMENT "组竞等级",
        `vsteamlevelchange` bigint COMMENT "组竞等级变化值",
        `myteamtotalkill` bigint COMMENT "我的队伍击杀人数",
        `enemyteamtotalkill` bigint COMMENT "敌方队伍击杀人数",
        `occupytime` bigint COMMENT "据点战我占点时间",
        `occupyscore` bigint COMMENT "据点战我占点分数",
        `occupycount` bigint COMMENT "据点战我夺取占点次数",
        `occupydamage` bigint COMMENT "据点战我的攻防伤害",
        `occupyweaponboxcount` bigint COMMENT "据点战武器箱拾取次数",
        `occupyweaponboxflow` string COMMENT "据点战武器箱拾取流水 物品id1,物品id2....",
        `friendcount` bigint COMMENT "队友中的好友数量",
        `teammemberrelalist` string COMMENT "与TeamMemberList相对应，与其他队员之间的好友关系（0非好友，1平台好友，2为游戏好友）拼接，多个好友之间用+拼接。例如1+2+2",
        `teammembersexlist` string COMMENT "与TeamMemberList相对应，其他队员的性别拼接（1表示男，2表示女），多个好友之间用+拼接。例如1+2+2",
        `deadcount` bigint COMMENT "死亡数",
        `addexp` bigint COMMENT "团竟经验变化值",
        `totalvsteamexp` bigint COMMENT "总的团竟经验值",
        `infectscore` bigint COMMENT "生化模式总积分",
        `infectrank` bigint COMMENT "生化模式排名",
        `occupyscoremyteam` bigint COMMENT "据点战我的队伍占点分，结算大比分",
        `occupyscoreotherteam` bigint COMMENT "据点战敌方队伍占点分，结算大比分",
        `modescore` bigint COMMENT "特殊模式单局内积分",
        `modechangedrating` bigint COMMENT "特殊模式对应rating分变化值，现在是隐匿模式的经验",
        `moderatingallianceforceterchanged` bigint COMMENT "特殊模式对应rating分变化后的值，现在是隐匿模式的经验",
        `modelevel` bigint COMMENT "特殊模式对应等级",
        `survivetime` bigint COMMENT "隐匿模式模式幸存数",
        `scoresource` string COMMENT "模式积分来源",
        `oweruid` string COMMENT "房主uid",
        `teammembertmrelalist` string COMMENT "与TeamMemberList相对应，与其他队员之间的默契好友关系（1是0非）拼接，多个好友之间用+拼接。例如1+0+1",
        `myteamscore` bigint COMMENT "我的队伍得分",
        `enemyteamscore` bigint COMMENT "敌方队伍得分",
        `heroinfo` string COMMENT "极能形态组竞使用职业列表：职业id:存活时间,伤害量+职业id:存活时间,伤害量",
        `herotaglist` string COMMENT "极能形态组竞二次分队使用的职业标签列表：职业id+职业id",
        `deathflow` string COMMENT "极能形态组竞死亡流水:死亡时间,死亡坐标x,死亡坐标y,死亡坐标z+死亡时间,死亡坐标x,死亡坐标y,死亡坐标z",
        `herokillinfo` string COMMENT "极能形态组竞职业击杀:自己使用的职业id,对方uid,对方职业id+自己使用的职业id,对方uid,对方职业id",
        `herodeathinfo` string COMMENT "极能形态组竞职业死亡:自己使用的职业id,对方uid,对方职业id+自己使用的职业id,对方uid,对方职业id",
        `playid` bigint COMMENT "限时模式的玩法id,非限时模式则为0",
        `playerabtest` string COMMENT "个人匹配abtest",
        `gameabtest` string COMMENT "匹配对局的abtest,没有则为空字符串",
        `enemytagnum` bigint COMMENT "拾蛋组竞，拾取敌方蛋的数量",
        `teammatetagnum` bigint COMMENT "拾蛋组竞，拾取己方蛋的数量",
        `transformtochickennum` bigint COMMENT "拾蛋组竞，变身鸡哥的次数",
        `device_type` bigint COMMENT "设备类型0为手机 1为模拟器 2 键鼠 3 手柄",
        `roundresultlist` string COMMENT "消灭战1.5和爆破模式，回合胜负 campid:iswin+campid:iswin",
        `loadbombcount` bigint COMMENT "爆破模式,成功安装炸弹次数",
        `defusebombcount` bigint COMMENT "爆破模式,成功拆除炸弹次数",
        `tryplacebombnum` bigint COMMENT "爆破模式,点击安装按钮次数",
        `trydemolishbombnum` bigint COMMENT "爆破模式,点击拆除按钮次数",
        `throwableusenumlist` string COMMENT "爆破模式，投掷物使用次数 itemid:num+itemid:num",
        `grenadekillnum` bigint COMMENT "爆破模式,手雷击杀数",
        `grenadedamage` bigint COMMENT "爆破模式,手雷伤害总数",
        `chooseareaid` bigint COMMENT "消灭战1.5模式,点击选择区域ID",
        `playerroundrole` string COMMENT "极能形态爆破模式，角色选择 roundid:heroid+roundid:heroid",
        `playergameendrole` bigint COMMENT "爆破模式，结束角色选择",
        `playerswitchrole` bigint COMMENT "爆破模式，角色切换次数",
        `playerultimateskillenergy` string COMMENT "爆破模式，终极技能充能量获取总量",
        `playerultimateskillcount` bigint COMMENT "爆破模式，终极技能释放次数",
        `playerultimateskillround` string COMMENT "极能形态爆破模式，终极技能最早释放回合数 heroid:roundid",
        `playergamestartrole` bigint COMMENT "爆破模式，是否在初始准备阶段完成选角",
        `playerlivetime` string COMMENT "PlayerLiveTime ",
        `playerroundaddoninfo` string COMMENT "PlayerRoundAddonInfo ",
        `playerroundrefreshpoint` string COMMENT "PlayerRoundRefreshPoint ",
        `playeraihostcount` bigint COMMENT "PlayerAIHostCount ",
        `playeraihostduration` bigint COMMENT "PlayerAIHostDuration ",
        `changewarmscore` bigint COMMENT "ChangeWarmScore ",
        `allianceforceterwarmscore` bigint COMMENT "AfterWarmScore "
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_argothek_gplayerid2qqwxid_df` (
        `dtstatdate` string COMMENT "日期",
        `vgameappid` string COMMENT "平台",
        `iareaid` string COMMENT "大区",
        `iuserid` string COMMENT "用户id",
        `vroleid` string COMMENT "角色id",
        `iversion` string COMMENT "服务器",
        `cbitmap` string COMMENT "活跃位图",
        `iregdate` string COMMENT "注册日期",
        `swxid_type` string COMMENT "wx或qq类型",
        `suserid` string COMMENT "存储qq/wxid如果微信和qq有绑定关系优先qq",
        `sqq` string COMMENT " 该字段为废弃字段，使用转qq时使用suserid",
        `swxid` string COMMENT " 该字段为废弃字段，使用转qq时使用wxid",
        `itemp1` bigint COMMENT "预留字段1",
        `itemp2` bigint COMMENT "预留字段2",
        `itemp3` bigint COMMENT "预留字段3",
        `itemp4` bigint COMMENT "预留字段4",
        `vtemp1` string COMMENT "预留字段5",
        `vtemp2` string COMMENT "预留字段6",
        `vtemp3` string COMMENT "预留字段7",
        `vtemp4` string COMMENT "预留字段8",
        `vtemp5` string COMMENT "预留字段9"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_voicethemelog_hi` (
        `tdbank_imp_date` string COMMENT "",
        `gamesvrid` string COMMENT "登录的游戏服务器编号",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID",
        `baseid` bigint COMMENT "胚子ResID",
        `level` bigint COMMENT "等级",
        `effectid` bigint COMMENT "解锁语音主题效果ID"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_activity_rewardrecord_hi` (
        `tdbank_imp_date` string COMMENT "小时分区字段，格式YYYYMMDDHH",
        `gamesvrid` string COMMENT "登录的游戏服务器编号",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID",
        `actid` bigint COMMENT "		活动id",
        `acttype` bigint COMMENT "活动类型",
        `awardidx` bigint COMMENT "第几挡奖励",
        `awardcnt` bigint COMMENT "兑换几次 默认1次",
        `value` bigint COMMENT "扩展字段(不同业务解释)",
        `reissueflag` bigint COMMENT "活动补发字段，默认为0不补发，1为补发",
        `cond1` bigint COMMENT "条件1值，任务大类型",
        `cond2` bigint COMMENT "条件2值，任务子类型",
        `cond3` bigint COMMENT "条件3值，任务条件值",
        `device_type` bigint COMMENT "设备类型0为手机,1为模拟器, 2键鼠, 3手柄, 5是PC客户端,也是高清模拟器。"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_mgamejp_account_allinfo_nf` (
        `dtstatdate` bigint COMMENT "统计日期YYYYMMDD",
        `saccounttype` string COMMENT "帐号类型。0-分游戏的playerid，及汇总的qq，且这些qq都是playerid对应的1-分游戏的playerid，及汇总的wxid，且这些wxid都是playerid对应的-100-汇总",
        `suserid` string COMMENT "帐号。当存储的是playerid账号类型时，对于新游存储的是gplayerid，对于老游戏存储的是playerid",
        `suseridtype` string COMMENT "帐号类型。取值为qq/wxid/playerid，没有-100",
        `sgamecode` string COMMENT "游戏id。取值为-100时表示汇总，其它取值为各单业务的游戏id，例如取值为strategy时表示豪杰对决",
        `splattype` string COMMENT "平台类型(大平台)。取值为-100时表示汇总，取值为Android时表示安卓平台，取值为iOS时表示苹果平台",
        `splat` string COMMENT "平台(小平台)。备注：写死的-100",
        `iregdate` bigint COMMENT "注册日期YYYYMMDD",
        `ilastactdate` bigint COMMENT "最后活跃日期YYYYMMDD",
        `sdayacti` string COMMENT "最近65天每天活跃情况。以二进制位图形式存储，每一位表示一天的活跃情况，1表示活跃，0表示未活跃。最左的一位表示T日，以此类推",
        `sweekacti` string COMMENT "最近60周活跃情况。用法同上",
        `smonthacti` string COMMENT "最近60月活跃情况。用法同上",
        `sgroup` string COMMENT "用来标识用户是否付费用户，是否包月用户等等备注：该字段实际上表示注册的时间戳，2018-04之前以YYYYMMDD格式，2018-04之后以YYYYMMDDHHMMSS格式",
        `ilevel` bigint COMMENT "用户等级。废弃字段",
        `iviplevel` bigint COMMENT "Vip等级。废弃字段",
        `itimes` bigint COMMENT "活跃总次数备注：该字段表示用户从注册到T日的累计活跃总次数，注意是累计值",
        `ionlinetime` bigint COMMENT "活跃总时间备注：该字段表示用户从注册到T日的累计活跃总时间，注意是累计值，单位为秒；存在负数，使用时需要剔除"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_uf_player_gameinfo_mf` (
        `kp_imp_date` string COMMENT "分区字段格式YYYYMM",
        `id_type` string COMMENT "账号类型：qq/wx",
        `userid` string COMMENT "账号",
        `gender` bigint COMMENT "性别（1男2女）",
        `city` string COMMENT "城市",
        `province` string COMMENT "省份",
        `city_level` string COMMENT "城市等级"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`kp_imp_date`)
    DISTRIBUTED BY HASH (`kp_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_playerexitgamerecord_hi` (
        `tdbank_imp_date` string COMMENT "",
        `gamesvrid` string COMMENT "登录的游戏服务器编号",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID",
        `gameid` string COMMENT "本局游戏ID",
        `exitreason` string COMMENT "退出原因",
        `isallianceforceeescape` bigint COMMENT "逃跑时是否安全的 否:0/是:1",
        `escapebantype` bigint COMMENT "本次退出是否触发禁赛限制，0=没有触发；1=触发限制一；2=触发限制二；3=触发限制三",
        `gamestate` string COMMENT "退出时对局状态：Active是在出生岛之前，Ready是在出生岛，Fighting是包括4人集结、上飞机、跳伞战斗这些阶段，Finish 死亡/胜利结束",
        `submodegroup` bigint COMMENT "模式组ID",
        `lobbyexitreason` string COMMENT "大厅记录的退出原因",
        `mode` bigint COMMENT "模式ID",
        `submode` bigint COMMENT "子模式ID",
        `roundtime` bigint COMMENT "对局时长"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_privpackagelog_hi` (
        `tdbank_imp_date` string COMMENT "",
        `gamesvrid` string COMMENT "登录的游戏服务器编号",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID",
        `packageid` bigint COMMENT "补给包ID",
        `opendays` bigint COMMENT "购买天数",
        `moneytype` bigint COMMENT "购买货币类型",
        `moneycnt` bigint COMMENT "购买货币数据",
        `oldbegintime` bigint COMMENT "老的开始时间",
        `oldendtime` bigint COMMENT "老的结束时间",
        `newbegintime` bigint COMMENT "新的开始时间",
        `newendtime` bigint COMMENT "新的结束时间",
        `additems` string COMMENT "获得道具列表，resid1-cnt1-hour1-extra_id1:resid2-cnt2-hour2-extra_id2",
        `openway` bigint COMMENT "开通方式, 1:直购，2:点券支付，3:使用仓库物品"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_msgchatrecord_hi` (
        `tdbank_imp_date` string COMMENT "",
        `gamesvrid` string COMMENT "登录的游戏服务端编号",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `gameappid` string COMMENT "游戏APPID",
        `playerid` string COMMENT "发送方用户playerid号",
        `platid` bigint COMMENT "ios 0 /android 1",
        `areaid` bigint COMMENT "微信 1 /手Q 2 /游客 3",
        `zoneid` bigint COMMENT "小区号id",
        `clientversion` string COMMENT "客户端版本号",
        `rolename` string COMMENT "发送方角色昵称只保留中文字符、英文和数字。如果昵称中带有特殊字符（比如|或者/t），则记录时过滤，比如 张|三 记为 张.三",
        `roleid` string COMMENT "发送方角色唯一ID",
        `rolelevel` bigint COMMENT "发送方角色等级",
        `rolebattlepoint` bigint COMMENT "发送方角色军衔",
        `userip` string COMMENT "发送信息玩家ip地址",
        `groupid` string COMMENT "发送信息玩家公会ID,没有公会则上报0",
        `picurl` string COMMENT "玩家头像URL，手Q默认上报后缀为/100的URL , 微信默认上报后缀为/96的URL ",
        `usersign` string COMMENT "个人签名内容，目前最多能发送单条512字节的信息内容只保留中文字符、英文和数字。如果内容中带有特殊字符（比如|或者\t），则记录时去掉，比如 张|三 记为 张三",
        `receiverplayerid` string COMMENT "接收方角色playerid号",
        `receiverroleid` string COMMENT "接收方角色唯一ID或游乐场聊天对应的战斗ID",
        `receiverroletype` bigint COMMENT "接收方角色职业编号",
        `receiverrolelevel` bigint COMMENT "接收方角色等级",
        `chattype` bigint COMMENT "信息类型，信息类型，1世界聊天，2点对点聊天，3 房间聊天，4加好友的请求信息 5 聊天室聊天 6 组队 8 联盟 9 师徒 10 巅峰赛 11 游乐场 12 临时会话 13 阵营聊天 100 战斗内聊天",
        `chatroomid` bigint COMMENT "聊天室ID，非聊天室聊天报0",
        `msgtype` bigint COMMENT "聊天信息类型，0 为文字信息，1 为语音信息 2为模板发言",
        `chatcontents` string COMMENT "comment",
        `chatroomname` string COMMENT "聊天室名称或联盟名称，非聊天室聊天报0",
        `chatroomownerplayerid` string COMMENT "聊天室创建者playerid，非聊天室聊天报0, 这里报UID",
        `chatroomsign` string COMMENT "聊天室签名，非聊天室聊天报0",
        `currentscene` bigint COMMENT "(可填)来源场景:1 大厅; 2 战斗; 3 观战; 4 特训岛; 5 营地",
        `battleid` string COMMENT "对局ID，适用于广阔天地/UGC/狼人杀等场景",
        `submode` string COMMENT "子模式",
        `accompanytype` string COMMENT "玩家陪玩标签获取接口",
        `devicetype` bigint COMMENT "设备类型0为手机 1为模拟器 2 键鼠 3 手柄 5 PC"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_jordass_playermatchrecord_stat_df` (
        `dtstatdate` string COMMENT "分区，参与乐园日期，格式YYYYMMDD",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android255:所有平台",
        `vplayerid` string COMMENT "玩家ID",
        `imode` bigint COMMENT "乐园模式",
        `cbitmap` string COMMENT "登录位图",
        `dregdate` string COMMENT "注册日期",
        `ljicnt` bigint COMMENT "累计对局数",
        `icnt` bigint COMMENT "当日对局数",
        `teamnum` bigint COMMENT "组队人数",
        `itemp1` bigint COMMENT "itemp1",
        `itemp2` bigint COMMENT "itemp2",
        `vtemp1` string COMMENT "vtemp1",
        `vtemp2` string COMMENT "vtemp2"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_playerlogin_hi` (
        `tdbank_imp_date` string COMMENT "小时分区字段，格式YYYYMMDDHH",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID",
        `level` bigint COMMENT "等级",
        `playerfriendsnum` bigint COMMENT "玩家好友数量",
        `clientversion` string COMMENT "客户端版本",
        `screenwidth` bigint COMMENT "显示屏宽度",
        `screenhight` bigint COMMENT "显示屏高度",
        `density` string COMMENT "像素密度",
        `loginchannel` bigint COMMENT "登录渠道",
        `vroleid` string COMMENT "玩家角色ID",
        `vrolename` string COMMENT "玩家角色名",
        `deviceid` string COMMENT "设备ID",
        `device_type` bigint COMMENT "设备类型0为手机,1为模拟器, 2键鼠, 3手柄, 5是PC客户端,也是高清模拟器。",
        `gender` bigint COMMENT "平台性别，1是男，2是女",
        `emulatorname` string COMMENT "模拟器名",
        `warzoneid` bigint COMMENT "战区ID",
        `devicename` string COMMENT "客户端devicename",
        `historymaxsegment` bigint COMMENT "历史最高段位",
        `seasonmaxsegment` bigint COMMENT "本赛季最高段位",
        `firstlogincg` bigint COMMENT "第一次登录CG游戏的时间，即CG注册时间，UNIX时间戳",
        `lobbybgid` bigint COMMENT "当前设置的大厅背景resid",
        `signature` string COMMENT "个性签名",
        `devicelevel` bigint COMMENT "机型档位",
        `iswxrealname` bigint COMMENT "非微信平台或还没拉取数据填0，已微信实名填1，未实名填2",
        `iswxlowlv` bigint COMMENT "非微信平台或还没拉取数据填0，是微信小号填1，不是微信小号填2",
        `iszombie` bigint COMMENT "非微信平台或还没拉取数据填0，是微信僵尸号填1，不是微信僵尸号填2",
        `topsegtimes` bigint COMMENT "王牌印记: -2 首次达到星钻 -1 首次达到王冠  0 无数据 >0 历史王牌次数",
        `clanid1` bigint COMMENT "战队ID1",
        `clanid2` bigint COMMENT "战队ID2",
        `clanid3` bigint COMMENT "战队ID3",
        `fpslevel` bigint COMMENT "帧率等级",
        `renderqualityapply` bigint COMMENT "画质等级",
        `devicetcqualitygrade` bigint COMMENT "机型等级",
        `relogin` bigint COMMENT "是否是断线重连登录的,1为断线重连，0为从登录界面登录",
        `gameid` string COMMENT "当前正在游戏的对局id",
        `startime` bigint COMMENT "当前正在游戏的对局id",
        `rolesettingstr` string COMMENT "RoleSetting设置, 当为空字符串时表示该字段获取异常,否则为以+分隔的rolesetting值，具体字段值咨询开发",
        `creditscore` string COMMENT "信誉分",
        `usenewpickup` bigint COMMENT "是否使用新版拾取",
        `isqrlogin` bigint COMMENT "是否为扫码登录的,1是扫码登录，0非扫描登录",
        `is_gamematrix` bigint COMMENT "是否为先锋云游，1是，0不是",
        `clientsceneversion` string COMMENT "客户端场景版本",
        `whitetype` bigint COMMENT "进入服务器的凭证类型",
        `mobiletablettype` bigint COMMENT "平板识别结果：-1结果未出，0是非平板，1已验证是平板，2可能是平板",
        `behaviorlevel` bigint COMMENT "行为分等级",
        `clientostype` string COMMENT "客户端系统类型：and ios win hm",
        `pclogintype` bigint COMMENT "0=默认类型，1=PC新手玩家，2=PC回流玩家",
        `escapecoincount` string COMMENT "隧道收益(该字段原来搞错了, 之前以为是隧道币数量)",
        `vsteamlevel` bigint COMMENT "组竞等级",
        `connectidx` bigint COMMENT "连接序号",
        `isinds` bigint COMMENT "当前登录是否在ds场景中重连"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_pressbutton_hi` (
        `tdbank_imp_date` string COMMENT "小时分区字段，格式YYYYMMDDHH",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "玩家",
        `uid` string COMMENT "角色UID",
        `buttontypes` string COMMENT "按钮代号,找客户端开发问下定义，以;分隔",
        `ireasons` string COMMENT "额外参数,客户端负责传过来，以;分隔",
        `extarg1s` string COMMENT "附加参数1,客户端负责传过来，以;分隔",
        `extarg2s` string COMMENT "附加参数2,客户端负责传过来，以;分隔"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_argothek_playermatchdetail_hi` (
        `tdbank_imp_date` string COMMENT "分区字段",
        `dteventtime` string COMMENT "AP 事件时间: YYYY-MM-DD HH:MM:SS",
        `apeventid` string COMMENT "AP 事件标识符，由 TLIS 生成",
        `apchildid` string COMMENT "AP 子标识符，由 TLIS 生成，并在主条目 apMatchDetails.players 中引用",
        `apchildindex` bigint COMMENT "AP 子索引，由 TLIS 生成",
        `subject` string COMMENT "玩家 ID - 玩家标识符。",
        `name` string COMMENT "Ares 玩家名称 - Ares 玩家的名称（不一定是召唤师名称）",
        `teamid` string COMMENT "Ares 队伍 ID - Ares 队伍 ID",
        `partyid` string COMMENT "组队 ID - 组队标识符。",
        `characterid` string COMMENT "角色 ID - 角色标识符。",
        `competitivetier` bigint COMMENT "竞技等级 - 竞技等级的整数值。从 1 开始，0 表示隐藏",
        `statsscore` double COMMENT "Ares 玩家得分 - 玩家得分的点数数量。",
        `statsroundsplayed` bigint COMMENT "回合编号 - Ares 匹配的回合编号",
        `statskills` double COMMENT "数量 - 一个数值度量",
        `statsdeaths` double COMMENT "数量 - 一个数值度量",
        `statsassists` double COMMENT "数量 - 一个数值度量",
        `statsplaytimemillis` double COMMENT "毫秒 - 千分之一秒的单位",
        `newexpr` string COMMENT "AP 子标识符，指向子结构：apMatchDetails_players_newExpr",
        `matchid` string COMMENT "Ares 匹配 ID - Ares 匹配的 ID 字符串",
        `mapid` string COMMENT "Ares 地图 ID - 服务代码中使用的 Ares 地图 ID",
        `provisioningflowid` string COMMENT "配置流程 ID - 已配置的游戏类型。例如：技能测试、匹配等",
        `gamepodid` string COMMENT "游戏节点 ID - 游戏节点的字符串表示",
        `gamelengthmillis` double COMMENT "毫秒 - 千分之一秒的单位",
        `gamestartmillis` double COMMENT "毫秒 - 千分之一秒的单位",
        `gameversion` string COMMENT "Ares 构建版本 - Ares 二进制文件的完整构建版本",
        `iscompleted` bigint COMMENT "比赛完成标志 - 如果比赛正常结束并有比赛结果，则为 True",
        `customgamename` string COMMENT "Ares 自定义游戏名称 - 自定义游戏的名称",
        `module` string COMMENT "Ares 射击场模块 - 可以在射击场中游玩的模块",
        `forcepostprocessing` bigint COMMENT "强制后处理标志 - 对于需要启用调试的比赛，该值为 True。",
        `queueid` string COMMENT "Ares 队列 ID - Ares 队列的 ID 字符串",
        `seasonid` string COMMENT "赛季 ID - 赛季的 uuid",
        `completionstate` string COMMENT "Ares 完成状态 - 比赛如何完成的字符串值。例如：Completed（完成）, All_Disconnected（全部断开连接）",
        `ismatchsampled` bigint COMMENT "比赛是否被采样标志 - 指示该比赛是否被采样用于遥测",
        `statsabilitycastsgrenadecasts` bigint COMMENT "技能施放次数 - 技能已施放的次数",
        `statsabilitycastsability1casts` bigint COMMENT "技能施放次数 - 技能已施放的次数",
        `statsabilitycastsability2casts` bigint COMMENT "技能施放次数 - 技能已施放的次数",
        `statsabilitycastsultimatecasts` bigint COMMENT "技能施放次数 - 技能已施放的次数",
        `clientplatformdetailsplatformtype` string COMMENT "客户端平台类型 - 此事件来源的客户端平台（例如：Mobile 或 PC）",
        `newexprv2missions` string COMMENT "newExprV2Missions ",
        `newexprv2settingstatusissensitivitydefault` bigint COMMENT "newExprV2SettingStatusIsSensitivityDefault ",
        `newexprv2settingstatusiscrosshairdefault` bigint COMMENT "newExprV2SettingStatusIsCrosshairDefault "
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_activityrecord_hi` (
        `tdbank_imp_date` string COMMENT "",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID",
        `actid` bigint COMMENT "活动id",
        `acttype` bigint COMMENT "活动类型",
        `recodtype` bigint COMMENT "不同活动自定义不同的类型",
        `arg1` bigint COMMENT "参数1",
        `arg2` bigint COMMENT "参数2",
        `arg3` bigint COMMENT "参数3",
        `strarg1` string COMMENT "字符串参数1",
        `strarg2` string COMMENT "字符串参数2",
        `strarg3` string COMMENT "字符串参数3",
        `device_type` bigint COMMENT "device_type "
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_jordass_uid_login_df` (
        `dtstatdate` string COMMENT "日期",
        `vgameappid` string COMMENT "账号体系： 'wx' - 微信 ；'qq' - 手Q	",
        `platid` bigint COMMENT "系统平台",
        `vplayerid` string COMMENT "账号id",
        `uid` bigint COMMENT "角色id",
        `vrolename` string COMMENT "角色名称",
        `dregdate` string COMMENT "注册日期",
        `lastactdate` string COMMENT "最后活跃日期",
        `cbitmap` string COMMENT "活跃位图",
        `ilevel` string COMMENT "账号等级",
        `friendcount` bigint COMMENT "好友数",
        `historymaxsegment` bigint COMMENT "历史最高段位",
        `gender` bigint COMMENT "游戏内性别"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_argothek_oss_useractivity_df` (
        `statis_date` bigint COMMENT "统计日期",
        `iworldid` bigint COMMENT "大区ID",
        `iuserid` string COMMENT "用户ID",
        `ilevel` bigint COMMENT "玩家等级",
        `igroup` bigint COMMENT "是否付费",
        `iactivity` string COMMENT "玩家登陆位图,首位为0,最长100位,1表示当天活跃,0表示当天未活跃",
        `iregdate` bigint COMMENT "注册日期,这里的注册日期是首次活跃日期,如果注册数据有单独日志表,则忽略此字段",
        `iloginway` bigint COMMENT "登录渠道",
        `iregway` bigint COMMENT "注册渠道",
        `vlastlogindate` string COMMENT "最后登录日期"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`statis_date`)
    DISTRIBUTED BY HASH (`statis_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_jordass_submodeonlinedate_conf` (
        `matchsubmodegroup` bigint COMMENT "子玩法",
        `matchsubmodegroupname` string COMMENT "子玩法名",
        `onlinedate` string COMMENT "上线日期",
        `itemp1` bigint COMMENT "预留数字1",
        `itemp2` bigint COMMENT "预留数字2",
        `vtemp1` string COMMENT "预留字符1",
        `vtemp2` string COMMENT "预留字符2"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`matchsubmodegroup`)
    DISTRIBUTED BY HASH (`matchsubmodegroup`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_argothek_playerlogin_hi` (
        `tdbank_imp_date` string COMMENT "partition fields",
        `dteventtime` string COMMENT "事件时间 - YYYY-MM-DD HH:MM:SS",
        `ieventid` string COMMENT "事件 ID",
        `vgamesvrid` string COMMENT "服务器 ID - fill 1 if only one server",
        `vgameappid` string COMMENT "appid - 无则填0",
        `iareaid` string COMMENT "大区 ID - if no fill 0",
        `iuserid` string COMMENT "Open ID",
        `vroleid` string COMMENT "角色ID",
        `ilevel` bigint COMMENT "账户等级",
        `iloginway` bigint COMMENT "玩家登录渠道",
        `iversion` string COMMENT "客户端版本",
        `vrolename` string COMMENT "玩家名字",
        `inetbarlevel` string COMMENT "网吧等级 - 0: No netbar information. 1: Gold netbar. 2: Silver netbar. 3: Bronze netbar.",
        `iseasonid` string COMMENT "赛季ID",
        `iaccountexp` bigint COMMENT "账户经验",
        `ibpid` string COMMENT "battlepass ID",
        `ibplevel` bigint COMMENT "battlepass等级",
        `ibpexp` bigint COMMENT "battlepass总经验",
        `iacid` string COMMENT "角色契约 ID",
        `iaclevel` bigint COMMENT "角色契约等级",
        `iacexp` bigint COMMENT "角色契约总经验",
        `ivpoint` bigint COMMENT "玩家拥有VP",
        `irpoint` bigint COMMENT "玩家拥有RP",
        `icampuslevel` string COMMENT "校园特权等级"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_argothek_gearrecord_df` (
        `dtstatdate` string COMMENT "统计日期",
        `vgameappid` string COMMENT "appid",
        `iareaid` string COMMENT "大区ID",
        `iuserid` string COMMENT "iuserid",
        `vroleid` string COMMENT "vRoleID",
        `igoodstype` string COMMENT "道具类型",
        `igoodsid` string COMMENT "道具ID",
        `icount` bigint COMMENT "道具数量",
        `icount1` bigint COMMENT "道具数量且订单id不为空",
        `vtemp1` string COMMENT "预留",
        `vtemp2` string COMMENT "预留",
        `vtemp3` string COMMENT "预留",
        `itemp1` bigint COMMENT "预留",
        `itemp2` bigint COMMENT "预留",
        `itemp3` bigint COMMENT "预留"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_player_matchrecord_hi` (
        `tdbank_imp_date` string COMMENT "分区字段，小时分区，格式YYYYMMDDHH",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID",
        `matchtime` bigint COMMENT "匹配时长（秒）",
        `matchresult` string COMMENT "匹配结果",
        `matchmode` bigint COMMENT "匹配模式",
        `isaotufill` bigint COMMENT "是否自动填充",
        `gameid` string COMMENT "匹配成功为当前的battleid失败为0",
        `submodes` string COMMENT "选择的子模式列表，只有队长才有",
        `isleader` bigint COMMENT "1表示队长0非队长",
        `teamnum` string COMMENT "组队人数",
        `teammembers` string COMMENT "组队队伍",
        `matchteammembers` string COMMENT "最终匹配的队伍",
        `matchlabel` bigint COMMENT "匹配标签",
        `corpsid` bigint COMMENT "联盟id",
        `teamid` string COMMENT "队伍ID",
        `teamwaittime` bigint COMMENT "队伍首次组队到匹配等待时间",
        `finalbucketidx` bigint COMMENT "匹配成功首队伍所在匹配区间idx",
        `playermoderating` bigint COMMENT "玩家该模式下rating分(段位分)",
        `playerlevel` bigint COMMENT "玩家等级",
        `regresss` bigint COMMENT "是否回流玩家",
        `matchsubmodegroup` bigint COMMENT "最终随机到的submodegroup",
        `matchrating` bigint COMMENT "当前玩家所在队伍匹配积分",
        `bucketidx` bigint COMMENT "当前玩家所在队伍匹配积分所在区间idx",
        `device_type` bigint COMMENT "设备类型0为手机 1为模拟器 2 键鼠 3 手柄 5 PC高清模拟器",
        `strategys` string COMMENT "分队策略",
        `match_client_type` bigint COMMENT "匹配池渠道0为手机 1为模拟器 2外部模拟器 8为小黑屋 9为新手局",
        `pandoralost` bigint COMMENT "潘多拉预流失标记 1预流失 0非预流失",
        `teamjoinsource` bigint COMMENT "组队加入来源",
        `regressvalue` bigint COMMENT "玩家当前的回流值",
        `strategy_type` bigint COMMENT "策略类型，-1表示服务器保底二次分队, 0表示004的潘多拉策略, 1表示005的潘多拉单局最优策略, 2表示015的技术中心优化分队策略, 3表示技术中心向量化二次分队方案, 4表示内部推荐二次分队方案",
        `playersign` bigint COMMENT "玩家分级标签，1为白，2为红，3为灰, 4为深灰",
        `livetype` bigint COMMENT "直播类型: 2 围观 4 视频号",
        `liveid` string COMMENT "直播ID",
        `matchscene` bigint COMMENT "匹配成功时玩家所在场景，0为大厅，1为聚乐园",
        `issilentmode` bigint COMMENT "是否是免耳麦模式，0为非免耳麦，1为免耳麦",
        `ismatchlbs` bigint COMMENT "是否是lbs匹配，0为非lbs匹配，1为lbs匹配",
        `strategy_index` bigint COMMENT "二次分队策略采用的weight数组的下标",
        `xid` string COMMENT "Xid",
        `isanchor` bigint COMMENT "是否是主播，0为非主播，1为主播",
        `isanchorgame` bigint COMMENT "是否匹配到主播局，0为非主播局，1为主播局",
        `tournamentid` bigint COMMENT "微赛事ID",
        `expandupsection` bigint COMMENT "最大向上扩段数",
        `expanddownsection` bigint COMMENT "最大向下扩段数",
        `expandupclass` bigint COMMENT "最大向上扩载数",
        `expanddownclass` bigint COMMENT "最大向下扩载数",
        `isfullbucket` bigint COMMENT "是否优先遍历满载队",
        `timingmatchtime` bigint COMMENT "定时匹配真实匹配时长（秒）",
        `tournamentstage` bigint COMMENT "微赛事阶段ID",
        `tournamentclubid` string COMMENT "微赛事战队ID",
        `promotionmatchstatus` bigint COMMENT "参与晋级赛的状态, -1没勾选，0成功参与，1模式不对，2时间不对，3配置不对，4自身段位不对，5队友段位不对",
        `ugcisgray` bigint COMMENT "是否为ugc灰度玩法。默认为0：非灰度；1：灰度",
        `promotiontaskid` bigint COMMENT "晋级赛任务ID",
        `strategyabtest` string COMMENT "未命中模式为空，对照组记 0:ID，实验组记 1:ID",
        `accompanytype` bigint COMMENT "陪玩标签值 0 ：没有打标签，1：陪玩，2：老板",
        `minusteamnum` bigint COMMENT "匹配成功后踢回匹配池的队伍数",
        `mobiletabletmatchlabel` bigint COMMENT "匹配队伍平板比例标签(非手机=0，纯手机=1，25%平板=2，50%平板=3，75%平板=4，100%平板=5)",
        `ratingtype` bigint COMMENT "积分类型",
        `idcname` string COMMENT "IDC集群名字",
        `strategyextendinfo` string COMMENT "推荐侧二次分队返回的信息",
        `playerabtest` string COMMENT "个人匹配abtest",
        `gameabtest` string COMMENT "匹配对局的abtest,没有则为空字符串",
        `matchtype` bigint COMMENT "1表示匹配成局，2表示补人",
        `matchisolatetype` bigint COMMENT "玩家匹配隔离标记, 0不隔离，2所有模式隔离，3积分模式隔离，4E玩法模式隔离",
        `predictmatchtime` bigint COMMENT "预估匹配时长",
        `expandspeed` bigint COMMENT "匹配单阶段扩段时长",
        `escapehardid` bigint COMMENT "E玩法难度ID",
        `gameplayernum` bigint COMMENT "开局人数",
        `gameaistrategy` bigint COMMENT "AI投放策略类型",
        `isfixmatchlabel` bigint COMMENT "是否触发了标签修正",
        `realmatchsubmodes` string COMMENT "实际匹配的模式组列表",
        `aitype` bigint COMMENT "投放的AI類型",
        `decratingtype` bigint COMMENT "降段类型，0=未触发降段，1=pc新手标签降段，2=未成年标签降段，3=回流标签降段，4=情绪值降段",
        `forcematchtype` bigint COMMENT "记录本次匹配是否触发了强制开局，0=未触发，1=通用强制开局，2=PC新手强制开局",
        `ispcaigame` bigint COMMENT "是否触发了PC首局AI局",
        `matchsubclienttype` bigint COMMENT "匹配子池：0非子池, 2外设键鼠,3外设手柄,4主播,5PC新手,6PC-AI局 7BR温暖局，8隧道AI局",
        `heroexcludetype` bigint COMMENT "是否触发了英雄互斥匹配，1采用了互斥匹配, 2没命中灰度 3超时，0其他情况",
        `natalhero` bigint COMMENT "本命英雄ID",
        `iswarmescapegame` bigint COMMENT "是否是E玩法温暖局",
        `cancrossdevicematch` bigint COMMENT "是否可已手机非手机混匹, 1可以，0不可以",
        `aiteamatetype` bigint COMMENT "AI队友类型",
        `isfirstteam` bigint COMMENT "是否是首队",
        `firstteamwaittime` bigint COMMENT "首队的匹配等待时间",
        `firstteamrankbucket` bigint COMMENT "首队段位分段",
        `matchprocessinfo` string COMMENT "匹配扩展信息 辅助查询匹配问题",
        `isabtwarmgame` bigint COMMENT "是否触发了温暖局",
        `warmplayertype` bigint COMMENT "温暖局玩家身份, 3=挫败（未来），2=回流，1=低活，0=未触发或无标签",
        `escapeplayertype` string COMMENT "隧道玩家身份类型, 空字符串表示默认类型，1回流标签有限期内,2积分移动新手(隐藏分专用),3积分非移动新手(隐藏分专用),4积分回流(隐藏分专用),5全局新手(AI局专用),6PC新手(AI局专用),7非PC温暖(AI局专用),8PC温暖(AI局专用),9回流(AI局专用), 以+分割",
        `secondarydecratingtype` bigint COMMENT "二维匹配分降段类型，0=未触发降段，1=隧道回流降分匹配",
        `finalsecondarybucketidx` bigint COMMENT "匹配成功首队所在二维匹配积分区间",
        `playersecondarymoderating` bigint COMMENT "玩家该模式下二维匹配积分",
        `secondarymatchrating` bigint COMMENT "当前玩家所在队伍二维匹配积分",
        `secondarybucketidx` bigint COMMENT "当前玩家所在队伍二维匹配积分所在区间",
        `escapeasset` string COMMENT "隧道玩法资产",
        `escapewarmscore` string COMMENT "隧道温暖值",
        `pvethemeid` bigint COMMENT "PVE挑战事件ID",
        `escapelesspeoplegamenum` bigint COMMENT "隧道每周已触发低真人局次数",
        `garybucketgroup` bigint COMMENT "灰度分桶",
        `matchsubclienttypebefore` bigint COMMENT "发起匹配时的匹配子池：0非子池, 2外设键鼠,3外设手柄,4主播,5PC新手,6PC-AI局, 7BR温暖局，8隧道AI局",
        `frustratiggerlevel` bigint COMMENT "FrustraTiggerLevel ",
        `frustramanualscore` string COMMENT "FrustraManualScore ",
        `frustramodelscore` string COMMENT "FrustraModelScore ",
        `frustragroup` string COMMENT "FrustraGroup ",
        `frustrathreshold` string COMMENT "FrustraThreshold ",
        `recomtraceid` string COMMENT "RecomTraceID "
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_roundlog_funnymode_hi` (
        `tdbank_imp_date` string COMMENT "",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "玩家",
        `uid` string COMMENT "玩家UID",
        `battleid` string COMMENT "对局ID",
        `mode` bigint COMMENT "模式",
        `submode` bigint COMMENT "子模式",
        `startime` bigint COMMENT "开局时刻",
        `escapecheckup` bigint COMMENT "是否逃跑",
        `currentroundrank` bigint COMMENT "当局名次,广域战场模式是本阵营中的排名",
        `sumscore` bigint COMMENT "流水总评分",
        `titleidlist` string COMMENT "当局获得的称号Id",
        `teamrank` bigint COMMENT "队伍名次",
        `teamid` bigint COMMENT "小队ID",
        `flowratinglevel` string COMMENT "当局游戏的评价等级，前面有个Int类型的，但是非要求加一个字符串类型的",
        `roundtime` bigint COMMENT "对局时长(秒)",
        `gold` bigint COMMENT "金钱变化值",
        `level` bigint COMMENT "等级变化值",
        `map` bigint COMMENT "地图",
        `playernumber` bigint COMMENT "玩家数",
        `realplayernumber` bigint COMMENT "真人玩家数",
        `teamnumber` bigint COMMENT "小队数",
        `teammemberlist` string COMMENT "队友List",
        `killingcount` bigint COMMENT "击杀",
        `assistcount` bigint COMMENT "助攻次数",
        `survivaltime` bigint COMMENT "存活总时间",
        `damageamount` bigint COMMENT "总伤害量,浮点数，乘以100存入",
        `healtimes` bigint COMMENT "救人次数",
        `healamount` bigint COMMENT "治疗量，浮点数，乘以100存入",
        `movingdistance` bigint COMMENT "前进距离",
        `deadflow` string COMMENT "死亡流水 死亡坐标/死亡类型/死亡时间",
        `headshotcounts` bigint COMMENT "爆头数",
        `vehicledestoryedtimes` bigint COMMENT "摧毁载具次数",
        `killingflow` string COMMENT "击杀流水 :击杀目标ID\t击杀类型\t是否爆头\t击杀距离\t使用的武器ID\t击杀者（角色自己）位置  新增：\t被击杀者位置\t击杀时间（从进入小岛开始到击杀时的毫秒数）\t造成伤害量\t是否移动\t击杀区域ID(-1表示区域表中不记录)\t状态(1:卧倒)\t被击倒的武器id\t击杀圈数\t被击杀者名字\t是否灭队\t是否为ai\tAI的类型\t击倒者uid\t击杀者uid",
        `walkingdistance` bigint COMMENT "步行距离",
        `collectindex` bigint COMMENT "物资指数，浮点数，乘以100存入",
        `survivalindex` bigint COMMENT "生存指数，浮点数，乘以100存入",
        `damageindex` bigint COMMENT "伤害指数，浮点数，乘以100存入",
        `healindex` bigint COMMENT "支援指数，浮点数，乘以100存入",
        `assaultindex` bigint COMMENT "战斗指数，浮点数，乘以100存入",
        `gunhittimes` bigint COMMENT "枪械命中次数",
        `gunshottimes` bigint COMMENT "枪械射击次数",
        `curecount` bigint COMMENT "治疗次数",
        `landlocation` string COMMENT "落地点坐标,有效字段",
        `oweruid` string COMMENT "房主uid",
        `ismvp` bigint COMMENT "不是mvp 0/是mvp 1",
        `pronetime` bigint COMMENT "趴地时间",
        `drivingdistance` bigint COMMENT "行驶距离",
        `obtianedairdroptimes` bigint COMMENT "获得空投次数",
        `killeruid` string COMMENT "击杀者UID",
        `giveboxnum` bigint COMMENT "年兽模式给宝箱个数,ug字段，兼容保留",
        `deadnum` bigint COMMENT "年兽模式死亡次数,ug字段，兼容保留",
        `result` string COMMENT "Reason字段，广域战场模式：胜利Win，失败Fail。年兽模式：击败年兽win 全部人员死亡dead 打年兽超时timeout,ug字段，兼容保留",
        `lobbyteamid` string COMMENT "大厅队伍id",
        `topxtipsresponse` bigint COMMENT "未进入前5:-1;不点击:0;继续战斗:1;退出竞赛:2",
        `signalhealamount` bigint COMMENT "信号治疗量",
        `monsterkilltotalnum` bigint COMMENT "总击杀僵尸数量",
        `zombiekillingflow` string COMMENT "僵尸击杀流水 僵尸id\t击杀数量\t是否爆头击杀\t击杀类型\t击杀武器id",
        `monsterdamageamount` bigint COMMENT "总对僵尸伤害",
        `drivinghelicoptertime` bigint COMMENT "驾驶直升飞机时间",
        `inhelicoptertime` bigint COMMENT "乘坐直升飞机时间",
        `makefiresnum` bigint COMMENT "生火成功次数,极寒模式",
        `friendcount` bigint COMMENT "队友中的好友数量",
        `teammemberrelalist` string COMMENT "与TeamMemberList相对应，与其他队员之间的好友关系（0非好友，1平台好友，2为游戏好友）拼接，多个好友之间用+拼接。例如1+2+2",
        `teammembersexlist` string COMMENT "与TeamMemberList相对应，其他队员的性别拼接（1表示男，2表示女），多个好友之间用+拼接。例如1+2+2",
        `maxhurtweaponid` bigint COMMENT "最大伤害的武器ID",
        `maxdamage` bigint COMMENT "武器的最大伤害",
        `pointsurvivalseconds` bigint COMMENT "据点内存活时间",
        `useweaponlist` string COMMENT "击杀所用武器的列表, 用,拼接。例如1,2,2",
        `teammembertmrelalist` string COMMENT "与TeamMemberList相对应，与其他队员之间的默契好友关系（1是0非）拼接，多个好友之间用+拼接。例如1+0+1",
        `playid` bigint COMMENT "限时模式的玩法id,非限时模式则为0",
        `campid` bigint COMMENT "广域战场阵营id，进攻方1，防守方2",
        `score` bigint COMMENT "广域战场获得积分",
        `professioncareerinfo` string COMMENT "广域战场每个职业的总积分/总时间及经验获取list 职业id:获得积分,使用时间,获得经验 + 职业id:获得积分,使用时间,获得经验",
        `device_type` bigint COMMENT "设备类型0为手机 1为模拟器 2 键鼠 3 手柄",
        `deploymaxkills` bigint COMMENT "广域战场单局单次部署最大击杀",
        `gamenum` bigint COMMENT "广域战场模式对局数",
        `bigwarrating` bigint COMMENT "广域战场模式积分,这局前",
        `bigwarchangerating` bigint COMMENT "广域战场模式积分这局的变化值",
        `destroyvehicleweaponlist` string COMMENT "摧毁载具武器列表，载具ID:武器ID+载具ID:武器ID"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_argothek_cbt2kaibai_hi` (
        `tdbank_imp_date` string COMMENT "partition fields",
        `dteventtime` string COMMENT "dtEventTime",
        `gplayerid` string COMMENT "gplayerid",
        `playerid` string COMMENT "playerid",
        `source` string COMMENT "source",
        `sourcename` string COMMENT "sourceName",
        `acctype` string COMMENT "acctype",
        `platid` string COMMENT "platid",
        `ext1` string COMMENT "ext1",
        `ext2` string COMMENT "ext2",
        `ext3` string COMMENT "ext3",
        `ext4` string COMMENT "ext4",
        `ext5` string COMMENT "ext5"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_jordass_player_allstate_df` (
        `dtstatdate` string COMMENT "分区，登录日期，格式YYYYMMDD",
        `platid` bigint COMMENT "操作系统",
        `vgameappid` string COMMENT "账号体系",
        `vplayerid` string COMMENT "账号id",
        `is_reg` bigint COMMENT "是否当日注册",
        `reg_channel` string COMMENT "注册渠道",
        `reg_date` string COMMENT "注册日期",
        `reg_days` bigint COMMENT "注册天数",
        `login_bitmap` string COMMENT "登录位图",
        `is_actv` bigint COMMENT "是否当日活跃",
        `login_cnt` bigint COMMENT "登录次数",
        `onln_time` bigint COMMENT "在线时长",
        `login_channel` string COMMENT "登录渠道",
        `login_days_7d` bigint COMMENT "近7天登录天数",
        `login_days_30d` bigint COMMENT "近30天登录天数",
        `last_login_date` string COMMENT "最后登陆日期",
        `day_actv_flag` string COMMENT "日活跃标签",
        `week_actv_flag` string COMMENT "周活跃标签",
        `month_actv_flag` string COMMENT "月活跃标签（月末为自然月，非月末为30日）",
        `pay_bitmap` string COMMENT "付费位图",
        `is_pay` bigint COMMENT "是否当日付费",
        `pay_amt` bigint COMMENT "付费金额",
        `deposit_amt` bigint COMMENT "充值金额",
        `pay_cnt` bigint COMMENT "付费次数",
        `first_pay_date` string COMMENT "首次付费日期",
        `is_first_pay` bigint COMMENT "付费破冰用户",
        `pay_amt_td` bigint COMMENT "累计付费金额",
        `deposit_amt_td` bigint COMMENT "累计充值金额",
        `max_vip_level` bigint COMMENT "最高VIP等级",
        `max_level` bigint COMMENT "最高等级",
        `friend_cnt` bigint COMMENT "好友数",
        `max_power` bigint COMMENT "最高战力",
        `is_studio` bigint COMMENT "是否工作室",
        `gender` bigint COMMENT "性别",
        `province` string COMMENT "省份",
        `city` string COMMENT "城市",
        `city_level` string COMMENT "城市等级",
        `is_weekend` bigint COMMENT "是否自然周末",
        `is_month_end` bigint COMMENT "是否自然月末",
        `reg_year` string COMMENT "注册年份",
        `month_actv_change` bigint COMMENT "活跃度变化-月"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_argothek_matchdetails_hi` (
        `tdbank_imp_date` string COMMENT "分区字段",
        `dteventtime` string COMMENT "AP 事件时间: YYYY-MM-DD HH:MM:SS",
        `apeventid` string COMMENT "AP 事件标识符",
        `matchid` string COMMENT "Ares 匹配 ID - Ares 匹配的 ID 字符串",
        `mapid` string COMMENT "Ares 地图 ID - 服务代码中使用的 Ares 地图 ID",
        `provisioningflowid` string COMMENT "配置流程 ID - 已配置的游戏类型。例如：技能测试、匹配等",
        `gamepodid` string COMMENT "游戏节点 ID - 游戏节点的字符串表示",
        `gamelengthmillis` double COMMENT "毫秒 - 千分之一秒的单位",
        `gamestartmillis` double COMMENT "毫秒 - 千分之一秒的单位",
        `gameversion` string COMMENT "Ares 构建版本 - Ares 二进制文件的完整构建版本",
        `iscompleted` bigint COMMENT "比赛完成标志 - 如果比赛正常结束并有比赛结果，则为 True",
        `customgamename` string COMMENT "Ares 自定义游戏名称 - 自定义游戏的名称",
        `module` string COMMENT "Ares 射击场模块 - 可以在射击场中游玩的模块",
        `forcepostprocessing` bigint COMMENT "强制后处理标志 - 对于需要启用调试的比赛，该值为 True。",
        `queueid` string COMMENT "Ares 队列 ID - Ares 队列的 ID 字符串",
        `seasonid` string COMMENT "赛季 ID - 赛季的 uuid",
        `completionstate` string COMMENT "Ares 完成状态 - 比赛如何完成的字符串值。例如：Completed（完成）, All_Disconnected（全部断开连接）",
        `ismatchsampled` bigint COMMENT "比赛是否被采样标志 - 指示该比赛是否被采样用于遥测",
        `players` string COMMENT "AP 子标识符，指向子结构：apMatchDetails_players",
        `teams` string COMMENT "AP 子标识符，指向子结构：apMatchDetails_teams",
        `roundresults` string COMMENT "AP 子标识符，指向子结构：apMatchDetails_roundResults",
        `platforminfoplatformtype` string COMMENT "客户端平台类型 - 此事件来源的客户端平台（例如：Mobile 或 PC）",
        `platforminfoplatformos` string COMMENT "客户端平台操作系统 - 此事件来源的客户端操作系统",
        `aplogtotal` bigint COMMENT "由此 AP 事件生成的日志总数",
        `platformtype` string COMMENT "客户端平台类型 - 此事件来源的客户端平台（例如：Mobile 或 PC）",
        `apschemaversion` string COMMENT "apSchemaVersion"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_player_allianceactive_hi` (
        `tdbank_imp_date` string COMMENT "",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `uid` string COMMENT "角色UID",
        `corpsid` string COMMENT "联盟id",
        `active` bigint COMMENT "新增的活跃点",
        `allianceforceteractive` bigint COMMENT "变化后的日活跃点",
        `reason` bigint COMMENT "原因",
        `vgameappid` string COMMENT "游戏APPID"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_lotterylog_twostage_hi` (
        `tdbank_imp_date` string COMMENT "",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "玩家",
        `uid` string COMMENT "角色UID",
        `awardidx` bigint COMMENT "获得奖励编号值,只对单抽有效",
        `advancedawardidx` bigint COMMENT "进阶奖励编号值",
        `costnum` bigint COMMENT "消耗活动币数量",
        `round` bigint COMMENT "总轮次",
        `moneyleft` bigint COMMENT "剩余活动币",
        `level` bigint COMMENT "当前层",
        `levelround` bigint COMMENT "当前层的轮次",
        `superflag` bigint COMMENT "特殊格子奖励，0没中,1中",
        `activityid` bigint COMMENT "活动ID",
        `activitytype` bigint COMMENT "活动类型",
        `lotterytype` bigint COMMENT "抽奖类型，0单抽，1抽完本轮, 2盲盒随机大奖励",
        `realcount` bigint COMMENT "抽完本轮实际消耗的次数，只对抽完本轮有效",
        `savedticket` bigint COMMENT "节省的点券数量",
        `exemptticket` bigint COMMENT "返还点券数量",
        `luckyvalue` bigint COMMENT "累计幸运值",
        `totalsavedmoney` bigint COMMENT "累计节省活动币",
        `luckysavedmoney` bigint COMMENT "本次抽奖幸运值节省活动币",
        `device_type` bigint COMMENT "设备类型0为手机 1为模拟器 2 键鼠 3 手柄",
        `moneytype` bigint COMMENT "消耗代币类型, 0为活动币, 1为通用货币",
        `freecouponid` bigint COMMENT "抵扣券res_id, 0表示没有使用抵扣券",
        `exempttype` bigint COMMENT "返还类型，0表示点券，1表示通用货币",
        `exemptcommmoney` bigint COMMENT "返还通用货币数量",
        `awardsitems` string COMMENT "获得道具列表",
        `usedcoupons` string COMMENT "UsedCoupons ",
        `iswish` bigint COMMENT "IsWish ",
        `isanchor` bigint COMMENT "IsAnchor ",
        `ticketcost` bigint COMMENT "TicketCost ",
        `uscorecost` bigint COMMENT "UscoreCost "
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_activitypress_hi` (
        `tdbank_imp_date` string COMMENT "小时分区字段，格式YYYYMMDDHH",
        `dteventtime` string COMMENT "游戏事件的时间,格式YYYY-MM-DDHH:MM:SS",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "玩家",
        `uid` string COMMENT "角色UID",
        `buttontype` bigint COMMENT "按钮代号,找客户端开发问下定义",
        `ireason` bigint COMMENT "活动id",
        `extarg1` bigint COMMENT "附加参数1,客户端负责传过来",
        `extarg2` string COMMENT "附加参数2,客户端负责传过来",
        `extarg3` bigint COMMENT "附加参数3,客户端负责传过来",
        `devicetype` bigint COMMENT "DeviceType "
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_argothek_gplayerid_vroleid_df` (
        `dtstatdate` string COMMENT "日期",
        `vgamesvrid` string COMMENT "服务器",
        `vgameappid` string COMMENT "appid",
        `iareaid` string COMMENT "大区",
        `iuserid` string COMMENT "playerid",
        `vroleid` string COMMENT "角色id",
        `iversion` string COMMENT "版本",
        `cbitmap` string COMMENT "位图",
        `itemp1` bigint COMMENT "预留字段1",
        `itemp2` bigint COMMENT "预留字段2",
        `vtemp1` string COMMENT "预留字段3",
        `vtemp2` string COMMENT "预留字段4"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_argothek_playerlogout_hi` (
        `tdbank_imp_date` string COMMENT "partition fields",
        `dteventtime` string COMMENT "事件时间 - YYYY-MM-DD HH:MM:SS",
        `ieventid` string COMMENT "事件 ID",
        `vgamesvrid` string COMMENT "服务器 ID - fill 1 if only one server",
        `vgameappid` string COMMENT "appid - 无则填0",
        `iareaid` string COMMENT "大区 ID - if no fill 0",
        `iuserid` string COMMENT "Open ID",
        `vroleid` string COMMENT "角色ID",
        `ilevel` bigint COMMENT "账户等级",
        `ionlinetime` bigint COMMENT "本次在线时长",
        `iplaytime` bigint COMMENT "总战斗时长",
        `iloginway` bigint COMMENT "玩家登录渠道",
        `iversion` string COMMENT "客户端版本",
        `vrolename` string COMMENT "玩家名字",
        `iaccountexp` bigint COMMENT "账户经验",
        `inetbarlevel` string COMMENT "网吧等级 - 0: No netbar information. 1: Gold netbar. 2: Silver netbar. 3: Bronze netbar.",
        `iseasonid` string COMMENT "赛季ID",
        `ilogoutreason` bigint COMMENT "登出=1，掉线=2，crash=3，封禁=4，其他=5 - 研发可自定义规则同步TC",
        `ibanned` bigint COMMENT "是否封号，no=0,yes=1",
        `ibannedtime` bigint COMMENT "封禁时长（hour），未封禁=null",
        `ibpid` string COMMENT "battlepass ID",
        `ibplevel` bigint COMMENT "battlepass等级",
        `ibpexp` bigint COMMENT "battlepass总经验",
        `iacid` string COMMENT "角色契约 ID",
        `iaclevel` bigint COMMENT "角色契约等级",
        `iacexp` bigint COMMENT "角色契约总经验",
        `ivpoint` bigint COMMENT "玩家拥有VP",
        `irpoint` bigint COMMENT "玩家拥有RP",
        `itotalonlinetime` bigint COMMENT "历史总在线时长",
        `vlogoutreason` string COMMENT "登出原因，用以代替iLogoutReason字段",
        `icampuslevel` string COMMENT "校园特权等级"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_jordass_water_di` (
        `dtstatdate` string COMMENT "分区，付费日期，格式YYYYMMDD",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android,255:所有平台",
        `vplayerid` string COMMENT "玩家ID",
        `iamount` bigint COMMENT "代币金额(Q分)",
        `itimes` bigint COMMENT "流水次数",
        `imoney` double COMMENT "除100为实际支付人民币金额"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_jordass_mode_roundrecord_di` (
        `dtstatdate` string COMMENT "统计日期格式YYYYMMDD",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android",
        `vplayerid` string COMMENT "玩家ID",
        `mode` bigint COMMENT "模式ID",
        `modename` string COMMENT "模式名称",
        `submode` bigint COMMENT "子模式ID",
        `submodename` string COMMENT "子模式名称",
        `map` bigint COMMENT "地图ID",
        `mapname` string COMMENT "地图名称",
        `seasonid` bigint COMMENT "赛季ID",
        `seasonname` string COMMENT "赛季名称",
        `roundcnt` bigint COMMENT "当日对局数",
        `roundtime` bigint COMMENT "当日对局时长(秒)",
        `survivaltime` bigint COMMENT "当日存活时长(秒)",
        `firstroundtime` string COMMENT "当日首次对局时间",
        `device_type` bigint COMMENT "设备类型"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_argothek_gameclientrecord_hi` (
        `tdbank_imp_date` string COMMENT "分区字段",
        `dteventtime` string COMMENT "AP 事件时间: YYYY-MM-DD HH:MM:SS",
        `apeventid` string COMMENT "AP 事件标识符",
        `playername` string COMMENT "Ares 玩家名称 - Ares 玩家的名称（不一定是召唤师名称）",
        `rsosubject` string COMMENT "RSO PUUID - RFC 0214g - RSO 玩家 ID: Riot 玩家的全局唯一 ID",
        `buildversion` string COMMENT "Ares 构建版本 - Ares 二进制文件的完整构建版本",
        `oshostname` string COMMENT "Ares 操作系统主机名 - 计算机的主机名（例如：BRAND1WD1）",
        `platform` string COMMENT "客户端平台操作系统 - 此事件来源的客户端操作系统（例如：iOS, Android, PC）",
        `aplogtotal` bigint COMMENT "由此 AP 事件生成的日志总数",
        `instanceid` string COMMENT "Ares 实例 ID - Ares 客户端/服务器的每个进程的全局唯一标识符",
        `buildconfiguration` string COMMENT "Ares 构建配置 - 编译时构建配置（例如：Development, Shipping, Development-Editor）",
        `changelist` bigint COMMENT "Perforce 变更列表 - Perforce 变更列表编号",
        `isrunningonssd` bigint COMMENT "布尔值 - 一个布尔值",
        `clientplatformdetailsplatformtype` string COMMENT "clientPlatformDetailsPlatformType",
        `simdsupport` bigint COMMENT "SIMDSupport",
        `isrunningonunknowndrivetype` bigint COMMENT "IsRunningOnUnknownDriveType",
        `apschemaversion` string COMMENT "apSchemaVersion"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_argothek_apinventorymovementlog_hi` (
        `tdbank_imp_date` string COMMENT "分区字段",
        `dteventtime` string COMMENT "AP 事件时间: YYYY-MM-DD HH:MM:SS",
        `apeventid` string COMMENT "AP 事件标识符",
        `matchinfobranch` string COMMENT "Ares Perforce 分支 - 此构建版本的来源分支",
        `matchinfochangelist` string COMMENT "Perforce 变更列表 - Perforce 变更列表编号",
        `matchinfogameid` bigint COMMENT "Ares 游戏 ID - Ares 匹配的 ID 号（基于平台时间戳之前）",
        `matchinfogamemode` string COMMENT "Ares 游戏模式 - 正在进行的比赛类型",
        `matchinfomap` string COMMENT "Ares 地图 - Ares 地图的名称",
        `matchinfomatchid` string COMMENT "Ares 匹配 ID - Ares 匹配的 ID 字符串",
        `matchinfoversion` string COMMENT "Ares 构建版本 - Ares 二进制文件的完整构建版本",
        `roundinfoattackerscore` bigint COMMENT "回合得分 - Ares 匹配的回合得分",
        `roundinfodefenderscore` bigint COMMENT "回合得分 - Ares 匹配的回合得分",
        `roundinfomatchtime` bigint COMMENT "比赛时间 - 当前比赛已进行的时间，单位为毫秒",
        `roundinforoundnumber` bigint COMMENT "回合编号 - Ares 匹配的回合编号",
        `roundinforoundphase` string COMMENT "Ares 回合阶段 - Ares 游戏回合的游戏阶段 - 值：BetweenRounds（回合之间）, GameEnded（游戏结束）, GameStarted（游戏开始）, InRound（回合中）, NotStarted（未开始）, RoundEnding（回合结束中）, RoundStarting（回合开始中）, SwitchingTeams（交换队伍）, Invalid（无效）",
        `roundinforoundtime` double COMMENT "回合时间 - 当前回合已进行的时间，单位为秒",
        `playerinfocharacter` string COMMENT "Ares 角色 - Ares 角色的名称",
        `playerinfoname` string COMMENT "Ares 玩家名称 - Ares 玩家的名称（不一定是召唤师名称）",
        `playerinfosubject` string COMMENT "RSO PUUID - RFC 0214g - RSO 玩家 ID: Riot 玩家的全局唯一 ID",
        `playerinfoteamid` string COMMENT "Ares 队伍 ID - Ares 队伍 ID",
        `playerinfoside` string COMMENT "Ares 游戏模式的阵营 - 当前炸弹游戏模式中的 Ares 阵营。这曾是 Ares 队伍，但我们希望转移到能够跨服务引用队伍为红/蓝。注意：此类型也被用于表示队伍角色的属性。因此有额外的支持其他角色的值（即 None/Any/FreeForAll） - 值：Attacker（进攻方）, Defender（防守方）, Neutral（中立）, Unknown（未知）, None（无）, Any（任意）, FreeForAll（混战）",
        `playerinfoteamrole` string COMMENT "Ares 游戏模式的队伍角色 - 当前炸弹游戏模式中的 Ares 阵营。这曾是 Ares 队伍，但我们希望转移到能够跨服务引用队伍为红/蓝。注意：此类型也被用于表示队伍角色的属性。因此有额外的支持其他角色的值（即 None/Any/FreeForAll） - 值：Attacker（进攻方）, Defender（防守方）, Neutral（中立）, Unknown（未知）, None（无）, Any（任意）, FreeForAll（混战）",
        `pretransactionmoney` bigint COMMENT "Ares 游戏货币 - Ares 游戏内货币的数量",
        `pretransactionmoneyreceiver` bigint COMMENT "Ares 游戏货币 - Ares 游戏内货币的数量",
        `pretransactionmoneysender` bigint COMMENT "Ares 游戏货币 - Ares 游戏内货币的数量",
        `itemcost` bigint COMMENT "Ares 游戏货币 - Ares 游戏内货币的数量",
        `startinvpriweaponid` string COMMENT "物品 ID - 物品标识符",
        `startinvpriweaponname` string COMMENT "物品名称 - 物品名称",
        `startinvpriweapontype` string COMMENT "物品类型 - 物品的类型",
        `startinvpriweaponavaamt` double COMMENT "Ares 资源数量 - 技能的充能次数、武器的子弹数和护甲的生命值",
        `startinvsecweaponid` string COMMENT "物品 ID - 物品标识符",
        `startinvsecweaponname` string COMMENT "物品名称 - 物品名称",
        `startinvsecweapontype` string COMMENT "物品类型 - 物品的类型",
        `startinvsecweaponavaamt` double COMMENT "Ares 资源数量 - 技能的充能次数、武器的子弹数和护甲的生命值",
        `startinvmeleeid` string COMMENT "物品 ID - 物品标识符",
        `startinvmeleename` string COMMENT "物品名称 - 物品名称",
        `startinvmeleetype` string COMMENT "物品类型 - 物品的类型",
        `startinvmeleeavaamt` double COMMENT "Ares 资源数量 - 技能的充能次数、武器的子弹数和护甲的生命值",
        `startinvarmorid` string COMMENT "物品 ID - 物品标识符",
        `startinvarmorname` string COMMENT "物品名称 - 物品名称",
        `startinvarmortype` string COMMENT "物品类型 - 物品的类型",
        `startinvarmoravaamt` double COMMENT "Ares 资源数量 - 技能的充能次数、武器的子弹数和护甲的生命值",
        `startinvabilities` string COMMENT "AP 子标识符，指向子结构：apInventoryChangeEvent_StartInvAbilities",
        `startinvbackpackitems` string COMMENT "AP 子标识符，指向子结构：apInventoryChangeEvent_StartInvBackpackItems",
        `startinvpassives` string COMMENT "AP 子标识符，指向子结构：apInventoryChangeEvent_StartInvPassives",
        `startinvcurequippedid` string COMMENT "物品 ID - 物品标识符",
        `startinvcurequippedname` string COMMENT "物品名称 - 物品名称",
        `startinvcurequippedtype` string COMMENT "物品类型 - 物品的类型",
        `startinvcurequippedavaamt` double COMMENT "Ares 资源数量 - 技能的充能次数、武器的子弹数和护甲的生命值",
        `endinvpriweaponid` string COMMENT "物品 ID - 物品标识符",
        `endinvpriweaponname` string COMMENT "物品名称 - 物品名称",
        `endinvpriweapontype` string COMMENT "物品类型 - 物品的类型",
        `endinvpriweaponavaamt` double COMMENT "Ares 资源数量 - 技能的充能次数、武器的子弹数和护甲的生命值",
        `endinvsecweaponid` string COMMENT "物品 ID - 物品标识符",
        `endinvsecweaponname` string COMMENT "物品名称 - 物品名称",
        `endinvsecweapontype` string COMMENT "物品类型 - 物品的类型",
        `endinvsecweaponavaamt` double COMMENT "Ares 资源数量 - 技能的充能次数、武器的子弹数和护甲的生命值",
        `endinvmeleeid` string COMMENT "物品 ID - 物品标识符",
        `endinvmeleename` string COMMENT "物品名称 - 物品名称",
        `endinvmeleetype` string COMMENT "物品类型 - 物品的类型",
        `endinvmeleeavaamt` double COMMENT "Ares 资源数量 - 技能的充能次数、武器的子弹数和护甲的生命值",
        `endinvarmorid` string COMMENT "物品 ID - 物品标识符",
        `endinvarmorname` string COMMENT "物品名称 - 物品名称",
        `endinvarmortype` string COMMENT "物品类型 - 物品的类型",
        `endinvarmoravaamt` double COMMENT "Ares 资源数量 - 技能的充能次数、武器的子弹数和护甲的生命值",
        `endinvabilities` string COMMENT "AP 子标识符，指向子结构：apInventoryChangeEvent_EndInvAbilities",
        `endinvbackpackitems` string COMMENT "AP 子标识符，指向子结构：apInventoryChangeEvent_EndInvBackpackItems",
        `endinvpassives` string COMMENT "AP 子标识符，指向子结构：apInventoryChangeEvent_EndInvPassives",
        `endinvcurequippedid` string COMMENT "物品 ID - 物品标识符",
        `endinvcurequippedname` string COMMENT "物品名称 - 物品名称",
        `endinvcurequippedtype` string COMMENT "物品类型 - 物品的类型",
        `endinvcurequippedavaamt` double COMMENT "Ares 资源数量 - 技能的充能次数、武器的子弹数和护甲的生命值",
        `itemname` string COMMENT "物品名称 - 物品名称",
        `itemid` string COMMENT "物品 ID - 物品标识符",
        `receiverid` string COMMENT "RSO PUUID - RFC 0214g - RSO 玩家 ID: Riot 玩家的全局唯一 ID",
        `senderid` string COMMENT "RSO PUUID - RFC 0214g - RSO 玩家 ID: Riot 玩家的全局唯一 ID",
        `transactiontype` string COMMENT "交易类型 - 可选值：[Purchase（购买）, PickUp（拾取）, FulfillRequest（满足请求）, Drop（丢弃）, Sell（出售）, Transfer（转移）, Default（默认）, Other（其他）]",
        `aplogtotal` bigint COMMENT "由此 AP 事件生成的日志总数",
        `clientplatformdetailsplatformtype` string COMMENT "clientPlatformDetailsPlatformType",
        `clientplatformdetailsplatformmetadata` string COMMENT "clientPlatformDetailsPlatformMetadata",
        `platformtype` string COMMENT "platformType",
        `apschemaversion` string COMMENT "apSchemaVersion"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_argothek_playermatchstats_hi` (
        `tdbank_imp_date` string COMMENT "partition fields",
        `dteventtime` string COMMENT "事件时间 - YYYY-MM-DD HH:MM:SS",
        `ieventid` string COMMENT "事件 ID",
        `matchid` string COMMENT "对局 ID - 查询对局的key",
        `vroleid` string COMMENT "当前日志所代表的玩家的角色 ID",
        `wonmatch` bigint COMMENT "是否获胜",
        `mapid` string COMMENT "地图ID",
        `seasonid` string COMMENT "赛季ID",
        `queueid` string COMMENT "模式ID",
        `gamestartmillis` double COMMENT "比赛开始时间(毫秒)",
        `gamelengthmillis` double COMMENT "对局时长",
        `teamid` string COMMENT "队伍 ID，Blue、Red",
        `partyid` string COMMENT "组队房间 ID",
        `ismatchmvp` bigint COMMENT "是否全局MVP",
        `isteammvp` bigint COMMENT "是否队伍MVP",
        `totalscore` double COMMENT "本场比赛总得分",
        `istopdamage` bigint COMMENT "是否伤害最高",
        `istopplant` bigint COMMENT "是否下包最多",
        `istopdefuse` bigint COMMENT "是否拆除次数最多",
        `istopkill` bigint COMMENT "是否击杀数最多",
        `istopassist` bigint COMMENT "是否助攻数最多",
        `totalspent` bigint COMMENT "总消费",
        `economyscore` bigint COMMENT "本场经济得分",
        `killscount` double COMMENT "击杀数",
        `deathscount` double COMMENT "死亡数",
        `assistscount` double COMMENT "助攻数",
        `clutchcount` bigint COMMENT "力克千钧次数",
        `acecount` bigint COMMENT "王牌精锐次数",
        `teamacecount` bigint COMMENT "王牌小队次数",
        `thriftycount` bigint COMMENT "高效火力次数",
        `flawlesscount` bigint COMMENT "完美团灭次数",
        `triplekillcount` bigint COMMENT "本场比赛个人完成3杀的次数",
        `quadrakillcount` bigint COMMENT "本场比赛个人完成4杀的次数",
        `pentakillcount` bigint COMMENT "本场比赛个人完成5杀的次数",
        `sixkillcount` bigint COMMENT "本场比赛个人完成6杀(及以上)的次数",
        `plantcount` bigint COMMENT "下包次数",
        `defusecount` bigint COMMENT "拆包次数",
        `firstkillcount` bigint COMMENT "获得首杀的回合次数",
        `completionstate` string COMMENT "比赛完成情况",
        `roundsplayed` bigint COMMENT "实际游玩回合数",
        `roundswon` bigint COMMENT "获胜回合数",
        `characterid` string COMMENT "英雄ID",
        `totaldamage` double COMMENT "本场比赛个人造成的总伤害值",
        `competitivetier` bigint COMMENT "排位等级",
        `isplayercompleted` bigint COMMENT "玩家是否完成比赛，任何掉线、挂机会视为未完成",
        `ismatchcompleted` bigint COMMENT "比赛是否完成",
        `totalheadshots` double COMMENT "头部命中总次数",
        `totalbodyshots` double COMMENT "身体命中总次数",
        `totallegshots` double COMMENT "手部命中总次数",
        `abilitydefaultcasts` bigint COMMENT "默认技能使用总次数",
        `ability1casts` bigint COMMENT "技能Q使用总次数",
        `ability2casts` bigint COMMENT "技能C使用总次数",
        `ultimatecasts` bigint COMMENT "大招使用总次数",
        `provisioningflowid` string COMMENT "provisioningFlowId "
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_currencylog_hi` (
        `tdbank_imp_date` string COMMENT "小时分区字段，格式YYYYMMDDHH",
        `dteventtime` string COMMENT "游戏事件的时间,格式YY",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填",
        `vplayerid` string COMMENT "玩家id",
        `uid` string COMMENT "玩家UID",
        `sequence` bigint COMMENT "用于关联一次动作产生多条不同类型的货币流动日志",
        `level` bigint COMMENT "玩家等级",
        `allianceforcetermoney` bigint COMMENT "动作后的金钱数",
        `imoney` bigint COMMENT "动作涉及的金钱数",
        `reason` bigint COMMENT "货币流动一级原因",
        `subreason` bigint COMMENT "货币流动二级原因",
        `addorreduce` bigint COMMENT "增加 0/减少 1",
        `imoneytype` bigint COMMENT "枚举值(0:金币;1:点券;2:服饰币;4:物资币;6:荣耀勋章;1026:组竞币;1027:幸运币)",
        `device_type` bigint COMMENT "设备类型0为手机,1为模拟器, 2键鼠, 3手柄, 5是PC客户端,也是高清模拟器。"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_roundflow_entertain_hi` (
        `tdbank_imp_date` string COMMENT "",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "玩家",
        `uid` string COMMENT "(可填)玩家UID",
        `battleid` string COMMENT "对局ID",
        `battletype` bigint COMMENT "战斗类型 对应BATTLETYPE,其它说明参考FAQ文档",
        `roundscore` bigint COMMENT "本局分数,无得分的填0",
        `roundtime` bigint COMMENT "对局时长(秒)",
        `seasonid` bigint COMMENT "所属赛季ID",
        `mode` bigint COMMENT "模式",
        `submode` bigint COMMENT "子模式",
        `map` bigint COMMENT "地图",
        `startime` bigint COMMENT "开局时刻",
        `endtime` bigint COMMENT "结束时刻",
        `playernumber` bigint COMMENT "玩家数",
        `teamnumber` bigint COMMENT "小队数",
        `teammemberlist` string COMMENT "队友List",
        `escapecheckup` bigint COMMENT "是否逃跑",
        `currentroundrank` bigint COMMENT "当局名次",
        `killingcount` bigint COMMENT "击杀",
        `assistcount` bigint COMMENT "助攻次数",
        `survivaltime` bigint COMMENT "存活总时间",
        `damageamount` bigint COMMENT "总伤害量,浮点数，乘以100存入",
        `healtimes` bigint COMMENT "救人次数",
        `healamount` bigint COMMENT "治疗量，浮点数，乘以100存入",
        `movingdistance` bigint COMMENT "前进距离",
        `deadflow` string COMMENT "死亡流水 死亡坐标/死亡类型/死亡时间",
        `headshotcounts` bigint COMMENT "爆头数",
        `obtianedairdroptimes` bigint COMMENT "获得空投次数",
        `vehicledestoryedtimes` bigint COMMENT "摧毁载具次数",
        `killingflow` string COMMENT "击杀流水 :击杀目标ID\t击杀类型\t是否爆头\t击杀距离\t使用的武器ID\t击杀者（角色自己）位置  新增：\t被击杀者位置\t击杀时间（从进入小岛开始到击杀时的毫秒数）\t造成伤害量\t是否移动\t击杀区域ID(-1表示区域表中不记录)\t状态(1:卧倒)\t被击倒的武器id\t击杀圈数\t被击杀者名字\t是否灭队\t是否为ai\tAI的类型\t击倒者uid\t击杀者uid",
        `creepingtime` bigint COMMENT "匍匐时间",
        `drivingtime` bigint COMMENT "驾驶载具时间",
        `walkingdistance` bigint COMMENT "步行距离",
        `staytimeinpoisonedarea` bigint COMMENT "吃毒时间",
        `damageindex` bigint COMMENT "击杀指数,乘100后四舍五入",
        `collectindex` bigint COMMENT "物资指数,乘100后四舍五入",
        `survivalindex` bigint COMMENT "生存指数,乘100后四舍五入",
        `healindex` bigint COMMENT "支援指数,乘100后四舍五入",
        `assaultindex` bigint COMMENT "伤害指数,乘100后四舍五入",
        `ratinglevel` bigint COMMENT "流水评价等级",
        `itemuseflow` string COMMENT "装备的物品流水",
        `medicineuseflow` string COMMENT "使用的药品流水",
        `gunhittimes` bigint COMMENT "枪械命中次数",
        `gunshottimes` bigint COMMENT "枪械射击次数",
        `teamrank` bigint COMMENT "队伍名次",
        `curecount` bigint COMMENT "治疗次数",
        `drivingdistance` bigint COMMENT "行驶距离",
        `teamid` bigint COMMENT "小队ID",
        `landlocation` string COMMENT "落地点坐标,有效字段",
        `flowratinglevel` string COMMENT "当局游戏的评价等级，前面有个Int类型的，但是非要求加一个字符串类型的",
        `rolename` string COMMENT "玩家角色名",
        `matchtype` bigint COMMENT "匹配模式0：手机 1模拟器 8小黑屋 9新手局",
        `dsendtime` string COMMENT "新结束时间字段，ds传过来的字符串",
        `equipmentinfo` string COMMENT "装备信息:头盔ID\t防弹衣ID\t背包ID\t主武器1ID\t主武器1配件ID列表(以,分隔)\t主武器2ID\t主武器2配件ID列表(以,分隔)\t副武器ID\t副武器配件ID列表(以,分隔)\t近战武器ID\t投掷武器ID\t是否佩戴吉利服",
        `ismvp` bigint COMMENT "不是mvp 0/是mvp 1",
        `pronetime` bigint COMMENT "趴地时间",
        `followstate` bigint COMMENT "跳伞跟随  0不跟随，也不被跟随；1是被跟随；2是跟随",
        `touchdownareaid` bigint COMMENT "降落地点类型, 参见赛季任务降落地点类型表",
        `getpropsnumfromteammates` bigint COMMENT "接受队友道具数",
        `sendpropsnumtoteammates` bigint COMMENT "赠送队友道具数",
        `starttorescuetimes` bigint COMMENT "开始救援次数",
        `killeruid` string COMMENT "击杀者UID",
        `killerweaponid` bigint COMMENT "击杀者使用武器ID",
        `killerdistance` bigint COMMENT "击杀者距离",
        `lobbyteamid` string COMMENT "大厅队伍id,ug字段，兼容保留",
        `topxtipsresponse` bigint COMMENT "未进入前5:-1;不点击:0;继续战斗:1;退出竞赛:2",
        `signalhealamount` bigint COMMENT "信号治疗量",
        `friendcount` bigint COMMENT "队友中的好友数量",
        `tournamentid` bigint COMMENT "赛事ID",
        `tournamentstage` bigint COMMENT "赛事阶段",
        `clubname` string COMMENT "众竞赛事战队名称",
        `score` bigint COMMENT "专业赛积分赛段对局的积分",
        `isscorerule` bigint COMMENT "专业赛是否是积分规则赛段",
        `changedrating` bigint COMMENT "算积分模式的rating分变化值",
        `ratingallianceforceterchanged` bigint COMMENT "算积分模式的rating分变化后的值",
        `device_type` bigint COMMENT "设备类型0为手机 1为模拟器 2 键鼠 3 手柄"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_jordass_packet_conf` (
        `ds` string COMMENT "ds"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`ds`)
    DISTRIBUTED BY HASH (`ds`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_jordass_device_login_di` (
        `dtstatdate` string COMMENT "统计日期",
        `vgameappid` string COMMENT "qq/wx",
        `platid` bigint COMMENT "ios0/android1",
        `vplayerid` string COMMENT "vplayerid",
        `device_type` bigint COMMENT "登录端",
        `loginchannel` bigint COMMENT "登录渠道",
        `ionlinetime` bigint COMMENT "在线时长",
        `dtlogintime` string COMMENT "当日最早登录时间",
        `ilogincount` bigint COMMENT "登录次数",
        `vtemp1` string COMMENT "预留字段1",
        `vtemp2` string COMMENT "预留字段2",
        `vtemp3` string COMMENT "预留字段3",
        `itemp1` bigint COMMENT "预留字段4",
        `itemp2` bigint COMMENT "预留字段5",
        `itemp3` bigint COMMENT "预留字段6",
        `seasonmaxsegment` bigint COMMENT "当前赛季最高段位"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_argothek_commercialization_gearid_df` (
        `dtstatdate` string COMMENT "日期",
        `idate` string COMMENT "道具购买日期",
        `purchasesource` string COMMENT "购买来源",
        `purchaseditemid` string COMMENT "道具id",
        `itemtype` string COMMENT "道具类型",
        `itemamount` double COMMENT "道具数量",
        `currencytype` string COMMENT "购买道具消耗货币类型",
        `currencyspent` double COMMENT "购买道具消耗货币金额",
        `itemp1` bigint COMMENT "预留字段1",
        `itemp2` bigint COMMENT "预留字段2",
        `itemp3` bigint COMMENT "预留字段3",
        `itemp4` bigint COMMENT "预留字段4",
        `vtemp1` string COMMENT "预留字段5",
        `vtemp2` string COMMENT "预留字段6",
        `vtemp3` string COMMENT "预留字段7",
        `vtemp4` string COMMENT "预留字段8",
        `vtemp5` string COMMENT "预留字段9"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_allianceshopbuy_hi` (
        `tdbank_imp_date` string COMMENT "",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID",
        `addresresult` bigint COMMENT "",
        `itemclass` bigint COMMENT "",
        `itemid` bigint COMMENT "",
        `itemnum` bigint COMMENT "",
        `corpslevel` bigint COMMENT "",
        `corpsid` string COMMENT "",
        `consumeallmoney` bigint COMMENT "",
        `buyitemlist` string COMMENT ""
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_jordass_playerid2suserid_nf` (
        `vplayerid` string COMMENT "vplayerid",
        `suserid` string COMMENT "suserid"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`vplayerid`)
    DISTRIBUTED BY HASH (`vplayerid`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_alliancebootcamprecord_hi` (
        `tdbank_imp_date` string COMMENT "",
        `corpssvrid` string COMMENT "战队服务器ID",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `corpsid` string COMMENT "联盟ID",
        `memberuid` string COMMENT "成员UID",
        `trainid` bigint COMMENT "特训ID",
        `taskid` bigint COMMENT "任务ID"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_argothek_seasondate_df` (
        `dtstatdate` string COMMENT "数据日期",
        `idate` string COMMENT "赛季日期",
        `seasonid` string COMMENT "赛季ID",
        `seasonidname` string COMMENT "赛季名称",
        `itemp1` bigint COMMENT "itemp1",
        `itemp2` bigint COMMENT "itemp2",
        `vtemp1` string COMMENT "vtemp1",
        `vtemp2` string COMMENT "vtemp2"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_lotteryrecord_hi` (
        `tdbank_imp_date` string COMMENT "小时分区字段，格式YYYYMMDDHH",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "玩家",
        `uid` string COMMENT "角色UID",
        `activitytype` bigint COMMENT "活动类型",
        `discountnum` bigint COMMENT "折扣使用次数",
        `allianceforcetermoney` bigint COMMENT "操作后剩余抽奖比",
        `allianceforceterround` bigint COMMENT "操作后累计轮次数",
        `dailyround` bigint COMMENT "操作后当日累计轮次数",
        `lotteryround` bigint COMMENT "抽奖次数, 单抽：1, 十连抽：10",
        `suprisehit` bigint COMMENT "惊喜,0不命中,1命中",
        `costnum` bigint COMMENT "消耗活动币数量",
        `awardsitems` string COMMENT "第一个是道具id，第二个是道具个数，比如：1602517-2-0-0 道具id是1602517， 道具个数是2。	使用以下逻辑获取道具id和道具个数明细：	```	select 	  -- 提取道具ID（第一个数字段）	  split(exploded_item, '-')[0] AS item_id,	  -- 提取道具数量（第二个数字段）	  split(exploded_item, '-')[1] AS item_count 	from ieg_tdbank::dwd_jordass_lotteryrecord_hi	lateral view explode(split(awardsitems, ':')) tmp AS exploded_item	```",
        `device_type` bigint COMMENT "设备类型0为手机 1为模拟器 2 键鼠 3 手柄",
        `couponinfo` string COMMENT "使用优惠券列表",
        `reductionnum` bigint COMMENT "减免活动币数量"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_activitypersonaldata_hi` (
        `tdbank_imp_date` string COMMENT "小时分区字段，格式YYYYMMDDHH",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `gameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android",
        `playerid` string COMMENT "用户ID / 玩家ID",
        `uid` string COMMENT "角色UID",
        `battleid` string COMMENT "对局id",
        `mode` bigint COMMENT "当局的Mode",
        `submode` bigint COMMENT "当局子模式id",
        `map` bigint COMMENT "当局地图id",
        `eventid` bigint COMMENT "活动事件ID",
        `value1` string COMMENT "事件记录值1，一般是次数，可能单次统计次数也可能分阶段统计次数",
        `value2` string COMMENT "事件记录值2，一般是时间，可能单次统计时间也可能分阶段统计时间"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_jordass_imode_leyuan_nf` (
        `modename` string COMMENT "",
        `imode` bigint COMMENT "",
        `startdate` string COMMENT "",
        `enddate` string COMMENT "",
        `itemp1` bigint COMMENT "预留数字1",
        `itemp2` bigint COMMENT "预留数字2",
        `vtemp1` string COMMENT "预留字符1",
        `vtemp2` string COMMENT "预留字符2"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`modename`)
    DISTRIBUTED BY HASH (`modename`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_jordass_emulator_df` (
        `dtstatdate` string COMMENT "日期",
        `vgameappid` string COMMENT "vgameappid",
        `platid` bigint COMMENT "系统平台：0:IOS，1:Android，255:所有平台",
        `vplayerid` string COMMENT "playerid",
        `dregdate` string COMMENT "首次使用模拟器日期",
        `itemp1` bigint COMMENT "预留数字1",
        `itemp2` bigint COMMENT "预留数字2",
        `vtemp1` string COMMENT "预留字符1",
        `vtemp2` string COMMENT "预留字符2"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_marketpurchase_hi` (
        `tdbank_imp_date` string COMMENT "",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID",
        `shopid_1` bigint COMMENT "第1个商品的商品id",
        `shopmoneytype_1` bigint COMMENT "第1个商品的货币类型",
        `shopprice_1` bigint COMMENT "第1个商品的商品单价",
        `shopcnt_1` bigint COMMENT "第1个商品的购买个数",
        `shoptime_1` bigint COMMENT "第1个商品的购买时限",
        `itemid_1` bigint COMMENT "第1个商品的道具ID",
        `itemextra_1` bigint COMMENT "第1个商品的道具extra_id",
        `shopid_2` bigint COMMENT "第2个商品的商品id",
        `shopmoneytype_2` bigint COMMENT "第2个商品的货币类型",
        `shopprice_2` bigint COMMENT "第2个商品的商品单价",
        `shopcnt_2` bigint COMMENT "第2个商品的购买个数",
        `shoptime_2` bigint COMMENT "第2个商品的购买时限",
        `itemid_2` bigint COMMENT "第2个商品的道具ID",
        `itemextra_2` bigint COMMENT "第2个商品的道具extra_id",
        `shopid_3` bigint COMMENT "第3个商品的商品id",
        `shopmoneytype_3` bigint COMMENT "第3个商品的货币类型",
        `shopprice_3` bigint COMMENT "第3个商品的商品单价",
        `shopcnt_3` bigint COMMENT "第3个商品的购买个数",
        `shoptime_3` bigint COMMENT "第3个商品的购买时限",
        `itemid_3` bigint COMMENT "第3个商品的道具ID",
        `itemextra_3` bigint COMMENT "第3个商品的道具extra_id",
        `shopid_4` bigint COMMENT "第4个商品的商品id",
        `shopmoneytype_4` bigint COMMENT "第4个商品的货币类型",
        `shopprice_4` bigint COMMENT "第4个商品的商品单价",
        `shopcnt_4` bigint COMMENT "第4个商品的购买个数",
        `shoptime_4` bigint COMMENT "第4个商品的购买时限",
        `itemid_4` bigint COMMENT "第4个商品的道具ID",
        `itemextra_4` bigint COMMENT "第4个商品的道具extra_id",
        `shopid_5` bigint COMMENT "第5个商品的商品id",
        `shopmoneytype_5` bigint COMMENT "第5个商品的货币类型",
        `shopprice_5` bigint COMMENT "第5个商品的商品单价",
        `shopcnt_5` bigint COMMENT "第5个商品的购买个数",
        `shoptime_5` bigint COMMENT "第5个商品的购买时限",
        `itemid_5` bigint COMMENT "第5个商品的道具ID",
        `itemextra_5` bigint COMMENT "第5个商品的道具extra_id",
        `total_ticket` bigint COMMENT "总消耗点券数",
        `total_diamond` bigint COMMENT "总消耗钻石数",
        `total_gold` bigint COMMENT "总消耗金币数",
        `present_flag` bigint COMMENT "此次购买是否是赠送给他人",
        `billno` string COMMENT "订单号",
        `shopid_6` bigint COMMENT "第6个商品的商品id",
        `shopmoneytype_6` bigint COMMENT "第6个商品的货币类型",
        `shopprice_6` bigint COMMENT "第6个商品的商品单价",
        `shopcnt_6` bigint COMMENT "第6个商品的购买个数",
        `shoptime_6` bigint COMMENT "第6个商品的购买时限",
        `itemid_6` bigint COMMENT "第6个商品的道具ID",
        `itemextra_6` bigint COMMENT "第6个商品的道具extra_id",
        `shopid_7` bigint COMMENT "第7个商品的商品id",
        `shopmoneytype_7` bigint COMMENT "第7个商品的货币类型",
        `shopprice_7` bigint COMMENT "第7个商品的商品单价",
        `shopcnt_7` bigint COMMENT "第7个商品的购买个数",
        `shoptime_7` bigint COMMENT "第7个商品的购买时限",
        `itemid_7` bigint COMMENT "第7个商品的道具ID",
        `itemextra_7` bigint COMMENT "第7个商品的道具extra_id",
        `total_gun_coin` bigint COMMENT "总消耗枪械币数",
        `total_item_coin` bigint COMMENT "总消耗物资币数",
        `total_trans_server_coin` bigint COMMENT "总消耗换服币数",
        `full_sub_resid` bigint COMMENT "满减券物品id",
        `full_sub_value` bigint COMMENT "满减券减免点券",
        `total_bw_coin` bigint COMMENT "总消耗广阔天地币数",
        `shopid_8` bigint COMMENT "第8个商品的商品id",
        `shopmoneytype_8` bigint COMMENT "第8个商品的货币类型",
        `shopprice_8` bigint COMMENT "第8个商品的商品单价",
        `shopcnt_8` bigint COMMENT "第8个商品的购买个数",
        `shoptime_8` bigint COMMENT "第8个商品的购买时限",
        `itemid_8` bigint COMMENT "第8个商品的道具ID",
        `itemextra_8` bigint COMMENT "第8个商品的道具extra_id",
        `shopid_9` bigint COMMENT "第9个商品的商品id",
        `shopmoneytype_9` bigint COMMENT "第9个商品的货币类型",
        `shopprice_9` bigint COMMENT "第9个商品的商品单价",
        `shopcnt_9` bigint COMMENT "第9个商品的购买个数",
        `shoptime_9` bigint COMMENT "第9个商品的购买时限",
        `itemid_9` bigint COMMENT "第9个商品的道具ID",
        `itemextra_9` bigint COMMENT "第9个商品的道具extra_id",
        `shopid_10` bigint COMMENT "第10个商品的商品id",
        `shopmoneytype_10` bigint COMMENT "第10个商品的货币类型",
        `shopprice_10` bigint COMMENT "第10个商品的商品单价",
        `shopcnt_10` bigint COMMENT "第10个商品的购买个数",
        `shoptime_10` bigint COMMENT "第10个商品的购买时限",
        `itemid_10` bigint COMMENT "第10个商品的道具ID",
        `itemextra_10` bigint COMMENT "第10个商品的道具extra_id",
        `shopid_11` bigint COMMENT "第11个商品的商品id",
        `shopmoneytype_11` bigint COMMENT "第11个商品的货币类型",
        `shopprice_11` bigint COMMENT "第11个商品的商品单价",
        `shopcnt_11` bigint COMMENT "第11个商品的购买个数",
        `shoptime_11` bigint COMMENT "第11个商品的购买时限",
        `itemid_11` bigint COMMENT "第11个商品的道具ID",
        `itemextra_11` bigint COMMENT "第11个商品的道具extra_id",
        `shopid_12` bigint COMMENT "第12个商品的商品id",
        `shopmoneytype_12` bigint COMMENT "第12个商品的货币类型",
        `shopprice_12` bigint COMMENT "第12个商品的商品单价",
        `shopcnt_12` bigint COMMENT "第12个商品的购买个数",
        `shoptime_12` bigint COMMENT "第12个商品的购买时限",
        `itemid_12` bigint COMMENT "第12个商品的道具ID",
        `itemextra_12` bigint COMMENT "第12个商品的道具extra_id",
        `source` bigint COMMENT "商城购买的来源",
        `device_type` bigint COMMENT "设备类型0为手机 1为模拟器 2 键鼠 3 手柄"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_gearlog_hi` (
        `tdbank_imp_date` string COMMENT "小时分区字段，格式YYYYMMDDHH",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "玩家ID",
        `uid` string COMMENT "玩家UID",
        `igoodsinstid` string COMMENT "(可填)道具唯一ID",
        `level` bigint COMMENT "玩家等级",
        `sequence` bigint COMMENT "(可填)用于关联一次购买产生多条不同类型的货币日志",
        `igoodstype` bigint COMMENT "道具类型",
        `igoodsid` bigint COMMENT "道具ID",
        `count` bigint COMMENT "数量",
        `allianceforcetercount` bigint COMMENT "动作后的物品存量",
        `reason` bigint COMMENT "道具流动一级原因",
        `subreason` bigint COMMENT "道具流动二级原因",
        `imoney` bigint COMMENT "花费代币或金币购买道具情况下输出消耗的钱数量，否则填0",
        `imoneytype` bigint COMMENT "钱的类型MONEYTYPE,其它货币类型参考FAQ文档",
        `addorreduce` bigint COMMENT "增加 0/减少 1",
        `validhours` bigint COMMENT "(可填)有效时间(乘以1000倍存储)",
        `expiretime` string COMMENT "(可填)到期时间",
        `subtype` bigint COMMENT "(可填)道具子类型",
        `device_type` bigint COMMENT "设备类型0为手机 1为模拟器 2 键鼠 3 手柄"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_jordass_buttonpress_pre_di` (
        `dtstatdate` string COMMENT "统计日期，格式YYYYMMDD",
        `dteventtime` string COMMENT "事件时间,格式YYYY-MM-DDHH:MM:SS",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` string COMMENT "系统平台：0:IOS,1:Android",
        `izoneareaid` string COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `clientversion` string COMMENT "clientversion",
        `vplayerid` string COMMENT "玩家ID",
        `uid` string COMMENT "角色ID",
        `buttontype` string COMMENT "按钮代号",
        `ireason` string COMMENT "额外参数",
        `extarg1` string COMMENT "附加参数1",
        `extarg2` string COMMENT "附加参数2"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_jordass_water_df` (
        `dtstatdate` string COMMENT "分区，付费日期，格式YYYYMMDD",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android，255所有平台",
        `vplayerid` string COMMENT "玩家ID",
        `cbitmap` string COMMENT "流水位图",
        `dwaterdate` string COMMENT "首次流水日期",
        `imoney` double COMMENT "累计流水收入(分)(简称流水)",
        `iamount` bigint COMMENT "代币金额(Q分)"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_jordass_login_df` (
        `dtstatdate` string COMMENT "分区字段，登陆日期，格式YYYYMMDD",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS，1:Android，255:不区分平台",
        `vplayerid` string COMMENT "玩家ID",
        `cbitmap` string COMMENT "登录位图",
        `dregdate` string COMMENT "注册日期，格式YYYYMMDD",
        `ilevel` bigint COMMENT "等级",
        `friendcount` bigint COMMENT "好友数量"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_argothek_playerloadout_hi` (
        `tdbank_imp_date` string COMMENT "分区字段",
        `dteventtime` string COMMENT "AP 事件时间: YYYY-MM-DD HH:MM:SS",
        `apeventid` string COMMENT "AP 事件标识符",
        `subject` string COMMENT "RSO PUUID - RFC 0214g - RSO 玩家 ID: Riot 玩家的全局唯一 ID",
        `matchinfoversion` string COMMENT "Ares 构建版本 - Ares 二进制文件的完整构建版本",
        `matchinfogamemode` string COMMENT "Ares 游戏模式 - 正在进行的比赛类型",
        `matchinfomapid` string COMMENT "Ares 地图 - Ares 地图的名称",
        `matchinfomatchid` string COMMENT "Ares 匹配 ID - Ares 匹配的 ID 字符串",
        `matchinfoqueueid` string COMMENT "Ares 队列 ID - Ares 队列的 ID 字符串",
        `matchinfoisranked` bigint COMMENT "布尔值 - 一个布尔值",
        `matchinfoprvflowid` string COMMENT "配置流程 ID - 已配置的游戏类型。例如：技能测试、匹配等",
        `equippables` string COMMENT "AP 子标识符，指向子结构：apPlayerLoadout_equippables",
        `sprayslots` string COMMENT "AP 子标识符，指向子结构：apPlayerLoadout_spraySlots",
        `playercardid` string COMMENT "玩家卡片 ID - 玩家卡片的标识符",
        `playertitleid` string COMMENT "玩家称号 ID - 玩家称号的标识符",
        `characterid` string COMMENT "角色 ID - 角色的标识符。",
        `scopeenvironment` string COMMENT "RFC 190-2 环境 - 按运营商划分的用于共同目的（游戏）服务的逻辑分组",
        `scopedatacenter` string COMMENT "RFC 190-2 数据中心 - 使用标准数据中心代码的服务物理位置",
        `scopedeployment` string COMMENT "RFC 190-2 部署 - 服务的逻辑分组，允许同一数据中心和环境中相同应用程序的独立分组",
        `scopeproduct` string COMMENT "RFC 190-2 产品 - 一套或多套共同开发、交付和运营的相关服务",
        `scopecomponent` string COMMENT "RFC 190-2 组件 - 实施产品部分工作的特定（子）组件",
        `aplogtotal` bigint COMMENT "由此 AP 事件生成的日志总数",
        `clientplatformdetailsplatformtype` string COMMENT "clientPlatformDetailsPlatformType",
        `clientplatformdetailsplatformmetadata` string COMMENT "clientPlatformDetailsPlatformMetadata",
        `apschemaversion` string COMMENT "apSchemaVersion"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dws_jordass_login_di` (
        `dtstatdate` string COMMENT "分区字段，登陆日期，格式YYYYMMDD",
        `vgameappid` string COMMENT "账号体系：	'wx' - 微信	'qq' - 手Q",
        `platid` bigint COMMENT "系统平台：0:IOS，1:Android，255:所有平台",
        `vplayerid` string COMMENT "玩家ID",
        `ilevel` bigint COMMENT "等级",
        `ionlinetime` bigint COMMENT "在线时长(秒)",
        `ilogincount` bigint COMMENT "登录次数",
        `friendcount` bigint COMMENT "好友数量",
        `dtlogintime` string COMMENT "当日最早登录时间,格式YYYY-MM-DDHH:MM:SS"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_buttonpress_pre_di` (
        `dtstatdate` string COMMENT "日期",
        `dteventtime` string COMMENT "",
        `vgameappid` string COMMENT "",
        `platid` bigint COMMENT "游戏APPID",
        `izoneareaid` bigint COMMENT "ios 0/android 1",
        `vplayerid` string COMMENT "",
        `uid` string COMMENT "角色UID",
        `buttontype` string COMMENT "按钮代号以分号分隔",
        `param1` string COMMENT "附加参数1以分号分隔",
        `param2` string COMMENT "附加参数2以分号分隔",
        `param3` string COMMENT "附加参数3以分号分隔",
        `param4` string COMMENT "附加参数4以分号分隔",
        `param5` string COMMENT "附加参数5以分号分隔",
        `param6` string COMMENT "附加参数6以分号分隔",
        `unixtime` string COMMENT "",
        `ugcmarea` string COMMENT ""
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dim_mgamejp_tbplayerid2qq_nf` (
        `dtstatdate` bigint COMMENT "统计日期YYYYMMDD",
        `sappid` string COMMENT "游戏id",
        `splayerid` string COMMENT "playerid",
        `iqq` bigint COMMENT "QQ帐号"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`dtstatdate`)
    DISTRIBUTED BY HASH (`dtstatdate`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_wereplayerdatallianceforcelow_hi` (
        `tdbank_imp_date` string COMMENT "",
        `gamesvrid` string COMMENT "登录的游戏服务器编号",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID，操作人",
        `teamid` bigint COMMENT "队伍ID",
        `choosewerewolf` bigint COMMENT "初始选择身份 0特种兵，1内鬼",
        `iswerewolf` bigint COMMENT "确定的身份 0特种兵，1内鬼",
        `battleid` string COMMENT "对局ID",
        `roundid` bigint COMMENT "第几次开局",
        `setbombcount` bigint COMMENT "发起紧急任务次数,放置炸弹",
        `killcount` bigint COMMENT "杀死特种兵数",
        `deathtime` string COMMENT "死亡后累计时长",
        `ghosttaskpoint` bigint COMMENT "死亡后完成任务点数",
        `completetaskpoint` bigint COMMENT "个人完成任务点数",
        `monitorcount` bigint COMMENT "累计使用监控次数",
        `discusstimesallianceforceterdeath` bigint COMMENT "发起讨论次数,发现尸体发起",
        `discusstimesemergency` bigint COMMENT "发起讨论次数，圆桌发起,紧急讨论次数",
        `shuttletimes` bigint COMMENT "穿梭通道次数",
        `voteinfo` string COMMENT "每轮投票情况",
        `teammemberlist` string COMMENT "队友UID列表",
        `completetask` string COMMENT "完成任务数据信息",
        `deadflow` string COMMENT "死亡流水 死亡坐标/死亡类型/死亡时间",
        `changebehscore` bigint COMMENT "影响等级积分的行为分变化分",
        `changeskillscore` bigint COMMENT "影响等级积分的熟练分变化分",
        `changelevelscore` bigint COMMENT "等级积分的变化分",
        `allianceforceterlevelscore` bigint COMMENT "变化后等级积分",
        `specialstatus` bigint COMMENT "身份分配（普通内鬼/特种兵为0，特殊身份为1）",
        `microactiveness` string COMMENT "开麦互动度",
        `getskillflow` string COMMENT "获得技能流水 :(技能id/获得时间/获得位置)",
        `useskillflow` string COMMENT "使用技能流水 :(技能id/使用时间/当局第几次使用/使用目标：0无目标1内鬼2特种兵/使用位置)",
        `discussflow` string COMMENT "发起讨论流水 :(会议发起类型/会议发起坐标/会议发起时间)",
        `taskflow` string COMMENT "任务流水 :(任务id/完成时间/进度贡献/任务坐标)",
        `mode` bigint COMMENT "模式",
        `submode` bigint COMMENT "子模式",
        `map` bigint COMMENT "地图id",
        `level` bigint COMMENT "变化后等级",
        `iswin` bigint COMMENT "胜负,1:胜、0:负",
        `ismvp` bigint COMMENT "mvp或者svmp，不是mvp 0/是mvp 1, svp 2",
        `ratinglevel` string COMMENT "流水评价等级, S/A/B/C",
        `startime` bigint COMMENT "开局时刻",
        `endtime` bigint COMMENT "结束时刻",
        `taskpoint` string COMMENT "个人完成的任务点数",
        `totaltaskpoint` string COMMENT "总任务点数",
        `personid` bigint COMMENT "对局内个人编号，例：1-10",
        `setfogtimes` bigint COMMENT "释放烟雾次数",
        `totalgetvotes` bigint COMMENT "总得票",
        `triggerbox` bigint COMMENT "触发盒子次数",
        `votewerewolftimes` bigint COMMENT "投中内鬼次数",
        `emergtasktimes` bigint COMMENT "紧急任务次数",
        `titleidlist` string COMMENT "获得的称号Id,1-8，格式：1+2+3(1：金牌杀手、2：破坏王、3：拆弹专家、4：替罪羊、5：救火队员、6：无辜之人、7：巡逻员、8、狼来了的小孩)",
        `owneruid` string COMMENT "房主uid"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_argothek_playerloadout_expressions_hi` (
        `tdbank_imp_date` string COMMENT "分区字段",
        `dteventtime` string COMMENT "AP 事件时间",
        `apeventid` string COMMENT "AP 事件标识符",
        `apchildid` string COMMENT "AP 子标识符",
        `apchildindex` bigint COMMENT "AP 子索引",
        `expressionassetid` string COMMENT "表情资源 ID",
        `expressiontypeid` string COMMENT "表情类型 ID"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_vsteamshoplog_hi` (
        `tdbank_imp_date` string COMMENT "",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "玩家",
        `uid` string COMMENT "(可填)角色UID",
        `shopid` bigint COMMENT "购买id",
        `count` bigint COMMENT "购买数量"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_mysteryplaylog_hi` (
        `tdbank_imp_date` string COMMENT "分区字段，小时分区，格式：YYYYMMDDHH",
        `iid` string COMMENT "日志唯一ID",
        `dttime` string COMMENT "时间戳",
        `suser` string COMMENT "对应游戏内vplayerid",
        `sphoneid` string COMMENT "PhoneID",
        `imodule` string COMMENT "模块ID",
        `ichannel` string COMMENT "频道ID",
        `itype` string COMMENT "类型",
        `sappid` string COMMENT "vgameappid(手Q、微信)",
        `iostype` string COMMENT "platid(安卓、IOS)",
        `iactid` string COMMENT "活动ID",
        `ijumptype` string COMMENT "跳转类型",
        `sjumpurl` string COMMENT "跳转地址",
        `ipartition` string COMMENT "小区",
        `recommend_id` string COMMENT "推荐ID",
        `changjing_id` string COMMENT "场景ID",
        `goods_id` string COMMENT "礼包ID",
        `useridt_count` string COMMENT "个数",
        `useridt_fee` string COMMENT "价格",
        `currency_type` string COMMENT "货币类型",
        `service_type` bigint COMMENT "业务类型",
        `sroleid` string COMMENT "角色ID",
        `act_style` string COMMENT "活动类型",
        `flow_id` string COMMENT "活动FlowID",
        `dteventtime` string COMMENT "事件时间,格式YYYY-MM-DDHH:MM:SS",
        `reserve0` string COMMENT "预留字段",
        `reserve1` string COMMENT "预留字段",
        `reserve2` string COMMENT "预留字段",
        `reserve3` string COMMENT "预留字段",
        `reserve4` string COMMENT "预留字段",
        `reserve5` string COMMENT "预留字段",
        `reserve6` string COMMENT "comment",
        `reserve7` string COMMENT "预留字段",
        `reserve8` string COMMENT "预留字段",
        `reserve9` string COMMENT "预留字段",
        `taskid` string COMMENT "流量管家taskid",
        `partflag` string COMMENT "参与活动标志:0表示非参与,大于0表示参与"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_playerprofstagechange_hi` (
        `tdbank_imp_date` string COMMENT "小时分区字段，格式YYYYMMDDHH",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "账号体系：'wx':微信，'qq'：手Q",
        `platid` bigint COMMENT "系统平台：0:IOS,1:Android",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID",
        `tournamentid` bigint COMMENT "赛事id",
        `beforstage` bigint COMMENT "变更前阶段",
        `allianceforceterstage` bigint COMMENT "变更后阶段",
        `ruletype` bigint COMMENT "晋级规则类型",
        `ispass` bigint COMMENT "是否晋级",
        `teamrank` bigint COMMENT "积分赛排名，没有上榜的值为-1",
        `battlecount` bigint COMMENT "当前赛段对局数",
        `clubid` string COMMENT "战队id,单人参赛阶段值为0"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_directpaycommflow_hi` (
        `tdbank_imp_date` string COMMENT "",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID，操作人",
        `orderid` string COMMENT "订单号",
        `productid` string COMMENT "productid",
        `goodsnum` bigint COMMENT "商品数量",
        `money` bigint COMMENT "商品对应消耗货币数量",
        `op` string COMMENT "操作步骤",
        `opres` string COMMENT "操作步骤结果",
        `midasbillno` string COMMENT "midas订单号"
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    

    CREATE TABLE IF NOT EXISTS `dwd_jordass_vsteaminfectlog_hi` (
        `tdbank_imp_date` string COMMENT "",
        `dteventtime` string COMMENT "游戏事件的时间, 格式 YYYY-MM-DD HH:MM:SS",
        `vgameappid` string COMMENT "游戏APPID",
        `platid` bigint COMMENT "ios 0/android 1",
        `izoneareaid` bigint COMMENT "针对分区分服的游戏填写分区id，用来唯一标示一个区；非分区分服游戏请填写0",
        `vplayerid` string COMMENT "用户playerid号",
        `uid` string COMMENT "角色UID",
        `battleid` string COMMENT "对局ID",
        `roundid` bigint COMMENT "回合数",
        `isescape` bigint COMMENT "是否逃跑",
        `infectionscore` bigint COMMENT "回合总积分",
        `infectionscoreasinfected` bigint COMMENT "突变者阵营积分",
        `infectionscoreashuman` bigint COMMENT "人类阵营积分",
        `infectlevelupbyitemtimes` bigint COMMENT "突变者强化升级次数",
        `infectlevelupbykilltimes` bigint COMMENT "突变者淘汰升级次数",
        `infecttimes` bigint COMMENT "回合感染人类数量",
        `killsupermantimes` bigint COMMENT "回合击杀超级英雄数量",
        `isadvancedinfected` bigint COMMENT "是否超级突变者（0，为成为超级突变者、1初始超级突变者、2进化为超级突变者）",
        `revivaltimes` bigint COMMENT "复活次数",
        `beensuperman` bigint COMMENT "是否升级为超级英雄（0，未成为超级英雄，1升级为超级突变者）",
        `supermanleveluptimes` bigint COMMENT "超级战士升级次数",
        `usesupplytimes` bigint COMMENT "弹药补给次数",
        `damageoninfect` bigint COMMENT "回合对突变者造成伤害数",
        `killadvancedinfectedtimes` bigint COMMENT "回合淘汰超级突变者数量",
        `killinfectedtimes` bigint COMMENT "淘汰突变者次数",
        `assisttimes` bigint COMMENT "助攻次数",
        `killwithshootingtimes` bigint COMMENT "枪械击杀数",
        `killwithmeleetimes` bigint COMMENT "近战击杀数",
        `headshottimes` bigint COMMENT "爆头数",
        `wincamp` bigint COMMENT "人类获胜：1，突变者胜利：2",
        `usefortifiertimes` bigint COMMENT "回合拾取强化剂次数",
        `changeposxhero` string COMMENT "回合升级为超级英雄的X坐标",
        `changeposyhero` string COMMENT "回合升级为超级英雄的Y坐标",
        `changeposzhero` string COMMENT "回合升级为超级英雄的Z坐标",
        `changetimehero` string COMMENT "回合升级为超级英雄的时间点",
        `changetypehero` bigint COMMENT "回合升级为超级英雄的类型",
        `changeposxinfectman` string COMMENT "回合变异为突变者的X坐标",
        `changeposyinfectman` string COMMENT "回合变异为突变者的Y坐标",
        `changeposzinfectman` string COMMENT "回合变异为突变者的Z坐标",
        `changetimeinfectman` string COMMENT "回合变异为突变者的时间点",
        `changetypeinfectman` bigint COMMENT "回合变异为突变者的类型",
        `changeposxsuperinfectman` string COMMENT "回合变异为超级突变者的X坐标",
        `changeposysuperinfectman` string COMMENT "回合变异为超级突变者的Y坐标",
        `changeposzsuperinfectman` string COMMENT "回合变异为超级突变者的Z坐标",
        `changetimesuperinfectman` string COMMENT "回合变异为超级突变者的时间点",
        `changetypesuperinfectman` bigint COMMENT "回合变异为超级突变者的类型",
        `totalragehuman` bigint COMMENT "本回合获取怒气值总值（人类）",
        `totalragesuperman` bigint COMMENT "本回合获取怒气值总值（强能猎手）",
        `totalrageinfectedman` bigint COMMENT "本回合获取怒气值总值（普通突变者）",
        `totalrageadvinfectedman` bigint COMMENT "本回合获取怒气值总值（高级突变者）",
        `totalinfect02passiveskill` bigint COMMENT "本回合小紫皮—疾行技能使用次数",
        `totalinfect01passiveskill` bigint COMMENT "本回合大紫皮—护盾技能使用次数",
        `totalinfect01passiveskillcaldamage` string COMMENT "本回合大紫皮—护盾技能吸收伤害总值",
        `totalhookskilluse` bigint COMMENT "本回合狂爪——钩爪技能使用次数",
        `totalhookcapture` bigint COMMENT "本回合狂爪——钩爪技能命中次数",
        `totalhooktakedamage` string COMMENT "本回合狂爪——本回合钩爪损失血量总值",
        `totalhookbroken` bigint COMMENT "本回合狂爪——本回合钩爪被打坏次数",
        `totalinvisibleskilluse` bigint COMMENT "本回合魅影——隐身技能使用次数",
        `totalvisibletakedamage` string COMMENT "本回合本回合魅影——本回合非隐身状态损失总血量",
        `totalvisibletime` bigint COMMENT "本回合魅影——本回合非隐身状态身总时长",
        `totalinvisibletakedamage` string COMMENT "本回合魅影——本回合隐身状态损失总血量",
        `totalinvisibletime` bigint COMMENT "本回合魅影——本回合隐身状态总时长",
        `totalfrozengrenadeskilluse` bigint COMMENT "本回合冰霜领主——冰霜炸弹使用次数",
        `totalfronzengrenadeattackcount` bigint COMMENT "本回合冰霜领主——冰霜炸弹命中次数",
        `totalfrozenplayercount` bigint COMMENT "本回合冰霜领主——冰霜炸弹冰冻玩家次数",
        `totaldragonbreathskilluse` bigint COMMENT "本回合龙焰猎手——龙息弹使用次数",
        `totaldragonbreathattackcount` bigint COMMENT "本回合龙焰猎手——龙息弹命中次数",
        `totaldmghuman` string COMMENT "本回合普通人类造成伤害总值",
        `totaldmgdragonsuperman` string COMMENT "本回合龙焰猎手造成伤害总值",
        `totaldmgpowersuperman` string COMMENT "本回合强能猎手造成伤害总值",
        `totaldmgspeedinfected` string COMMENT "本回合速行战士造成伤害总值--疾行",
        `totaldmginvisinfected` string COMMENT "本回合隐形战士造成伤害总值--魅影",
        `totaldmghookinfected` string COMMENT "本回合钩链战士造成伤害总值--狂爪",
        `totaldmgpoweradvinfected` string COMMENT "本回合强化战士造成伤害总值--强化",
        `totaldmgfrozenadvinfected` string COMMENT "本回合冰霜领主造成伤害总值--冰霜领主",
        `swiftmorphinfo` string COMMENT "变身速行战士：变身时间+变身类型+坐标x+坐标y+坐标z",
        `stealthmorphinfo` string COMMENT "变身隐形战士：变身时间+变身类型+坐标x+坐标y+坐标z",
        `grapplemorphinfo` string COMMENT "变身钩链战士：变身时间+变身类型+坐标x+坐标y+坐标z",
        `poweradvmorphinfo` string COMMENT "变身强化战士（原大胖子）：变身时间+变身类型+坐标x+坐标y+坐标z",
        `iceadvmorphinfo` string COMMENT "变身冰霜领主：变身时间+变身类型+坐标x+坐标y+坐标z",
        `heromorphinfo` string COMMENT "变身强能猎手：变身时间+变身类型+坐标x+坐标y+坐标z",
        `dragonheromorphinfo` string COMMENT "变身龙焰猎手：变身时间+变身类型+坐标x+坐标y+坐标z",
        `fakerinfectedchangeinfo` string COMMENT "FakerInfectedChangeInfo ",
        `forgingironinfectedchangeinfo` string COMMENT "ForgingIronInfectedChangeInfo ",
        `enchantingbutterflyinfectedchangeinfo` string COMMENT "EnchantingButterflyInfectedChangeInfo ",
        `ironfistinfectedchangeinfo` string COMMENT "IronFistInfectedChangeInfo ",
        `phoenixsupermanchangeinfo` string COMMENT "PhoenixSupermanChangeInfo ",
        `titansupermanchangeinfo` string COMMENT "TitanSupermanChangeInfo ",
        `humanadditionevolution` string COMMENT "HumanAdditionEvolution ",
        `supermanadditionevolution` string COMMENT "SupermanAdditionEvolution ",
        `infectedmanadditionevolution` string COMMENT "InfectedManAdditionEvolution ",
        `humanadditionevolutionbyitemtimes` string COMMENT "HumanAdditionEvolutionByItemTimes ",
        `usehumanfortifiertimes` bigint COMMENT "UseHumanFortifierTimes ",
        `totalfibuildboxcount` bigint COMMENT "TotalFIBuildBoxCount ",
        `totalfiboxdestroyedcount` bigint COMMENT "TotalFIBoxDestroyedCount ",
        `totalfakerdisguiseusecount` bigint COMMENT "TotalFakerDisguiseUseCount ",
        `totalfakerdeadinhumanstate` bigint COMMENT "TotalFakerDeadInHumanState ",
        `totalfakerdeadinmonsterstate` bigint COMMENT "TotalFakerDeadInMonsterState ",
        `totalpowersupermanskilluse` bigint COMMENT "TotalPowerSupermanSkillUse ",
        `totalpowersupermanhitcount` bigint COMMENT "TotalPowerSupermanHitCount ",
        `totalpowersupermandamage` string COMMENT "TotalPowerSupermanDamage ",
        `totalphoenixfireringusecount` bigint COMMENT "TotalPhoenixFireRingUseCount ",
        `totalphoenixfireringdamage` string COMMENT "TotalPhoenixFireRingDamage ",
        `totalphoenixfireringhealth` string COMMENT "TotalPhoenixFireRingHealth ",
        `totaltitanjumpsmathusecount` bigint COMMENT "TotalTitanJumpSmathUseCount ",
        `totaltitanjumpsmathhitcount` bigint COMMENT "TotalTitanJumpSmathHitCount ",
        `totaltitanjumpsmathdamage` string COMMENT "TotalTitanJumpSmathDamage ",
        `totalebskilluse` bigint COMMENT "TotalEBSkillUse ",
        `totalebhitcount` bigint COMMENT "TotalEBHitCount ",
        `totalebinfectcount` bigint COMMENT "TotalEBInfectCount ",
        `totalironfistchargeusecount` bigint COMMENT "TotalIronFistChargeUseCount ",
        `totalironfistchargedamagereduce` string COMMENT "TotalIronFistChargeDamageReduce ",
        `totalironfistchargehitcount` bigint COMMENT "TotalIronFistChargeHitCount ",
        `totalironfistchargedamage` string COMMENT "TotalIronFistChargeDamage ",
        `totaldmgforgingironinfected` string COMMENT "TotalDMGForgingIronInfected ",
        `totaldmgfakerinfected` string COMMENT "TotalDMGFakerInfected ",
        `totaldmgphoenixsuperman` string COMMENT "TotalDMGPhoenixSuperman ",
        `totaldmgtitansuperman` string COMMENT "TotalDMGTitanSuperman ",
        `totaldmgenchantingbutterflyinfected` string COMMENT "TotalDMGEnchantingButterflyInfected ",
        `totaldmgironfistinfected` string COMMENT "TotalDMGIronFistInfected ",
        `roundusedcountforgingironinfected` bigint COMMENT "RoundUsedCountForgingIronInfected ",
        `roundusedcountfakerinfected` bigint COMMENT "RoundUsedCountFakerInfected ",
        `roundusedcountphoenixsuperman` bigint COMMENT "RoundUsedCountPhoenixSuperman ",
        `roundusedcounttitansuperman` bigint COMMENT "RoundUsedCountTitanSuperman ",
        `roundusedcountenchantingbutterflyinfected` bigint COMMENT "RoundUsedCountEnchantingButterflyInfected ",
        `roundusedcountironfistinfected` bigint COMMENT "RoundUsedCountIronFistInfected ",
        `roundusedcountspeedinfected` bigint COMMENT "RoundUsedCountSpeedInfected ",
        `roundusedcounthookinfected` bigint COMMENT "RoundUsedCountHookInfected ",
        `roundusedcountinvisinfected` bigint COMMENT "RoundUsedCountInvisInfected ",
        `roundusedcountpoweradvinfected` bigint COMMENT "RoundUsedCountPowerAdvInfected ",
        `roundusedcountfrozenadvinfected` bigint COMMENT "RoundUsedCountFrozenAdvInfected ",
        `roundusedcountpowersuperman` bigint COMMENT "RoundUsedCountPowerSuperman ",
        `roundusedcountdragonsuperman` bigint COMMENT "RoundUsedCountDragonSuperman ",
        `roundselectcamptype` bigint COMMENT "RoundSelectCampType ",
        `roundrandomcamptype` bigint COMMENT "RoundRandomCampType ",
        `roundendcamptype` bigint COMMENT "RoundEndCampType ",
        `roundwinstate` bigint COMMENT "RoundWinState "
    )
    ENGINE=OLAP
    DUPLICATE KEY (`tdbank_imp_date`)
    DISTRIBUTED BY HASH (`tdbank_imp_date`) BUCKETS 10
    PROPERTIES ('replication_num' = '1');
    