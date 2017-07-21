---Intercept characters
function cutchar( str, chbefore, chafter)  
   
    local bparam1, bparam2 = string.find(str, chbefore)
	local aparam1, aparam2 = string.find(str, chafter)
    local be = bparam2 + 1 
    local af = aparam1 - 1
    local result = string.sub(str, be, af)    
    return result  
end 


ANNOUNCE_STRINGS = {
	-- These are not character-specific strings, but are here to ease translation
	-- Note that spaces at the beginning and end of these are important and should be preserved
	_ = {
		getArticle = function(name)
			--This checks if the name starts with a vowel, and uses "an" if so, "a" otherwise
			return "1 个"
		end,
		--Goes into {S} if there are multiple items (plural)
		-- This isn't perfect for making plural even in English, but it's close enough
		S = "个",
		STAT_NAMES = {
			Hunger = "饥饿值",
			Sanity = "脑残值",
			Health = "生命值",
			["Log Meter"] = "日志表",
			Wetness = "雨露值",
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
			
			--{PERCENT} is acquired from the item's durability
			
			--Goes into {DURABILITY}
			DURABILITY = " 的耐久度",
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
			CAN_SOMEONE = "有人可以帮我做 ", --for unknown recipes
			WE_NEED = "我需要制造 ", --for known recipes where you don't have ingredients
			
			--{THIS_MANY} uses getArticle above to get the right article ("a", "an")
			
			--{ITEM} comes from the recipe.name
			
			--{S} uses S above

			--Goes into {PRE_BUILT}
			PRE_BUILT = " 准备放置",
			
			--This goes into {END_Q} if it's a question
			END_Q = "吗?",
			
			--Goes into {I_NEED}
			I_NEED = " 我需要 ",
			
			--{PROTOTYPER} is taken from the recipepopup.teaser:GetString with this function
			getPrototyper = function(teaser)
				--This extracts from sentences like "Use a (science machine) to..." and "Use an (alchemy engine) to..."
				Prototyperstr = teaser:gmatch("<.*>")()
				if Prototyperstr ~= nil then
				    return Prototyperstr
				else 
				    Prototyperstr = teaser:gmatch("需要.*来")()				    
				    Protostr = cutchar(Prototyperstr,"需要","来")
				    return Protostr
				end
			end,
			
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
				BEAST = "这个怪物是 ", --for Werebeaver
			},
			
			--{TEMPERATURE} is picked from this
			TEMPERATURE = {
				BURNING = " 过热了！",
				HOT = " 几乎过热！",
				WARM = " 有点热。",
				GOOD = " 在一个舒适的温度。",
				COOL = " 稍微有点冷。",
				COLD = " 几乎冻结！",
				FREEZING = " “凝固”了！",
			},
		},
		ANNOUNCE_GIFT = {
			CAN_OPEN = "我有一个礼物，我要打开它！",
			NEED_SCIENCE = "我需要额外的科学来打开这个礼物！",
		},
		ANNOUNCE_HINT = "宣告",
	},
	-- Everything below is character-specific
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
	},
	WILSON = {
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
	WILLOW = {
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
	WOLFGANG = {
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
	WENDY = {
		HUNGER = {
			FULL  = "即使再多的食物也不会填补我心中的空洞。",
			HIGH  = "我饱了，但仍渴望没有朋友可以提供的东西。",
			MID   = "我不饿，但也不饱。很奇怪的感觉。",
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
	},
	WX78 = {
		HUNGER = {
			FULL  = "  燃料 状态：最大容量",
			HIGH  = "  燃料 状态：高的 ",
			MID   = "  燃料 状态：合意的 ",
			LOW   = "  燃料 状态：低的 ",
			EMPTY = "  燃料 状态：危险的 ",
		},
		SANITY = {
			FULL  = "  CPU 状态：全面运转",
			HIGH  = "  CPU 状态：功能的",
			MID   = "  CPU 状态：破损的",
			LOW   = "  CPU 状态：故障迫近",
			EMPTY = "  CPU 状态：多重故障检测",
		},
		HEALTH = {
			FULL  = "  底盘 状态：理想状况",
			HIGH  = "  底盘 状态：裂纹检测",
			MID   = "  底盘 状态：中度损坏",
			LOW   = "  底盘 状态：完全性损坏",
			EMPTY = "  底盘 状态：无功能的",
		},
		WETNESS = {
			FULL  = "  受潮 状况：已达临界值",
			HIGH  = "  受潮 状况：接近临界值",
			MID   = "  受潮 状况：无法接受的",
			LOW   = "  受潮 状况：可容许的",
			EMPTY = "  受潮 状况：合意的",
		},
	},
	WICKERBOTTOM = {
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
	WOODIE = {
		{ -- human form
			HUNGER = {
				FULL  = "全部都满了！",
				HIGH  = "对于砍树仍然足够。",
				MID   = "能力需要一个小吃，eh！",
				LOW   = "正餐铃响了! ",
				EMPTY = "我正在挨饿！",
			},
			SANITY = {
				FULL  = "好的犹如一把小提琴曲",
				HIGH  = "还好，可以来一小杯咖啡",
				MID   = "我想我需要一个午睡, eh！",
				LOW   = "退后，噩梦一般的东西！",
				EMPTY = "所有恐惧都是真实的，还有伤害！",
			},
			HEALTH = {
				FULL  = "合适的犹如一个哨子！",
				HIGH  = "大难不死，必有后福, eh？",
				MID   = "可以和使用一些物品来变得健康",
				LOW   = "这是痛苦真正的开始, eh...",
				EMPTY = "让我永眠... 在这颗树下...",
			},
			WETNESS = {
				FULL  = "这鬼天气导致我不能砍树, eh？",
				HIGH  = "因为这些雨水让格子花呢不再保暖。",
				MID   = "我获得了相当的水分, eh？",
				LOW   = "格子花呢很温暖, 也很潮湿。",
				EMPTY = "对我几乎不受影响, eh？",
			},
			["伐木"] = {	
				FULL  = "一直有更多的木头，但不是在我的肚子里，eh？",
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
			["伐木"] = {
				FULL  = "野兽看起来和人类几乎差不多了。",	-- > 90%
				HIGH  = "野兽要咀嚼一个树木。",	-- > 70%
				MID   = "野兽要用力咀嚼一个树枝。",	-- > 50%
				LOW   = "野兽看起来渴望咀嚼那些树。",	-- > 25%
				EMPTY = "野兽看起来很空腹。",	-- < 25%
			},
		},
	},
	WES = {
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
	WAXWELL = {
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
			MID   = "Ugh，我头好痛。",
			LOW   = "我需要明确我的头脑，我开始看到……它们。",
			EMPTY = "Help！这些阴影是真正的野兽，你要知道！",
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
	WEBBER = {
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
	WATHGRITHR = {
		HUNGER = {
			FULL  = "我渴望战斗，无需肉！", 				-- >75%
			HIGH  = "我足够满足于战斗。",					-- >55%
			MID   = "我可以有一个肉类零食。", 					-- >35%
			LOW   = "我渴望一场盛宴！", 							-- >15%
			EMPTY = "没有一些肉我就饿死了！", 				-- <15%
		},
		SANITY = {
			FULL  = "我担心没有凡人!", 							-- >75%
			HIGH  = "我会在战场上感觉更好！", 					-- >55%
			MID   = "我迷离的思绪……", 							-- >35%
			LOW   = "这些阴影穿过我的矛……", -- >15%
			EMPTY = "退后,黑暗怪兽！", 				-- <15%
		},
		HEALTH = {
			FULL  = "我的皮肤是无懈可击的！", 					-- 100%
			HIGH  = "它只是一个轻伤！", 					-- >75%
			MID   = "我受伤了，但我还能战斗。", 			-- >50%
			LOW   = "没有援助,我很快就会在瓦尔哈拉殿堂……", 	-- >25%
			EMPTY = "我的传奇人生即将结束……", 					-- <25%
		},
		WETNESS = {
			FULL  = "我完全湿透了！", 					-- >75%
			HIGH  = "一个战士在这雨天无法战斗！",				-- >55%
			MID   = "我的护甲会生锈！", 							-- >35%
			LOW   = "我不需要洗澡。", 				-- >15%
			EMPTY = "干澡够了继续战斗！", 						-- <15%
		},
	},
	WARLY = {
		HUNGER = {
			FULL  = "My cooking will be the death of me!", 	-- >75%
			HIGH  = "I think I've had enough, for now.",			-- >55%
			MID   = "Time for dinner with a side of desert.", 	-- >35%
			LOW   = "I missed dinner time!", 				-- >15%
			EMPTY = "Starvation... the worst death!", 			-- <15%
		},
		SANITY = {
			FULL  = "The excellent aroma of my dishes keep me sane.", 			-- >75%
			HIGH  = "I feel a bit woozy.", 				-- >55%
			MID   = "I can't think straight.", 				-- >35%
			LOW   = "The whispers... help me!", 			-- >15%
			EMPTY = "I can't take any more of this insanity!", 	-- <15%
		},
		HEALTH = {
			FULL  = "I'm perfectly fit.", 	-- 100%
			HIGH  = "I've had worse when chopping onions.", 	-- >75%
			MID   = "I'm bleeding...", 			-- >50%
			LOW   = "I could use some aid!", 	-- >25%
			EMPTY = "Guess this is the end, old friend...", 	-- <25%
		},
		WETNESS = {
			FULL  = "I can feel the fishes swimming in my shirt.", 	-- >75%
			HIGH  = "Water will ruin my perfectly cooked dishes!",					-- >55%
			MID   = "I should dry my clothes before I catch a cold.", 				-- >35%
			LOW   = "This is not the time or place for a bath.", 		-- >15%
			EMPTY = "Just a few drops on me, no harm.", 				-- <15%
		},
	},
	WALANI = {
		HUNGER = {
			FULL  = "Mmmm, that was a meal made in heaven.", 	-- >75%
			HIGH  = "I could still go for a snack.",			-- >55%
			MID   = "Food, food, food!", 	-- >35%
			LOW   = "My stomach will implode!", 				-- >15%
			EMPTY = "Please... anything to eat!", 			-- <15%
		},
		SANITY = {
			FULL  = "Nothing like surfing to keep me sane.", 			-- >75%
			HIGH  = "The waves are calling to me.", 				-- >55%
			MID   = "My head is getting dizzy.", 				-- >35%
			LOW   = "Ugh! I need my surfboard!", 			-- >15%
			EMPTY = "What are those... THINGS?!", 	-- <15%
		},
		HEALTH = {
			FULL  = "Never felt better.", 	-- 100%
			HIGH  = "A few scratches, no big fuss.", 	-- >75%
			MID   = "I could use some healing!", 			-- >50%
			LOW   = "Feels like my insides just gave up on me.", 	-- >25%
			EMPTY = "Every bone in my body is broken!", 	-- <25%
		},
		WETNESS = {
			FULL  = "I am thoroughly soaked!", 	-- >75%
			HIGH  = "My clothes seem to be quite wet.",					-- >55%
			MID   = "I might need a towel soon.", 				-- >35%
			LOW   = "A little water never hurt anyone.", 		-- >15%
			EMPTY = "I see a storm coming!", 				-- <15%
		},
	},
	WOODLEGS = {
		HUNGER = {
			FULL  = "Yarr, that was a fine meal, laddy!", 	-- >75%
			HIGH  = "I be pretty full on me belly.",			-- >55%
			MID   = "Tis time for me daily meal.", 	-- >35%
			LOW   = "Aye! Ye scallywags, where be me food!?", 				-- >15%
			EMPTY = "I be starvin' to death!", 			-- <15%
		},
		SANITY = {
			FULL  = "Aye, the sea, she's a beaut!", 			-- >75%
			HIGH  = "Time for a trip on the sea!", 				-- >55%
			MID   = "I miss me sea...", 				-- >35%
			LOW   = "Can't remember thar last time I went sailing.", 			-- >15%
			EMPTY = "I'm a cutlass wielding pirate captain, not a land lubber!", 	-- <15%
		},
		HEALTH = {
			FULL  = "Yarr, I be a tough nut to crack!", 	-- 100%
			HIGH  = "Is that all ye got?", 	-- >75%
			MID   = "I arn't giving up yet!", 			-- >50%
			LOW   = "Woodlegs arn't no chicken!", 	-- >25%
			EMPTY = "Arr! You win, scallywag!", 	-- <25%
		},
		WETNESS = {
			FULL  = "Me soaked to th' bones!", 	-- >75%
			HIGH  = "I likes me water to stay 'neath me boat.",					-- >55%
			MID   = "Me pirate blouse be takin' on water.", 				-- >35%
			LOW   = "Me britches be soaked!", 		-- >15%
			EMPTY = "Arr! A storm be brewing.", 				-- <15%
		},
	},
	WILBUR = {
		HUNGER = {
			FULL  = "*hops around clapping his hands*", 	-- >75%
			HIGH  = "*claps hands happily*",			-- >55%
			MID   = "*rubs his belly*", 	-- >35%
			LOW   = "*sad look and rubs belly*", 				-- >15%
			EMPTY = "OOAOE! *rubs helly*", 			-- <15%
		},
		SANITY = {
			FULL  = "*knocks on head*", 			-- >75%
			HIGH  = "*gives thumbs up*", 				-- >55%
			MID   = "*looks scared*", 				-- >35%
			LOW   = "*screams hauntingly*", 			-- >15%
			EMPTY = "OOAOE! OOOAH!", 	-- <15%
		},
		HEALTH = {
			FULL  = "*pounds chest with both hands*", 	-- 100%
			HIGH  = "*pounds chest*", 	-- >75%
			MID   = "*tenderly rubs missing patches of fur*", 			-- >50%
			LOW   = "*limps miserably*", 	-- >25%
			EMPTY = "OAOOE! OOOOAE!", 	-- <25%
		},
		WETNESS = {
			FULL  = "*sneezes*", 	-- >75%
			HIGH  = "*rubs arms together*",					-- >55%
			MID   = "Ooo! Ooae!", 				-- >35%
			LOW   = "Oooh?", 		-- >15%
			EMPTY = "Ooae Oooh Oaoa! Ooooe.", 				-- <15%
		},
	},
}