ANNOUNCE_STRINGS = {
	-- These are not character-specific strings, but are here to ease translation
	-- Note that spaces at the beginning and end of these are important and should be preserved
	-- 简体中文版本 Simplified Chinese Version
	_ = {
		getArticle = function(name)
			--This checks if the name starts with a vowel, and uses "an" if so, "a" otherwise
			return "1 个"
		end,
		--Goes into {S} if there are multiple items (plural)
		-- This isn't perfect for making plural even in English, but it's close enough
		S = "个",
		STAT_NAMES = {
			Hunger = "饥饿度",
			Sanity = "精神值",
			Health = "生命值",
			Wetness = "潮湿度",
			Boat = "船",
			["Log Meter"] = "怪物度",
			Age = "年龄",
			Abigail = "阿比盖尔",
			Inspiration = "灵感",
			Might = "威力",
			--Other mod stats won't have translations, but at least we can support these
		},
		ANNOUNCE_ITEM = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "I have 6 papyrus in this chest."
			FORMAT_STRING = "{I_HAVE}{THIS_MANY} {S}{ITEM}{IN_THIS}{CONTAINER}{WITH}{PERCENT}{DURABILITY}。",

			--One of these goes into {I_HAVE}
			I_HAVE = "我拥有 ",
			WE_HAVE = "我们拥有 ",

			--{THIS_MANY} is a number if multiple, but singular varies a lot by language,
			-- so we use getArticle above to get it

			--{ITEM} is acquired from item.name

			--{S} uses S above

			--Goes into {IN_THIS}, if present
			IN_THIS = " 在这个 ",

			--{CONTAINER} is acquired from container.name

			--One of these goes into {WITH}
			WITH = " 拥有 ", --if it's only one thing
			AND_THIS_ONE_HAS = ", 这个拥有 ", --if there are multiple, show durability of one
			AND_THIS_ONE_IS = ", 这个拥有 ", --if there are multiple, show durability of one

			--{PERCENT} is acquired from the item's durability

			--Goes into {DURABILITY}
			DURABILITY = " 的耐久度",
			FRESHNESS = " 的新鲜度",
			RECHARGE = " 的费用",

			-- Optionally added into {PERCENT}
			REMAINING = {
				DURABILITY = "剩余 {AMOUNT} 次使用", -- note that this is unused because durability is only published as a percent to clients
				FRESHNESS = "还剩 {AMOUNT} 天", -- note that this is unused because perishables only publish percent to clients
				RECHARGE = "充电 {AMOUNT} 分钟",
			},

			-- Optionally added into {ITEM} or {WITH} for thermal stones.
			HEATROCK = {
				"冻",
				"冷",
				"室温状态",
				"暖",
				"烫",
			}
		},
		ANNOUNCE_RECIPE = {
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "I have a science machine pre-built and ready to place" -> pre-built
			-- "I'll make an axe." -> known and have ingredients
			-- "Can someone make me an alchemy engine? I would need a science machine for it." -> not known
			-- "We need more drying racks." -> known but don't have ingredients
			FORMAT_STRING = "{START_Q}{TO_DO}{THIS_MANY}{S}{ITEM}{PRE_BUILT}{END_Q}{I_NEED}{A_PROTO}{PROTOTYPER}{FOR_IT}。",

			--{START_Q} is for languages that match ? at both ends
			START_Q = "", --English doesn't do that

			--One of these goes into {TO_DO}
			I_HAVE = "我做好了 ", --for pre-built
			ILL_MAKE = "我可以制作 ", --for known recipes where you have ingredients
			CAN_SOMEONE = "有人可以帮我制作 ", --for unknown recipes
			WE_NEED = "我需要制造 ", --for known recipes where you don't have ingredients

			--{THIS_MANY} uses getArticle above to get the right article ("a", "an")

			--{ITEM} comes from the recipe.name

			--{S} uses S above

			--Goes into {PRE_BUILT}
			PRE_BUILT = " 准备建造",

			--This goes into {END_Q} if it's a question
			END_Q = "吗?",

			--Goes into {I_NEED}
			I_NEED = " 我需要 ",

			--Goes into {FOR_IT}
			FOR_IT = " 才能制造它",
		},
		ANNOUNCE_INGREDIENTS = {
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "I need 2 more cut stones and a science machine to make an alchemy engine."
			FORMAT_NEED = "我需要 {NUM_ING} {S}{INGREDIENT}{AND}{A_PROTO}{PROTOTYPER} 来制造 {RECIPE}。",

			--If a prototyper is needed, goes into {AND}
			AND = " 和 ",

			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "I have enough twigs to make 9 bird traps, but I need a science machine."
			FORMAT_HAVE = "我有足够的 {INGREDIENT} 来制造 {A_REC}{REC_S}{RECIPE}{BUT_NEED}{A_PROTO}{PROTOTYPER}。",
			---{A_REC}
			--If a prototyper is needed, goes into {BUT_NEED}
			BUT_NEED = ", 我还需要 ",
		},
		ANNOUNCE_SKIN = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "I have the Tragic Torch skin for the Torch"
			FORMAT_STRING = "我有 {ITEM} 的 {SKIN}。",

			--{SKIN} comes form the skin's name

			--{ITEM} comes from the item's name
		},
		ANNOUNCE_TEMPERATURE = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "I'm at a comfortable temperature"
			-- or "The beast is freezing!"
			FORMAT_STRING = "{PRONOUN}{TEMPERATURE}",

			--{PRONOUN} is picked from this
			PRONOUN = {
				DEFAULT = "我",
				BEAST = "这个怪物是", --for Werebeaver
			},

			--{TEMPERATURE} is picked from this
			TEMPERATURE = {
				BURNING = "要热死啦，快帮我扇扇风！",
				HOT = "感觉好热，想要吃根雪糕！",
				WARM = "有点热。",
				GOOD = "感觉温度很舒适。",
				COOL = "稍微有点冷，要穿厚一点了。",
				COLD = "要冻成冰块了，火炉在哪里？",
				FREEZING = " 已经凝固了，救命！",
			},
		},
		ANNOUNCE_SEASON = "{SEASON}天還有{DAYS_LEFT}天。",
		ANNOUNCE_GIFT = {
			CAN_OPEN = "我有一个礼物，这次一定能出红！",
			NEED_SCIENCE = "我需要科学来打开这个礼物，我觉得我能出红！",
		},
		ANNOUNCE_CIRCUITS = {
			FORMAT_STRING = "{CIRCUITS}: {CHARGED}{SEPARATOR}{UNCHARGED}.",
			FORMAT_STRING_CHARGED = "{CIRCUIT_LIST} ({CHARGE_STATE})",
			FORMAT_STRING_CHIP = "{COUNT} {CIRCUIT_NAME}",
			CIRCUITS = "电路",
			CHARGED = "带电",
			UNCHARGED = "未充电",
			SEPARATOR = "; ",
			GetCircuitName = function(name)
				local s, e = name:find("电路")
				if s == nil then
					-- Fall back to checking if it's untranslated English
					s, e = name:find(" Circuit")
					if s == nil then
						return name
					end
					return name:sub(1, s-1)
				end
				return name:sub(1, s-1)
			end,
		},
		ANNOUNCE_HINT = "宣告",
	},
	-- Everything below is character-specific
	-- 不要修改角色顺序，未翻译角色似乎为mod角色，误删，mod依赖其运行
	UNKNOWN = {
		HUNGER = {
			FULL  = "高于75%..我完全饱了！", 				-- >75%
			HIGH  = "55%..我可以吃一点！！",				-- >55%
			MID   = "35%..我肚子饿瘪了！！！", 				-- >35%
			LOW   = "15%..我非常饿！！！！", 				-- >15%
			EMPTY = "低于15%..我马上要饿扑街了！！！！！", 	-- <15%
		},
		SANITY = {
			FULL  = "高于75%..我的大脑在巅峰状态！", 					-- >75%
			HIGH  = "55%..我感觉还不错！！", 							-- >55%
			MID   = "35%..我有点焦虑！！！", 							-- >35%
			LOW   = "15%..我感觉，这里有点疯狂！！！！", 				-- >15%
			EMPTY = "低于15%..啊哒，好疼！黑色恶魔在追我！！！！",		-- <15%
		},
		HEALTH = {
			FULL  = "100%..我去，血槽满了！", 				-- 100%
			HIGH  = "75%..我挂了一些彩！！", 				-- >75%
			MID   = "50%..我靠，严重挂彩！！！", 			-- >50%
			LOW   = "25%..血肉模糊，我已写好遗书！！！！", 	-- >25%
			EMPTY = "低于25%..看管好我的财产！！！！！", 	-- <25%
		},
		WETNESS = {
			FULL  = "高于75%..完全湿身！！！！！", 					-- >75%
			HIGH  = "55%..我湿透了，哇！背包好隔水我能进去么？",	-- >55%
			MID   = "35%..我很湿！我靠，背包也湿了！！", 			-- >35%
			LOW   = "15%..我只湿了一小块，还不足为惧！", 			-- >15%
			EMPTY = "我有一点点潮湿...", 								-- <15%
		},
		BOAT = {
			FULL  = "这艘船状况良好！",		-- >85%
			HIGH  = "这艘船仍然适航。",			-- >65%
			MID   = "这艘船有点破。",			-- >35%
			LOW   = "这艘船急需修理！",	-- >0.01%
			EMPTY = "这艘船正在沉没！",					-- <0.01%
		},
	},
	WILSON = {    --威尔逊
		HUNGER = {
			FULL  = "我填满了肚子！",
			HIGH  = "我还不缺乏吃的。",
			MID   = "我可以去吃一点儿。",
			LOW   = "我真的饿了！",
			EMPTY = "我。。。 需要。。。 食物。。。",
		},
		SANITY = {
			FULL  = "视理智为还可以。",
			HIGH  = "我会好起来的。",
			MID   = "我的头很痛。。。",
			LOW   = "Wha——那些行走的是什么！？",
			EMPTY = "需要帮助! 这些东西将要吃掉我！！",
		},
		HEALTH = {
			FULL  = "健康的如一把小提琴！",
			HIGH  = "我受伤了，但我可以继续行动。",
			MID   = "我。。。 我想我需要注意治疗。",
			LOW   = "我失去了很多血。。。",
			EMPTY = "我。。。 我将不能走完路程。。。",
		},
		WETNESS = {
			FULL  = "我已经达到了饱和点！",
			HIGH  = "水快滚出去！",
			MID   = "我的衣服几乎渗透。",
			LOW   = "Oh， H2O。",
			EMPTY = "我比较干燥。",
		},
	},
	WILLOW = {    --薇洛
		HUNGER = {
			FULL  = "如果我不停止吃会发胖的。",
			HIGH  = "愉快又饱满的。",
			MID   = "我的生命之火需要一点燃料。",
			LOW   = "Ugh，我要饿死在这里了！",
			EMPTY = "我现在已经饿的几乎皮包骨！",
		},
		SANITY = {
			FULL  = "我认为我现在有充足的精神烧火。",
			HIGH  = "我刚才看到伯尼在行走了么？……没有，不用介意。",
			MID   = "我感觉寒冷无比，我很可能……",
			LOW   = "伯尼，为什么我觉得如此寒冷！？",
			EMPTY = "伯尼，保护我不受那些可怕的事物咬伤！",
		},
		HEALTH = {
			FULL  = "完美的我就应该没有一块伤痕！",
			HIGH  = "我有一两处擦伤。我或许应该点燃它们。",
			MID   = "这些裂口使我不再燃烧，我需要个医生。。。",
			LOW   = "我觉得虚弱……我可能会……熄灭。",
			EMPTY = "我的生命之火几乎要熄灭。。。",
		},
		WETNESS = {
			FULL  = "Ugh，这雨是最——坏——的！",
			HIGH  = "我讨厌这一切水！",
			MID   = "这场雨太多了。",
			LOW   = "Uh oh，如果这场雨持续上升……",
			EMPTY = "没有足够的雨水能灭了火。",
		},
	},
	WOLFGANG = {    --大力士
		HUNGER = {
			FULL  = "沃尔夫冈是充实而强大的!",
			HIGH  = "沃尔夫冈必须吃饱，才能变得更加强大！！",
			MID   = "沃尔夫冈需要吃很多。",
			LOW   = "沃尔夫冈的肚子饿的开洞了。",
			EMPTY = "沃尔夫冈现在急需要食物！！！",
		},
		SANITY = {
			FULL  = "沃尔夫冈的头感觉良好！",
			HIGH  = "沃尔夫冈的头感觉很有趣。",
			MID   = "沃尔夫冈的头很疼",
			LOW   = "沃尔夫冈看到可怕的怪物。。。",
			EMPTY = "到处都是可怕的怪物！！",
		},
		HEALTH = {
			FULL  = "沃尔夫冈现在不需要修理！",
			HIGH  = "沃尔夫冈需要点小修理",
			MID   = "沃尔夫冈受伤了。",
			LOW   = "沃尔夫冈需要很多的绷带来治疗伤口。",
			EMPTY = "沃尔夫冈或许要死了。。。",
		},
		WETNESS = {
			FULL  = "沃尔夫冈现在可能是水做的!",
			HIGH  = "这就像坐在池塘里。。。",
			MID   = "沃尔夫冈不喜欢洗澡。",
			LOW   = "雨水时代。",
			EMPTY = "沃尔夫冈是干燥的。",
		},
	},
	WENDY = {       --温蒂
		HUNGER = {
			FULL  = "再多的食物也不会填补我心中的空洞。",
			HIGH  = "我吃饱了，但仍然渴望一些朋友无法提供的东西。",
			MID   = "我不饿，也不饱。奇怪。",
			LOW   = "我的肚子就像心灵一样充满了空虚。",
			EMPTY = "我发现最慢的死法——饿死。",
		},
		SANITY = {
			FULL  = "我的思维运转地晶莹剔透。",
			HIGH  = "我的思维渐渐变得阴郁。",
			MID   = "我的思维是极度兴奋的……",
			LOW   = "阿比盖尔！你看到它们了么？这些恶魔可能很快能使我加入你。",
			EMPTY = "带我去阿比盖尔那里，黑暗和夜晚的生物！",
		},
		HEALTH = {
			FULL  = "我痊愈了，但我相信我将再次受到伤害。",
			HIGH  = "我感到疼痛，但是不多。",
			MID   = "生存带来了痛苦，但是我不习惯这么多。",
			LOW   = "流了很多血……将会很容易……",
			EMPTY = "我很快将与阿比盖尔……",
		},
		WETNESS = {
			FULL  = "满是水的末世。",
			HIGH  = "长久的湿润和悲伤。",
			MID   = "湿软而又悲伤。",
			LOW   = "或许这些水分能填补我心灵的虚空。",
			EMPTY = "我的皮肤和我的心灵一样干。",
		},
		ABIGAIL = {
			FULL  = "阿比盖尔比以往任何時候都更亮！",
			HIGH  = "阿比盖尔光芒四射。",
			MID   = "阿比盖尔开始衰落……",
			LOW   = "小心點，阿比盖尔！ 我再也見不到你了！",
			EMPTY = "不要离开我，阿比盖尔！",
		},
	},
	WX78 = {        --机器人
		HUNGER = {
			FULL  = "  燃料 状态：最大容量",
			HIGH  = "  燃料 状态：高的 ",
			MID   = "  燃料 状态：中等水平 ",
			LOW   = "  燃料 状态：低水平，请补充燃料 ",
			EMPTY = "  燃料 状态：已耗尽！即将停机 ",
		},
		SANITY = {
			FULL  = "  中央处理器 状态：状态稳定，启动超频",
			HIGH  = "  中央处理器 状态：满频率运行中",
			MID   = "  中央处理器 状态：自动降频",
			LOW   = "  中央处理器 状态：出现逻辑故障",
			EMPTY = "  中央处理器 状态：核心单元已损坏",
		},
		HEALTH = {
			FULL  = "  装甲 状态：装甲完好",
			HIGH  = "  装甲 状态：检测到裂纹",
			MID   = "  装甲 状态：中度损坏",
			LOW   = "  装甲 状态：装甲严重受损",
			EMPTY = "  装甲 状态：装甲完全破损",
		},
		WETNESS = {
			FULL  = "  受潮 状况：机体即将报废",
			HIGH  = "  受潮 状况：电路已短路",
			MID   = "  受潮 状况：装甲已出现锈蚀",
			LOW   = "  受潮 状况：装甲表面有太多水",
			EMPTY = "  受潮 状况：装甲表面沾水",
		},
	},
	WICKERBOTTOM = {    --图书管理员
		HUNGER = {
			FULL  = "我应该从事研究工作，而不是填充自己。",
			HIGH  = "充斥的，但不是臃肿的。",
			MID   = "我感觉到有一点饥饿。",
			LOW   = "这个图书管理员需要食物，我是担心害怕的！",
			EMPTY = "如果我不马上进食，就将会饿死！",
		},
		SANITY = {
			FULL  = "在这里没有什么行为是非理智的。",
			HIGH  = "我相信我有一点令人头痛之事。",
			MID   = "这些偏头痛是难以忍受的。",
			LOW   = "我不确定哪些事物虚构的, 再也不！",
			EMPTY = "帮帮我！这些深不可测又令人可憎的敌人！",
		},
		HEALTH = {
			FULL  = "我的健康可以预计我的年龄!",
			HIGH  = "受一些擦伤，但是无关紧要。",
			MID   = "我的医疗需要装配。",
			LOW   = "如果不治疗，这将是我的结局。",
			EMPTY = "我需要立刻马上就医！",
		},
		WETNESS = {
			FULL  = "完全绝对浸湿！",
			HIGH  = "我是湿的，湿的，湿的！",
			MID   = "我想知道我的最高承受力是 。。。",
			LOW   = "水膜开始形成了 。",
			EMPTY = "我的水分是足够缺乏的。",
		},
	},
	WOODIE = {      --伍迪
		HUMAN = { -- human form
			HUNGER = {
				FULL  = "全部都满了！",
				HIGH  = "对于砍树仍然足够。",
				MID   = "能力需要一个小吃！",
				LOW   = "正餐铃响了! ",
				EMPTY = "我正在挨饿！",
			},
			SANITY = {
				FULL  = "好的犹如一把小提琴曲",
				HIGH  = "还好，可以来一小杯咖啡",
				MID   = "我想我需要一个午睡！",
				LOW   = "退后，噩梦一般的东西！",
				EMPTY = "所有恐惧都是真实的，还有伤害！",
			},
			HEALTH = {
				FULL  = "合适的犹如一个哨子！",
				HIGH  = "大难不死，必有后福。",
				MID   = "可以和使用一些物品来变得健康",
				LOW   = "这是痛苦真正的开始...",
				EMPTY = "让我永眠... 在这颗树下...",
			},
			WETNESS = {
				FULL  = "这鬼天气导致我不能砍树。",
				HIGH  = "因为这些雨水让格子花呢不再保暖。",
				MID   = "我获得了相当的水分。",
				LOW   = "格子花呢很温暖, 也很潮湿。",
				EMPTY = "对我几乎不受影响。",
			},
			["LOG METER"] = {
				FULL  = "一直有更多的木头，但不是在我的肚子里。",
				HIGH  = "我渴望有一个小树枝。",
				MID   = "木头看起来真的很好吃。",
				LOW   = "我能感觉到诅咒即将来临。",
				EMPTY = "一般这个宣告不可能出现，除非没有成功变身",	--(this shouldn't be possible, he'll become a werebeaver)
			},
		},
		WEREBEAVER = {
			-- HUNGER = { -- werebeaver doesn't have hunger
				-- FULL  = "",
				-- HIGH  = "",
				-- MID   = "",
				-- LOW   = "",
				-- EMPTY = "",
			-- },
			SANITY = {
				FULL  = "野兽的眼睛又大又机灵。",
				HIGH  = "野兽似乎看到了黑色的影子。",
				MID   = "野兽回头因为这里有很多不存在的东西。",
				LOW   = "野兽颤抖着,它的眼睛在抽搐。",
				EMPTY = "野兽在咆哮,似乎被倍增的阴影猎杀。",
			},
			HEALTH = {
				FULL  = "野兽蹦蹦跳跳非常活泼。",
				HIGH  = "野兽受到一些擦伤。",
				MID   = "野兽在舔自己的伤口。",
				LOW   = "野兽折断了它的胳膊。",
				EMPTY = "野兽一拐一拐地走着非常可怜。",
			},
			WETNESS = {
				FULL  = "野兽的皮毛完全湿透了。",
				HIGH  = "野兽留下一串小水坑.",
				MID   = "野兽的毛皮有点湿.",
				LOW   = "野兽头上一点水滴.",
				EMPTY = "野兽的毛皮是干燥的.",
			},
			["LOG METER"] = {
				FULL  = "野兽看起来和人类几乎差不多了。",	-- > 90%
				HIGH  = "野兽要咀嚼一个树木。",	-- > 70%
				MID   = "野兽要用力咀嚼一个树枝。",	-- > 50%
				LOW   = "野兽看起来渴望咀嚼那些树。",	-- > 25%
				EMPTY = "野兽看起来很空腹。",	-- < 25%
			},
		},
	},
	WES = {         --韦斯
		HUNGER = {
			FULL  = "*拍拍肚子*",
			HIGH  = "*拍拍肚子*",
			MID   = "*手张开嘴*",
			LOW   = "*手张开嘴,眼睛瞪得大大的*",
			EMPTY = "*紧抓凹陷的胃绝望的一个眼神*",
		},
		SANITY = {
			FULL  = "*行礼*",
			HIGH  = "*翘起姆指*",
			MID   = "*按摩太阳穴*",
			LOW   = "*扫视四处疯狂似地*",
			EMPTY = "*摇篮一样的头,来回摇摆*",
		},
		HEALTH = {
			FULL  = "*手结成心*",
			HIGH  = "*触摸脉搏,竖起大拇指*",
			MID   = "*手在手臂来回移动,示意包扎它*",
			LOW   = "*摇晃手臂*",
			EMPTY = "*大幅摇摆,然后摔倒了*",
		},
		WETNESS = {
			FULL  = "*疯狂地向上游泳*",
			HIGH  = "*向上游泳*",
			MID   = "*悲惨地看向天空*",
			LOW   = "*保护头部武装起来*",
			EMPTY = "*微笑，拿着无形的保护伞*",
		},
	},
	WAXWELL = {     --麦斯威尔
		HUNGER = {
			FULL  = "我已经吃了完美的盛宴。",
			HIGH  = "我很满足，但是不要过量。",
			MID   = "吃个快餐可能很合适。",
			LOW   = "我的内心已经空了。",
			EMPTY = "不！我没有挣到我得到自由将在饿死在这里！",
		},
		SANITY = {
			FULL  = "衣冠楚楚的可以。",
			HIGH  = "我通常坚定的智慧似乎是……摇摆不定。",
			MID   = "啊，我头好痛。",
			LOW   = "我需要明确我的头脑，我开始看到……它们。",
			EMPTY = "救命！这些阴影是真正的野兽，你要知道！",
		},
		HEALTH = {
			FULL  = "我完全安然无恙。",
			HIGH  = "它只是一个擦伤。",
			MID   = "我可能需要给自己打个补丁。",
			LOW   = "这不是我的天鹅之歌，但是我已经接近。",
			EMPTY = "不！我没有逃避而死在这里！",
		},
		WETNESS = {
			FULL  = "湿润的好比水本身。",
			HIGH  = "我不认为我会再次干燥。",
			MID   = "这水会毁了我的西装。",
			LOW   = "潮湿使我变得不整洁。",
			EMPTY = "干燥而整洁的。",
		},
	},
	WEBBER = {      --韦伯
		HUNGER = {
			FULL  = "我们两者的胃部都爆满了。",				-- >75%
			HIGH  = "我们可以再多啃一点。",					-- >55%
			MID   = "我们认为是时候吃午饭了！",			-- >35%
			LOW   = "我们此时会吃妈妈的剩菜……",-- >15%
			EMPTY = "我们的胃是空的！",						-- <15%
		},
		SANITY = {
			FULL  = "我们感觉健康又精力充沛。",							-- >75%
			HIGH  = "小睡一会可以回复一下。",							-- >55%
			MID   = "我们的头好痛...",							-- >35%
			LOW   = "我们上一次有午睡吗？！",	-- >15%
			EMPTY = "我们不害怕你，可怕的东西！",		-- <15%
		},
		HEALTH = {
			FULL  = "我们甚至没有划痕一丝！",				-- 100%
			HIGH  = "我们需要一个创可贴。",				-- >75%
			MID   = "我们需要再贴一个创可贴...",	-- >50%
			LOW   = "我们的身体剧痛...",							-- >25%
			EMPTY = "我们还不想死...",					-- <25%
		},
		WETNESS = {
			FULL  = "哇哈，我们湿透了！", 						-- >75%
			HIGH  = "我们的毛皮被浸泡了！",							-- >55%
			MID   = "我们很湿！", 									-- >35%
			LOW   = "我们湿润地不讨人喜欢。", 					-- >15%
			EMPTY = "我们喜欢在坑里玩耍。", 					-- <15%
		},
	},
	WATHGRITHR = {    --女武神
		HUNGER = {
			FULL  = "我渴望战斗，而不是肉！", 				-- >75%
			HIGH  = "足够满足于战斗。",					-- >55%
			MID   = "我可以有一个肉类零食。", 					-- >35%
			LOW   = "我渴望一场盛宴！", 							-- >15%
			EMPTY = "没有一些肉我就饿死了！", 				-- <15%
		},
		SANITY = {
			FULL  = "我担心没有凡人!", 							-- >75%
			HIGH  = "我在战场上感觉更好！", 					-- >55%
			MID   = "我迷离的思绪……", 							-- >35%
			LOW   = "这些阴影穿过我的矛……", -- >15%
			EMPTY = "退后,黑暗怪兽！", 				-- <15%
		},
		HEALTH = {
			FULL  = "我的皮肤是无懈可击的！", 					-- 100%
			HIGH  = "它只是一个轻伤！", 					-- >75%
			MID   = "我受了伤，但我仍然可以战斗。", 			-- >50%
			LOW   = "没有援助,我很快就会在瓦尔哈拉殿堂……", 	-- >25%
			EMPTY = "我的传奇人生即将谢幕……", 					-- <25%
		},
		WETNESS = {
			FULL  = "我完全湿透了！", 					-- >75%
			HIGH  = "一个战士无法在这雨天战斗！",				-- >55%
			MID   = "我的盔甲会生锈！", 							-- >35%
			LOW   = "这之后我就不需要洗澡了。", 				-- >15%
			EMPTY = "干燥程度足以战斗！", 						-- <15%
		},
		INSPIRATION = {
			FULL  = "我的声音足以唱三首歌！", 			-- >5/6, 3 songs
			HIGH  = "我可以自己唱二重唱！",						-- >3/6, 2 songs
			MID   = "我准备好开始表演了！", 									-- >1/6, 1 song
			LOW   = "让战斗为我润润嗓子！", 	-- <1/6
		},
	},
	WINONA = {        --女工
		HUNGER = {
			FULL = "今天的大餐丰盛无比，我很满足！",
			HIGH = "我觉得我还可以吃更多！",
			MID = "是时候吃个饭休息一下了吧？",
			LOW = "老板，要饿扁了，什么时候开饭？",
			EMPTY = "再不给我点吃的你们将失去一个优秀的员工！",
		},
		SANITY = {
			FULL = "睿智如我，引擎运行状态很完美！",
			HIGH = "引擎的驱动下中枢系统一切如常！",
			MID = "我想我弄丢了几个关键的螺丝钉...",
			LOW = "中枢系统错乱, 我必须去修理好它。",
			EMPTY = "啊！系统崩溃，这真是一个噩梦！说真的！",
		},
		HEALTH = {
			FULL = "强壮如马上的骑兵，冲杀四方！",
			HIGH = "这点小伤就休假，不！我更愿意工作！",
			MID = "我还不能放弃。",
			LOW = "我能退休领养老金安度晚年了吗?",
			EMPTY = "我觉得我的人生该画上完美的句号了...",
		},
		WETNESS = {
			FULL = "潮湿无比，我无法在这样的环境下工作!",
			HIGH = "我的工作服就要湿透了！",
			MID = "这里应该放上“地板湿滑，小心摔倒”的标志牌！",
			LOW = "工作中适度“饮水”有利身心健康。",
			EMPTY = "干燥清爽，不错的工作环境！",
		},
	},
	WARLY = {         --沃利
		HUNGER = {
			FULL  = "我的烹饪将会是我的死亡！", 	-- >75%
			HIGH  = "我想现在我已经受够了。",			-- >55%
			MID   = "是时候在沙漠里吃晚餐了。", 	-- >35%
			LOW   = "我错过了晚饭时间！", 				-- >15%
			EMPTY = "饥饿……是最难受的死亡方式！", 			-- <15%
		},
		SANITY = {
			FULL  = "我的菜肴散发出的美妙香气让我保持清醒。", 			-- >75%
			HIGH  = "我觉得有点头晕。", 				-- >55%
			MID   = "我的脑筋不能转弯了。", 				-- >35%
			LOW   = "窃窃私语……救命啊！", 			-- >15%
			EMPTY = "我再也受不了这种精神错乱了！", 	-- <15%
		},
		HEALTH = {
			FULL  = "我非常健康。", 	-- 100%
			HIGH  = "我切洋葱的时候更糟。", 	-- >75%
			MID   = "我流血了……", 			-- >50%
			LOW   = "我可以使用一些帮助！", 	-- >25%
			EMPTY = "我猜这就是我的结局了，挚友们……", 	-- <25%
		},
		WETNESS = {
			FULL  = "我能感觉到鱼在我的衬衫里游泳。", 	-- >75%
			HIGH  = "水会毁了我完美烹制的菜肴！",					-- >55%
			MID   = "在我感冒之前，我应该把衣服烘干。", 				-- >35%
			LOW   = "这不是洗澡的时间或地点。", 		-- >15%
			EMPTY = "只有几滴在我身上，没有坏处。", 				-- <15%
		},
	},
	WALANI = {
		HUNGER = {
			FULL  = "嗯，那是在天堂做的一顿饭。", 	-- >75%
			HIGH  = "我还可以去吃点小吃。",			-- >55%
			MID   = "食物，食物，食物！", 	-- >35%
			LOW   = "我的肚子会爆炸！", 				-- >15%
			EMPTY = "请……我什么都可以吃！", 			-- <15%
		},
		SANITY = {
			FULL  = "没有什么比冲浪更能让我保持清醒。", 			-- >75%
			HIGH  = "海浪在呼唤我。", 				-- >55%
			MID   = "我的头越来越晕了。", 				-- >35%
			LOW   = "啊~ 我需要我的冲浪板！", 			-- >15%
			EMPTY = "那些是什么……东西！？", 	-- <15%
		},
		HEALTH = {
			FULL  = "从未有如此美好的感觉！", 	-- 100%
			HIGH  = "只有几处划痕，不必大惊小怪的。", 	-- >75%
			MID   = "我可以用一些治疗药膏！", 			-- >50%
			LOW   = "感觉就像我的内心刚刚放弃了我。", 	-- >25%
			EMPTY = "我身上的每一根骨头都断了！", 	-- <25%
		},
		WETNESS = {
			FULL  = "我彻底湿透了！", 	-- >75%
			HIGH  = "我的衣服似乎很湿。",					-- >55%
			MID   = "我可能很快就会需要一条毛巾。", 				-- >35%
			LOW   = "一点点水永远不会使任何人受伤。", 		-- >15%
			EMPTY = "我看到风暴即将来临！", 				-- <15%
		},
	},
	WOODLEGS = {
		HUNGER = {
			FULL  = "哎呀，那真是一顿美餐，女士！", 	-- >75%
			HIGH  = "我的肚子很饱。",			-- >55%
			MID   = "这是我每天吃饭的时间。", 	-- >35%
			LOW   = "是的！ 你们这群蠢货，我哪里来的食物！？", 				-- >15%
			EMPTY = "我快饿死了！", 			-- <15%
		},
		SANITY = {
			FULL  = "是的，大海，她是个美女！", 			-- >75%
			HIGH  = "是时候出海了！", 				-- >55%
			MID   = "想念我的海...", 				-- >35%
			LOW   = "不记得我上次去航海是什么时候了。", 			-- >15%
			EMPTY = "我是一个挥舞着弯刀的海盗船长，而不是一个陆上的笨蛋！", 	-- <15%
		},
		HEALTH = {
			FULL  = "哎呀，我是个难对付的疯子！", 	-- 100%
			HIGH  = "这就是你们得到的全部吗？", 	-- >75%
			MID   = "我还没有放弃！", 			-- >50%
			LOW   = "伍德莱格不是懦夫！", 	-- >25%
			EMPTY = "是！ 你赢了，混蛋！", 	-- <25%
		},
		WETNESS = {
			FULL  = "我的骨头都湿透了！", 	-- >75%
			HIGH  = "我喜欢我的水留在我的船里。",					-- >55%
			MID   = "我的海盗衬衫被水打了。", 				-- >35%
			LOW   = "我的裤子都湿透了！", 		-- >15%
			EMPTY = "哎呀！一场风暴正在酝酿之中。", 				-- <15%
		},
	},
	WILBUR = {
		HUNGER = {
			FULL  = "*跳来跳去拍手*", 	-- >75%
			HIGH  = "*开心地拍手*",			-- >55%
			MID   = "*揉揉肚子*", 	-- >35%
			LOW   = "*悲伤的表情揉肚子*", 				-- >15%
			EMPTY = "OOAOE! *擦得很厉害*", 			-- <15%
		},
		SANITY = {
			FULL  = "*敲敲脑袋*", 			-- >75%
			HIGH  = "*竖起大拇指*", 				-- >55%
			MID   = "*看起来很害怕*", 				-- >35%
			LOW   = "*令人难以忘怀的尖叫*", 			-- >15%
			EMPTY = "OOAOE! OOOAH!", 	-- <15%
		},
		HEALTH = {
			FULL  = "*用双手捶胸*", 	-- 100%
			HIGH  = "*磅胸*", 	-- >75%
			MID   = "*温柔地揉搓缺失的毛皮*", 			-- >50%
			LOW   = "*一瘸一拐*", 	-- >25%
			EMPTY = "OAOOE! OOOOAE!", 	-- <25%
		},
		WETNESS = {
			FULL  = "*打喷嚏*", 	-- >75%
			HIGH  = "*双臂摩擦*",					-- >55%
			MID   = "Ooo! Ooae!", 				-- >35%
			LOW   = "Oooh?", 		-- >15%
			EMPTY = "Ooae Oooh Oaoa! Ooooe.", 				-- <15%
		},
	},
	WORMWOOD = {       --植物人
		HUNGER = {
			FULL  = "腹部填充物过剩！",
			HIGH  = "不需要腹部填充物。",
			MID   = "腹部还可以放得下一些。",
			LOW   = "需要填充物填补腹部空缺。",
			EMPTY = "噢，腹部受损，急需填充物修复...",
		},
		SANITY = {
			FULL  = "我感觉很棒!",
			HIGH  = "精神状态感觉良好。",
			MID   = "头部轻微受损，精神并无大碍。",
			LOW   = "总感觉有恐怖的怪物在盯着我！",
			EMPTY = "啊！有恐怖的怪物在攻击我！",
		},
		HEALTH = {
			FULL  = "沃姆伍德没有受伤！",
			HIGH  = "擦破了点皮。",
			MID   = "感觉有点虚弱。",
			LOW   = "严重受伤！",
			EMPTY = "救命！朋友！",
		},
		WETNESS = {
			FULL  = "真的真的很潮湿！",
			HIGH  = "真的很潮湿！",
			MID   = "感觉有点潮湿。",
			LOW   = "哇！下雨了！",
			EMPTY = "干燥清爽！",
		},
	},
	WURT = {           --小鱼人沃特
		HUNGER = {
			FULL  = "Glurgh，我不要了。",
			HIGH  = "我不饿, florpt。",
			MID   = "我还能吃得下一些。",
			LOW   = "我很需要食物！",
			EMPTY = "我真的很饿很饿！",
		},
		SANITY = {
			FULL  = "好开心！",
			HIGH  = "精神很好, flort。",
			MID   = "Glurgh, 我的头部受伤了。",
			LOW   = "可怕的黑影要过来了！",
			EMPTY = "Glargh, 可怕的噩梦怪物！！",
		},
		HEALTH = {
			FULL  = "我很健康, florpt!",
			HIGH  = "我感觉很好!",
			MID   = "我需要帮助，我的鳞片掉了一些...",
			LOW   = "呜咽，疼得厉害...",
			EMPTY = "救...命...啊！！！",
		},
		WETNESS = {
			FULL  = "啊哈哈，水花溅呀溅！！",
			HIGH  = "我的鳞片很舒服！",
			MID   = "Mermfolk 喜欢水, florp!",
			LOW   = "Ahh... 有点水更好, florp!",
			EMPTY = "太干燥了, glorp.",
		}
	},
	WORTOX = {         --恶魔人
		HUNGER = {
			FULL  = "就不应该吃这么饱，肚子撑的要命！",
			HIGH  = "“魂”足饭饱，去恶作剧吧！Hyuyu!",
			MID   = "需要少量的灵... 如此致命。",
			LOW   = "我想要一个美味的灵魂！恶作剧暂且延后！",
			EMPTY = "我对灵魂的渴望越来越贪婪！",
		},
		SANITY = {
			FULL  = "头脑清醒...欢乐时光即将到来！Hyuyu!",
			HIGH  = "我能吸点灵魂来保持我头脑清醒吗?",
			MID   = "害！刚太跳了，现在有点头痛...",
			LOW   = "我好羡慕这些影子的戏法! Hyuyu!",
			EMPTY = "我的思想处于一个纯粹疯狂的新境界!",
		},
		HEALTH = {
			FULL  = "我现在状态绝佳，可以尽情捣蛋！",
			HIGH  = "只是擦伤，一个灵魂就可以把它修复！",
			MID   = "我需要一些灵魂来抚平这些伤口... Hyuyu!",
			LOW   = "我自己的灵魂开始变得脆弱...",
			EMPTY = "我的灵魂将不再属于我! Hyuyu...",
		},
		WETNESS = {
			FULL  = "我完全湿透了!",
			HIGH  = "我就是这条街最潮湿的恶魔!",
			MID   = "不久的将来这会有一只湿漉漉的恶魔！",
			LOW   = "世界正赐予我一场淋浴!",
			EMPTY = "如果我想保持干燥的话，我应该都留意一下天气！",
		}
	},
	WANDA = {          --旺达
		HUNGER = {
			FULL  = "我需要一段时间来消化这全部！",							-- >75%
			HIGH  = "我仍然从之前吃饱了。或之后。",						-- >55%
			MID   = "我有足够的时间吃点零食休息！", 					-- >35%
			LOW   = "我的胃是它自己流逝的时间！", 						-- >15%
			EMPTY = "如果我现在不吃东西，时间会很快赶上我！", 	-- <15%
		},
		SANITY = {
			FULL  = "这个时间线的一切看起来都这么正常！", 							-- >75%
			HIGH  = "感觉足够宏伟，可以实现一些量子飞跃！",							-- >55%
			MID   = "如果我不带着表，我就不知道现在是什么时间了！",	-- >35%
			LOW   = "现实正在分崩离析！", 											-- >15%
			EMPTY = "你永远也抓不到我！过去、现在或将来！", 					-- <15%
		},
		HEALTH = {
			FULL  = "他们说你的20岁，毕竟是你最好的岁月！",					 	-- 100%
			HIGH  = "仍然年轻，充满活力！", 										-- >75%
			MID   = "等待一声滴答！我需要一点时间来恢复！", 							-- >50%
			LOW   = "我只是需要更多的时间！", 												-- >25%
			EMPTY = "我的沙漏的沙子快要用完了！",					 	-- <25%},
		},
		WETNESS = {
			FULL  = "时间就像雨水，流逝不止！", 								-- >75%
			HIGH  = "如果持续下去，我的怀表就会生锈！",						-- >55%
			MID   = "我有多少年没这么湿了？", 						-- >35%
			LOW   = "哦，打扰！我需要从这场雨中找到一些掩护！", 					-- >15%
			EMPTY = "与旅行的时间复杂性相比，一点点雨算不了什么！", 	-- <15%
		}
	},
	WALTER = {
		HUNGER = {
			FULL  = "松树先锋队员总是饱腹奔跑！", 	-- >75%
			HIGH  = "我应该为我们的下一次徒步旅行准备一份零食。",			-- >55%
			MID   = "我希望我在沃比里打包了一些零食...", 				-- >35%
			LOW   = "我希望我们能吃到更多！", 						-- >15%
			EMPTY = "别担心，姑娘，我们很快就会找到一些肮脏的东西！", 		-- <15%
		},
		SANITY = {
			FULL  = "我的先锋意识比以往任何时候都要好！", 	-- >75%
			HIGH  = "一个故事来缓解紧张气氛怎么样？", 	-- >55%
			MID   = "你也听到了吗 沃比？", 		-- >35%
			LOW   = "嘿，沃比，你看到了吗？！", 			-- >15%
			EMPTY = "我的故事中的怪物是真实存在的！", 	-- <15%
		},
		HEALTH = {
			FULL  = "这里没有瘀伤或蜜蜂叮蛰！", 					-- 100%
			HIGH  = "没有松树先锋无法处理的事情！",		 	-- >75%
			MID   = "我的急救培训即将派上用场！", -- >50%
			LOW   = "沃比应该把我带到安全的地方！", 					-- >25%
			EMPTY = "你可能还要继续，没有我的女孩...", 		-- <25%
		},
		WETNESS = {
			FULL  = "现在我浑身都是褶皱！",					 	-- >75%
			HIGH  = "有没有人记得打包毛巾？",		-- >55%
			MID   = "我所有的徽章都湿透了！", 				-- >35%
			LOW   = "只是一点水！", 					-- >15%
			EMPTY = "我经历过更糟糕的风暴！", 		-- <15%
		}
	},
}