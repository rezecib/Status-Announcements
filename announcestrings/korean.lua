ANNOUNCE_STRINGS = {
	-- These are not character-specific strings, but are here to ease translation
	-- Note that spaces at the beginning and end of these are important and should be preserved
	_ = {
		getArticle = function(name)
			--Korean doesn't have articles, so always return empty string
			return ""
		end,
		--Goes into {S} if there are multiple items (plural)
		-- This isn't perfect for making plural even in English, but it's close enough
		S = "개 ",
		STAT_NAMES = {
			Hunger = "허기",
			Sanity = "정신력",
			Health = "체력",
			Wetness = "습도",
			Boat = "보트",
			["Log Meter"] = "통나무",
			Age = "나이",
			Abigail = "아비게일",
			Inspiration = "영감",
			Might = "힘을",
			--Other mod stats won't have translations, but at least we can support these
		},
		ANNOUNCE_ITEM = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "I have 6 papyrus in this chest."
			-- AFS:
			--  Ex)"상자에 고기 18개 보유 중 - 대상 신선도 86%."
			FORMAT_STRING = "{CONTAINER}{IN_THIS}{ITEM} {THIS_MANY}{S}{I_HAVE}{WITH}{DURABILITY}{PERCENT}.",
			
			-- One of these goes into {I_HAVE}
			I_HAVE = "보유 중",
			WE_HAVE = "보유 중",
			
			-- {THIS_MANY} is a number if multiple, but singular varies a lot by language,
			-- so we use getArticle above to get it
			
			-- {ITEM} is acquired from item.name
			
			-- {S} uses S above
			
			-- Goes into {IN_THIS}, if present
			IN_THIS = "에 ",
			
			-- {CONTAINER} is acquired from container.name
			
			-- One of these goes into {WITH}
			WITH = " - 대상 ", --if it's only one thing
			AND_THIS_ONE_HAS = " - 대상 ", --if there are multiple, show durability of one
			AND_THIS_ONE_IS = " - 대상 ", --if there are multiple, show durability of one
			
			-- {PERCENT} is acquired from the item's durability
			
			-- Goes into {DURABILITY}
			DURABILITY = "내구도 ",
			FRESHNESS = "신선도 ",
			RECHARGE = "충전율 ",
			
			-- Optionally added into {PERCENT}
			REMAINING = {
				DURABILITY = "{AMOUNT}회 사용 가능", -- note that this is unused because durability is only published as a percent to clients
				FRESHNESS = "{AMOUNT}일 사용 가능", -- note that this is unused because perishables only publish percent to clients
				RECHARGE = "{AMOUNT}회 충전됨",
			},
			
			-- Optionally added into {ITEM} or {WITH} for thermal stones.
			HEATROCK = {
				"차가운",
				"시원한",
				"미지근한",
				"따뜻한",
				"뜨거운",
			}
		},
		ANNOUNCE_RECIPE = {
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "I have a science machine pre-built and ready to place" -> pre-built
			-- "I'll make an axe." -> known and have ingredients
			-- "Can someone make me an alchemy engine? I would need a science machine for it." -> not known
			-- "We need more drying racks." -> known but don't have ingredients
			FORMAT_STRING = "{START_Q}{ITEM} {THIS_MANY}{S}{TO_DO}{PRE_BUILT}{END_Q}{FOR_IT}{PROTOTYPER}{I_NEED}.",
			
			--{START_Q} is for languages that match ? at both ends
			START_Q = "", --English doesn't do that AFS: Korean doesn't, too
			
			--One of these goes into {TO_DO}
			I_HAVE = "", --for pre-built
			ILL_MAKE = "제작 예정", --for known recipes where you have ingredients
			CAN_SOMEONE = "제작 요청", --for unknown recipes
			WE_NEED = "더 필요함", --for known recipes where you don't have ingredients
			
			--{THIS_MANY} uses getArticle above to get the right article ("a", "an")
			
			--{ITEM} comes from the recipe.name
			
			--{S} uses S above

			--Goes into {PRE_BUILT}
			PRE_BUILT = "프리빌딩 및 설치 준비 완료",
			
			--This goes into {END_Q} if it's a question
			END_Q = ":",
			
			--Goes into {I_NEED}
			I_NEED = " 필요함",
			
			--Goes into {FOR_IT}
			FOR_IT = " 제작에 ",
		},
		ANNOUNCE_INGREDIENTS = {
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "I need 2 more cut stones and a science machine to make an alchemy engine."
			FORMAT_NEED = "{RECIPE} 제작에 {INGREDIENT} {NUM_ING}{S}{AND}{PROTOTYPER} 필요.",
			
			--If a prototyper is needed, goes into {AND}
			AND = "및 ",
			
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "I have enough twigs to make 9 bird traps, but I need a science machine."
			FORMAT_HAVE = "{RECIPE} 제작할 {INGREDIENT} 충분, 하지만 {PROTOTYPER}{BUT_NEED}.",
			
			--If a prototyper is needed, goes into {BUT_NEED}
			BUT_NEED = " 필요함",
		},
		ANNOUNCE_SKIN = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "I have the Tragic Torch skin for the Torch"
			FORMAT_STRING = "{SKIN}({ITEM} 스킨) 보유 중.",
			
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
				DEFAULT = "",
				BEAST = "짐승이 ", --for Werebeaver
			},
			
			--{TEMPERATURE} is picked from this
			TEMPERATURE = {
				BURNING = "쪄 죽는 중!",
				HOT = "쪄 죽기 직전!",
				WARM = "조금 더움.",
				GOOD = "적당한 온도.",
				COOL = "조금 추움.",
				COLD = "얼어죽기 직전!",
				FREEZING = "얼어죽는 중!",
			},
		},
		ANNOUNCE_SEASON = "{SEASON} 끝나기까지 앞으로 {DAYS_LEFT}일.",
		ANNOUNCE_GIFT = {
			CAN_OPEN = "선물 개봉 가능!",
			NEED_SCIENCE = "선물 개봉하려면 과학 필요!",
		},
		ANNOUNCE_HINT = "안내",
	},
	-- Everything below is character-specific
	UNKNOWN = {
		HUNGER = {
			FULL  = "배가 꽉 찼어!", 	-- >75%
			HIGH  = "배가 많이 찼어.",			-- >55%
			MID   = "좀 출출해.", 	-- >35%
			LOW   = "배고파!", 				-- >15%
			EMPTY = "나 굶어 죽네!", 			-- <15%
		},
		SANITY = {
			FULL  = "머리는 아주 잘 돌아가!", 			-- >75%
			HIGH  = "기분은 나름 괜찮아.", 				-- >55%
			MID   = "좀 긴장이 되는데.", 				-- >35%
			LOW   = "좀 정신 나갈 것 같애!", 			-- >15%
			EMPTY = "끄아아악! 그림자 괴물이야!", 	-- <15%
		},
		HEALTH = {
			FULL  = "완전 건강해!", 	-- 100%
			HIGH  = "좀 긁혔어.", 	-- >75%
			MID   = "다쳤어.", 			-- >50%
			LOW   = "심하게 다쳤어!", 	-- >25%
			EMPTY = "죽기 직전이야!", 	-- <25%
		},
		WETNESS = {
			FULL  = "완전 흠뻑 젖었어!", 	-- >75%
			HIGH  = "물에 절었어!",					-- >55%
			MID   = "너무 축축해!", 				-- >35%
			LOW   = "좀 축축한데.", 		-- >15%
			EMPTY = "뽀송뽀송한 편이야.", 				-- <15%
		},
		BOAT = {
			FULL  = "이 보트는 완벽한 상태입니다!",		-- >85%
			HIGH  = "이 선박은 여전히 ​​항해에 적합합니다.",			-- >65%
			MID   = "이 배는 약간 구타를 당했습니다.",			-- >35%
			LOW   = "이 보트는 긴급 수리가 필요합니다!",	-- >0.01%
			EMPTY = "이 배는 가라앉고 있다!",					-- <0.01%
		},
	},
	WILSON = {
		HUNGER = {
			FULL  = "배가 꽉 찼어!",
			HIGH  = "밥 안 먹어도 되겠어.",
			MID   = "한동안은 안 먹어도 버티겠어.",
			LOW   = "배가 너무 고파!",
			EMPTY = "밥이... 필요해...",
		},
		SANITY = {
			FULL  = "멀쩡함 그 자체야!",
			HIGH  = "난 괜찮아.",
			MID   = "머리가 아파...",
			LOW   = "우왓-- 방금 뭐였지!?",
			EMPTY = "도와줘! 이러다 잡아먹히겠어!!",
		},
		HEALTH = {
			FULL  = "몸 상태는 말끔해!",
			HIGH  = "좀 다치긴 했어도 걸을 순 있어.",
			MID   = "치료... 치료가 필요해.",
			LOW   = "출혈이 심해..",
			EMPTY = "아무래도... 난 가망이 없어.",
		},
		WETNESS = {
			FULL  = "몸이 포화점에 도달했어!",
			HIGH  = "정말 억'수'로 좋구만!",
			MID   = "내 옷은 잘 젖는 것 같아.",
			LOW   = "오, H2O네.",
			EMPTY = "적당히 마른 상태야.",
		},
	},
	WILLOW = {
		HUNGER = {
			FULL  = "계속 먹다가는 살 찌겠어.",
			HIGH  = "배 부르니까 좋아.",
			MID   = "뱃속에 땔감 좀 넣어야겠어.",
			LOW   = "으, 굶어 죽겠네!",
			EMPTY = "이미 배가 등에 달라붙었어!",
		},
		SANITY = {
			FULL  = "일단 불은 여기까지.",
			HIGH  = "방금 버니가 또 걸었나? ... 아냐, 됐어.",
			MID   = "나 갑자기 좀 추운데...",
			LOW   = "버니, 나 왜 이렇게 춥지!?",
			EMPTY = "버니, 저 괴물들 좀 쫓아내 줘!",
		},
		HEALTH = {
			FULL  = "흠집 하나도 없어!",
			HIGH  = "좀 긁히긴 했네. 불로 지지면 돼.",
			MID   = "불로 지져서 될 게 아니고, 의사가 필요해...",
			LOW   = "몸이 무거워... 이러다... 죽겠네.",
			EMPTY = "내 불씨가 꺼지려고 해...",
		},
		WETNESS = {
			FULL  = "으, 비는 정말 최악이야!",
			HIGH  = "난 물이 정말 싫어!",
			MID   = "비가 너무 많이 오는데.",
			LOW   = "이런, 비가 계속 오면 안 되는데...",
			EMPTY = "불도 안 꺼지는 수준의 비야.",
		},
	},
	WOLFGANG = {
		HUNGER = {
			FULL  = "볼프강 배부르고 강력하다!",
			HIGH  = "볼프강 밥 먹고 더 강해져야 한다!",
			MID   = "볼프강 밥 더 먹었으면 좋겠다.",
			LOW   = "볼프강 배에 구멍났다.",
			EMPTY = "볼프강 음식 필요하다! 빨리!",
		},
		SANITY = {
			FULL  = "볼프강 머리 괜찮다!",
			HIGH  = "볼프강 머리 좀 이상하다.",
			MID   = "볼프강 머리 아프다.",
			LOW   = "볼프강 무서운 괴물 보인다...",
			EMPTY = "여기도 저기도 무서운 괴물이야!",
		},
		HEALTH = {
			FULL  = "볼프강 안 고쳐도 된다!",
			HIGH  = "볼프강 좀 고쳐야겠다.",
			MID   = "볼프강 아프다.",
			LOW   = "볼프강 안 아프게 도움이 필요하다.",
			EMPTY = "볼프강 죽을 것 같다...",
		},
		WETNESS = {
			FULL  = "볼프강은 이제 물 덩어리일지도 몰라!",
			HIGH  = "연못에 앉아있는 것 같아.",
			MID   = "볼프강은 목욕 안 좋아한다.",
			LOW   = "젖을 시간이야.",
			EMPTY = "볼프강 물기 없다.",
		},
	},
	WENDY = {
		HUNGER = {
			FULL  = "음식이 아무리 많다 한들 마음의 빈자리는 채울 수는 없어.",
			HIGH  = "배는 부르긴 해도, 친구로는 채울 수 없는 무언가가 부족해.",
			MID   = "배부른 것도, 배고픈 것도 아니야. 이상해.",
			LOW   = "몸이 공허함으로 가득 찼어.",
			EMPTY = "아주 느린 죽음의 방법을 발견했어. 아사 말이야.",
		},
		SANITY = {
			FULL  = "유리구슬처럼 머리가 맑아.",
			HIGH  = "머릿속이 점점 흐려져.",
			MID   = "머릿속에 망상이...",
			LOW   = "보이니, 아비게일? 저 악마들이 날 네 곁으로 보내줄 거야.",
			EMPTY = "칠흑과 암야의 짐승들아, 나를 아비게일 곁으로 보내다오!",
		},
		HEALTH = {
			FULL  = "몸은 건강해. 하지만 언젠가 다치게 되겠지.",
			HIGH  = "좀 아프긴 하지만 괜찮아.",
			MID   = "삶은 고통스러운 거라지만 이런 건 익숙하지 않은데...",
			LOW   = "피 흘려 죽기... 십상이야...",
			EMPTY = "이제 곧 아비게일과 함께야...",
		},
		WETNESS = {
			FULL  = "물의 심판이야!",
			HIGH  = "비와 슬픔의 영원이로다.",
			MID   = "축축하고 슬퍼.",
			LOW   = "혹시 이 비가 내 마음의 빈 자리를 채워줄까.",
			EMPTY = "내 마음만큼이나 피부도 건조해.",
		},
		ABIGAIL = {
			FULL  = "아비게일의 기분이 여느 때보다도 밝아!",
			HIGH  = "아비게일의 미소가 빛나고 있어.",
			MID   = "아비게일이 사라지려고 해...",
			LOW   = "조심해, 아비게일! 이젠 네가 거의 보이질 않아!",
			EMPTY = "가지 말아줘, 아비게일!",
		},
	},
	WX78 = {
		HUNGER = {
			FULL  = "연료 상태: 최대 용량",
			HIGH  = "연료 상태: 고수준",
			MID   = "연료 상태: 허용 가능 수준",
			LOW   = "연료 상태: 저수준",
			EMPTY = "연료 상태: 치명적",
		},
		SANITY = {
			FULL  = "CPU 상태: 이상 없음",
			HIGH  = "CPU 상태: 정상 작동",
			MID   = "CPU 상태: 손상됨",
			LOW   = "CPU 상태: 고장 임박",
			EMPTY = "CPU 상태: 다수의 고장 감지",
		},
		HEALTH = {
			FULL  = "동체 상태: 최적",
			HIGH  = "동체 상태: 균열 발생",
			MID   = "동체 상태: 상당히 손상됨",
			LOW   = "동체 상태: 안정성 저하",
			EMPTY = "동체 상태: 기능 상실",
		},
		WETNESS = {
			FULL  = "수분 상태: 임계치",
			HIGH  = "수분 상태: 준임계치",
			MID   = "수분 상태: 허용 불능",
			LOW   = "수분 상태: 상한치",
			EMPTY = "수분 상태: 허용 가능",
		},
	},
	WICKERBOTTOM = {
		HUNGER = {
			FULL  = "지식을 살찌워야지 뱃살을 찌우면 안 돼.",
			HIGH  = "배부르긴 하지만 배 터질 정도는 아니야.",
			MID   = "아주 약간 시장기가 도는구나.",
			LOW   = "실례지만, 사서에게 음식이 필요해요, 여러분!",
			EMPTY = "당장 식사를 하지 않으면 아사하고 말 게야!",
		},
		SANITY = {
			FULL  = "이성 상실 징후는 없단다.",
			HIGH  = "두통이 좀 있는 게 분명하구나.",
			MID   = "편두통을 참을 수가 없어.",
			LOW   = "더는 상상이 맞는지가 의문이구나!",
			EMPTY = "도와줘! 이해 불가능한 괴물들이 공격해 오는구나!",
		},
		HEALTH = {
			FULL  = "내 나이에 비하면 아주 팔팔하단다!",
			HIGH  = "멍이 좀 들긴 했지만 심한 건 아니란다.",
			MID   = "의료 지원이 점점 필요해지는구나.",
			LOW   = "처치를 받지 않으면 이대로 끝장이야.",
			EMPTY = "당장 의료 지원이 필요해!",
		},
		WETNESS = {
			FULL  = "흠뻑 젖었어!",
			HIGH  = "젖었어, 젖었어, 젖었어!",
			MID   = "내 몸의 포화점은 과연 얼마나 되는 건지...",
			LOW   = "수분층이 형성되기 시작했어.",
			EMPTY = "충분히 수분이 적은 상태란다.",
		},
	},
	WOODIE = {
		HUMAN = {
			HUNGER = {
				FULL  = "배가 꽉 찼어!",
				HIGH  = "아직 나무 할 기운은 나",
				MID   = "새참 좀 먹어야겠네 그래!",
				LOW   = "저녁 좀 먹읍시다!",
				EMPTY = "나 굶어죽네!",
			},
			SANITY = {
				FULL  = "북부전선 이상 없다!",
				HIGH  = "대갈빡 아직 멀쩡해.",
				MID   = "잠 좀 자야겠네 그래!",
				LOW   = "저리 꺼져 이 악몽 녀석들아!",
				EMPTY = "공포는 진짜야! 아픈 것도 진짜야!",
			},
			HEALTH = {
				FULL  = "피리처럼 꼿꼿해!",
				HIGH  = "죽지만 않으면 강해질 뿐이라지.",
				MID   = "좀 건강했으면 좋겠는데.",
				LOW   = "거 참 몸이 안 좋구만...",
				EMPTY = "내가 죽으면... 숲에 묻어줘...",
			},
			WETNESS = {
				FULL  = "나무 베기엔 너무 축축한데.",
				HIGH  = "내 셔츠는 이런 비엔 역부족이야.",
				MID   = "거 참 축축해지는구만 그래.",
				LOW   = "내 셔츠는 젖어도 따뜻하단 말씀.",
				EMPTY = "비 몇 방울 맞는다고 죽나.",
			},
			["LOG METER"] = {
				FULL  = "나무는 많으면 좋긴 한데, 지금은 먹을 건 아니고.",	-- > 90%
				HIGH  = "뭔가 잔가지 같은 게 좀 먹고 싶은데.",						-- > 70%
				MID   = "나무가 점점 맛있어 보이는데.",									-- > 50%
				LOW   = "저주가 일어나는 게 느껴져.",									-- > 25%
				EMPTY = "구왁, 앙?",	-- < 25% (this shouldn't be possible, he'll become a werebeaver)
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
				FULL  = "짐승이 눈을 크게 뜨고 깨어있다.",
				HIGH  = "짐승이 그림자를 보고 눈을 깜빡인다.",
				MID   = "짐승이 존재하지 않는 것에 놀라 고개를 돌린다.",
				LOW   = "짐승이 몸을 떨면서 눈을 둘 곳을 잃었다.",
				EMPTY = "짐승이 으르렁대면서 분열하는 그림자에 쫓기듯이 움직인다.",
			},
			HEALTH = {
				FULL  = "짐승이 힘차고 날쌔게 움직인다.",
				HIGH  = "짐승의 몸에 찰과상이 좀 있다.",
				MID   = "짐승이 상처를 핥는다.",
				LOW   = "짐승이 팔을 부여잡는다.",
				EMPTY = "짐승이 안쓰럽게 절뚝거린다.",
			},
			WETNESS = {
				FULL  = "짐승의 털이 물에 푹 젖었다.",
				HIGH  = "짐승이 물을 질질 흘린다.",
				MID   = "짐승의 털이 조금 젖었다.",
				LOW   = "짐승의 몸에서 물이 떨어진다.",
				EMPTY = "짐승의 털이 말라있다.",
			},
			["LOG METER"] = {
				FULL  = "짐승의 모습이 거의 사람 같다.",				-- > 90%
				HIGH  = "짐승이 입 안 가득 나무를 넣고 씹는다.",		-- > 70%
				MID   = "짐승이 나뭇가지를 와작와작 씹어먹는다.",					-- > 50%
				LOW   = "짐승이 나무를 게걸스럽게 바라본다.",	-- > 25%
				EMPTY = "짐승의 몸이 궁글어 보인다.",						-- < 25%
			},
		},
	},
	WES = {
		HUNGER = {
			FULL  = "*배를 두드린다*",
			HIGH  = "*배를 두드린다*",
			MID   = "*입을 열고 손으로 가리킨다*",
			LOW   = "*눈을 크게 뜨고, 입을 열고 손으로 가리킨다*",
			EMPTY = "*한껏 좌절한 얼굴로 푹 꺼진 배를 손으로 부여잡는다*",
		},
		SANITY = {
			FULL  = "*경례한다*",
			HIGH  = "*엄지를 치켜세운다*",
			MID   = "*관자놀이를 문지른다*",
			LOW   = "*정신 나간 듯 주변을 응시한다*",
			EMPTY = "*머리를 부여잡고 앞뒤로 흔든다*",
		},
		HEALTH = {
			FULL  = "*가슴을 두드린다*",
			HIGH  = "*맥박을 재고는 엄지를 치켜세운다*",
			MID   = "*붕대를 감듯 반대쪽 팔을 따라 손짓한다*",
			LOW   = "*팔을 부여잡는다*",
			EMPTY = "*과장되게 비틀거리다, 픽 쓰러진다*",
		},
		WETNESS = {
			FULL  = "*미친 듯이 위로 헤엄친다*",
			HIGH  = "*위로 헤엄친다*",
			MID   = "*비참하게 하늘을 올려다본다*",
			LOW   = "*팔로 머리를 감싼다*",
			EMPTY = "*웃으면서 투명 우산을 들어보인다*",
		},
	},
	WAXWELL = {
		HUNGER = {
			FULL  = "포식 좀 했군.",
			HIGH  = "배가 좀 차긴 했지만 과하지 않다네.",
			MID   = "간식이 좀 나올 때일 텐데.",
			LOW   = "속이 텅 비었군.",
			EMPTY = "안돼! 굶어 죽으려고 얻은 자유가 아니란 말야!",
		},
		SANITY = {
			FULL  = "아주 멀쩡하다네.",
			HIGH  = "내 지력은 보통 동요할 일이 없건만... 동요하는군.",
			MID   = "윽. 머리가 아파.",
			LOW   = "머리를 좀 식혀야겠군. '그들'이... 보이기 시작했다네.",
			EMPTY = "도와주게! 저 그림자들은 괴물 그 자체잖나!",
		},
		HEALTH = {
			FULL  = "전혀 해를 입지 않았군.",
			HIGH  = "좀 긁힌 상처라네.",
			MID   = "몸을 좀 고쳐야겠군.",
			LOW   = "마지막 무대는 아니지만, 가까워지긴 했어.",
			EMPTY = "안돼! 여기서 죽으려고 탈출한 게 아니란 말야!",
		},
		WETNESS = {
			FULL  = "물 그 자체보다도 더 축축한 것 같군.",
			HIGH  = "다시는 마른 상태로 못 돌아갈 것만 같군.",
			MID   = "물 때문에 내 양복이 망가지겠군ㄴ.",
			LOW   = "말쑥한 게 아니라 막 습하군.",
			EMPTY = "건조하고 말쑥하군.",
		},
	},
	WEBBER = {
		HUNGER = {
			FULL  = "우리 둘 다 배가 꽉 찼어!",				-- >75%
			HIGH  = "한 입만 더 먹었으면 좋겠어.",					-- >55%
			MID   = "점심 먹을 때가 거의 다 됐나 봐!",			-- >35%
			LOW   = "엄마 잔반도 먹고 싶을 판이야...",-- >15%
			EMPTY = "우리 배가 비었어!",						-- <15%
		},
		SANITY = {
			FULL  = "머리가 개운해!",							-- >75%
			HIGH  = "잠 좀 자도 괜찮을 것 같아.",							-- >55%
			MID   = "우리 머리가 아파...",							-- >35%
			LOW   = "우리가 언제 잠을 잤더라?!",	-- >15%
			EMPTY = "우린 안 무서워, 무서운 녀석들아!",		-- <15%
		},
		HEALTH = {
			FULL  = "몸에 생채기 하나 없어!",				-- 100%
			HIGH  = "반창고가 필요하겠어.",				-- >75%
			MID   = "반창고만 가지고는 안 될 것 같아...",	-- >50%
			LOW   = "우리 몸이 아파...",							-- >25%
			EMPTY = "우린 아직 죽기 싫어...",					-- <25%
		},
		WETNESS = {
			FULL  = "와아, 우리 푹 젖었어!", 						-- >75%
			HIGH  = "우리 털이 젖었어!",							-- >55%
			MID   = "우리 젖었어!", 									-- >35%
			LOW   = "기분 나쁘게 눅눅해.", 					-- >15%
			EMPTY = "우린 물웅덩이에서 노는 게 좋아.", 					-- <15%
		},
	},
	WATHGRITHR = {
		HUNGER = {
			FULL  = "고기 말고 전투를 달라!", 				-- >75%
			HIGH  = "전투를 하기 충분하도록 배를 채웠도다.",					-- >55%
			MID   = "고기 간식을 좀 먹었으면 좋겠군.", 					-- >35%
			LOW   = "어서 연회를 했으면 좋겠군!", 							-- >15%
			EMPTY = "고기가 없으면 아사하고 말리라!", 				-- <15%
		},
		SANITY = {
			FULL  = "내가 두려워하는 필멸자는 없다!", 							-- >75%
			HIGH  = "전투에 임하면 기분이 나아지겠지!", 					-- >55%
			MID   = "나의 정신이 동요한다...", 							-- >35%
			LOW   = "그림자가 내 창을 뚫고 지나가는구나...", -- >15%
			EMPTY = "물러서라, 그림자의 괴수들아!", 				-- <15%
		},
		HEALTH = {
			FULL  = "나의 피부는 철갑이다!", 					-- 100%
			HIGH  = "살갗이 좀 찢어졌을 뿐!", 					-- >75%
			MID   = "부상을 입었우나 싸울 수는 있노라.", 			-- >50%
			LOW   = "치료를 받지 못하면 발할라로 가게 되리라...", 	-- >25%
			EMPTY = "나의 여정도 여기서 끝인가...", 					-- <25%
		},
		WETNESS = {
			FULL  = "흠뻑 젖어버렸구나!", 					-- >75%
			HIGH  = "전사가 이리도 젖어서 어찌 싸우겠는가!",				-- >55%
			MID   = "내 갑주가 녹슬겠구나!", 							-- >35%
			LOW   = "목욕을 더 하지는 않아도 되겠군.", 				-- >15%
			EMPTY = "싸울 수 있을 만큼 건조하노라!", 						-- <15%
		},
		INSPIRATION = {
			FULL  = "나의 육성은 세 곡을 감당할 만큼 힘차노니!", 			-- >5/6, 3 songs
			HIGH  = "홀로도 이중창을 부를 수 있겠구나!",						-- >3/6, 2 songs
			MID   = "노래를 부를 준비가 되었노라!", 									-- >1/6, 1 song
			LOW   = "목소리를 가다듬어야 한다... 전장의 열기면 되겠지!", 	-- <1/6
		},
	},
	WINONA = {
		HUNGER = {
			FULL  = "아주 푸짐하게 잘 먹었네.",
			HIGH  = "난 늘 뭐 먹을 배를 따로 남겨놓지!",
			MID   = "지금 점심시간 아닌가?",
			LOW   = "기운 딸리는데요, 사장님.",
			EMPTY = "밥 안 챙겨먹으면 공장에 일손이 모자라겠는데!",
		},
		SANITY = {
			FULL  = "그 어느 때보다도 말짱해.",
			HIGH  = "엔진룸은 이상 무!",
			MID   = "나사가 좀 빠진 것 같은데...",
			LOW   = "내 정신이 망가진 것 같아. 내가 고쳐야겠지.",
			EMPTY = "완전 악몽이네! 하! 그래, 진짜로.",
		},
		HEALTH = {
			FULL  = "야생마처럼 튼튼해!",
			HIGH  = "아, 이 정도 쯤이야.",
			MID   = "아직 포기할 수는 없지.",
			LOW   = "근로연금은 아직인가...?",
			EMPTY = "퇴근할 시간이 됐나 보네...",
		},
		WETNESS = {
			FULL  = "이런 상태로는 일을 할 수가 없잖아!",
			HIGH  = "내 작업복에 물이 고이잖아!",
			MID   = "누가 '미끄럼 주의' 표지판 좀 박아놔 봐.",
			LOW   = "일할 때 수분 보충은 언제나 좋은 법이지.",
			EMPTY = "별 거 아니네.",
		},
	},
	WARLY = {
		HUNGER = {
			FULL  = "하나라도 더 먹었다가는 죽을 거야!", 	-- >75%
			HIGH  = "일단은 먹을 만큼 먹은 것 같아.",			-- >55%
			MID   = "저녁부터 먹고 디저트로 마무리해 보자고.", 	-- >35%
			LOW   = "저녁 먹을 시간을 놓쳤네!", 				-- >15%
			EMPTY = "굶어 죽는다니... 정말 끔찍해!", 			-- <15%
		},
		SANITY = {
			FULL  = "내 요리의 훌륭한 향기가 내 정신을 맑게 해.", 			-- >75%
			HIGH  = "좀 토할 것 같아.", 				-- >55%
			MID   = "생각을 제대로 할 수가 없어.", 				-- >35%
			LOW   = "속삭이잖아... 살려줘!!", 			-- >15%
			EMPTY = "점심나가서먹을것같애!", 	-- <15%
		},
		HEALTH = {
			FULL  = "아주 말끔한 상태야.", 	-- 100%
			HIGH  = "양파 썰 때가 훨씬 아팠을걸.", 	-- >75%
			MID   = "피가 나잖아...", 			-- >50%
			LOW   = "처치가 필요해!", 	-- >25%
			EMPTY = "이젠 끝인 것 같아, 친구...", 	-- <25%
		},
		WETNESS = {
			FULL  = "내 옷 속에서 물고기들이 헤엄치는 것 같아.", 	-- >75%
			HIGH  = "물 때문에 기껏 만든 음식을 망치겠어!",					-- >55%
			MID   = "감기 걸리기 전에 옷을 좀 말려둬야지.", 				-- >35%
			LOW   = "목욕하기 좋은 곳은 아닌데.", 		-- >15%
			EMPTY = "물방울 좀 맞았을 뿐이야.", 				-- <15%
		},
	},
	WALANI = {
		HUNGER = {
			FULL  = "으음, 정말 꿀맛 같은 식사였어.", 	-- >75%
			HIGH  = "간식 먹을 배는 좀 있는데.",			-- >55%
			MID   = "밥, 밥, 밥!", 	-- >35%
			LOW   = "배가 쪼그라들겠어!", 				-- >15%
			EMPTY = "먹을 것 좀... 뭐든 좋으니까!", 			-- <15%
		},
		SANITY = {
			FULL  = "서핑만큼 머리 맑아지는 게 없다니까.", 			-- >75%
			HIGH  = "파도가 나를 부르고 있어.", 				-- >55%
			MID   = "머리가 좀 어지러워.", 				-- >35%
			LOW   = "윽! 내 서핑보드 내놔!", 			-- >15%
			EMPTY = "저것들은... 대체 뭐야?!", 	-- <15%
		},
		HEALTH = {
			FULL  = "이보다 건강할 순 없지.", 	-- 100%
			HIGH  = "좀 긁혔네. 호들갑 떨 거 없어.", 	-- >75%
			MID   = "치료 좀 받았으면 좋겠는데!", 			-- >50%
			LOW   = "마치 몸이 살기를 포기한 것 같아.", 	-- >25%
			EMPTY = "뼈가 마디마디 다 부러졌어!", 	-- <25%
		},
		WETNESS = {
			FULL  = "머리부터 발끝까지 젖었어!", 	-- >75%
			HIGH  = "옷이 좀 많이 젖은 것 같네.",					-- >55%
			MID   = "빨리 수건 좀 있었으면 하는데.", 				-- >35%
			LOW   = "물 좀 묻는다고 나쁠 거 없지.", 		-- >15%
			EMPTY = "폭풍이 오나봐!", 				-- <15%
		},
	},
	WOODLEGS = {
		HUNGER = {
			FULL  = "야앓, 방그믄 아주 맛있었다, 아그야!", 	-- >75%
			HIGH  = "나가 배가 들 고픈가벼.",			-- >55%
			MID   = "끼니 챙겨묵을 때여.", 	-- >35%
			LOW   = "여! 애송이, 내 밥 으딨어!?", 				-- >15%
			EMPTY = "배 곯아 죽것구만!", 			-- <15%
		},
		SANITY = {
			FULL  = "야, 바다 참 이쁘장하구만!", 			-- >75%
			HIGH  = "바다 좀 다녀와야것어!", 				-- >55%
			MID   = "바다에 가고퍼...", 				-- >35%
			LOW   = "은제 또 바다 갔는지도 몰갓어.", 			-- >15%
			EMPTY = "난 칼 든 선장이지, 땅끄지 산적이 아니여!", 	-- <15%
		},
		HEALTH = {
			FULL  = "야앍, 난덜 아주 튼튼혀!", 	-- 100%
			HIGH  = "고작 고거여?", 	-- >75%
			MID   = "나가 포기 못혀!", 			-- >50%
			LOW   = "이 우드렉스 님은 겁쟁이가 아니여!", 	-- >25%
			EMPTY = "아으! 나가 졌다, 애송이!", 	-- <25%
		},
		WETNESS = {
			FULL  = "뼛속까지 물에 쩔었어!", 	-- >75%
			HIGH  = "물은 배 위엔 읎었으면 하는디.",					-- >55%
			MID   = "나으 옷이 젖는구만 그랴.", 				-- >35%
			LOW   = "바지가 젖잖여!", 		-- >15%
			EMPTY = "아앓! 폭풍 올라카구만.", 				-- <15%
		},
	},
	WILBUR = {
		HUNGER = {
			FULL  = "*기쁜 듯 박수를 치며 뛰어다닌다*", 	-- >75%
			HIGH  = "*기쁜 듯 박수를 친다*",			-- >55%
			MID   = "*배를 움켜쥔다*", 	-- >35%
			LOW   = "*애처롭게 배를 움켜쥔다*", 				-- >15%
			EMPTY = "우아우! *배를 움겨쥔다*", 			-- <15%
		},
		SANITY = {
			FULL  = "*머리를 두드린다*", 			-- >75%
			HIGH  = "*엄지를 치켜세운다*", 				-- >55%
			MID   = "*겁 먹은 표정*", 				-- >35%
			LOW   = "*홀린 듯 소리친다*", 			-- >15%
			EMPTY = "우아우! 우우아!", 	-- <15%
		},
		HEALTH = {
			FULL  = "*양 손으로 가슴을 두드린다*", 	-- 100%
			HIGH  = "*가슴을 두드린다*", 	-- >75%
			MID   = "*털 빠진 곳을 살살 문지른다*", 			-- >50%
			LOW   = "*애처롭게 절둑거린다*", 	-- >25%
			EMPTY = "우끼끼! 우우아!", 	-- <25%
		},
		WETNESS = {
			FULL  = "*재채기*", 	-- >75%
			HIGH  = "*팔짱을 낀다*",					-- >55%
			MID   = "우우! 우아!", 				-- >35%
			LOW   = "우끼?", 		-- >15%
			EMPTY = "우끼 우우 오아아! 우끼끼.", 				-- <15%
		},
	},
	WORMWOOD = {
		HUNGER = {
			FULL  = "너무 많아",
			HIGH  = "먹을 거 필요 없어",
			MID   = "배 채울 거 필요해",
			LOW   = "먹는 거 필요해",
			EMPTY = "으으, 배가 아파...",
		},
		SANITY = {
			FULL  = "기분 좋아!",
			HIGH  = "머리 괜찮아",
			MID   = "머리 아파, 기분 괜찮아",
			LOW   = "무서운 거 나 봤어",
			EMPTY = "무서운 거가 때려!",
		},
		HEALTH = {
			FULL  = "안 다쳤어",
			HIGH  = "따갑지만 괜찮아",
			MID   = "약해진 기분",
			LOW   = "엄청 아파",
			EMPTY = "친구들 도와줘!",
		},
		WETNESS = {
			FULL  = "완전완전 젖었어!",
			HIGH  = "완전 젖었어!",
			MID   = "좀 젖은 느낌",
			LOW   = "비 온다! 야호!",
			EMPTY = "마른 느낌",
		},
	},
	WURT = {
		HUNGER = {
			FULL  = "꾸륵, 이제 그만.",
			HIGH  = "배 안 고파, 뽀록.",
			MID   = "좀 더 먹고 싶어.",
			LOW   = "밥 정말 먹고 싶어!",
			EMPTY = "정말정말 배고파!",
		},
		SANITY = {
			FULL  = "가분 아주 좋아!",
			HIGH  = "머리 괜찮아, 뽀록.",
			MID   = "꾸륵, 머리 아파.",
			LOW   = "무서운 그림자 와!",
			EMPTY = "꾸뤠엑! 무서운 악몽이야!",
		},
		HEALTH = {
			FULL  = "기분 아주 좋아, 뽀록!",
			HIGH  = "기분 좋아!",
			MID   = "도움 필욯해, 비늘 몇 개 빠졌어...",
			LOW   = "흑흑... 너무 아파...",
			EMPTY = "도... 와... 줘...",
		},
		WETNESS = {
			FULL  = "아아아, 첨벙, 첨벙!",
			HIGH  = "비늘 느낌 좋아!",
			MID   = "어인들 물 좋아해, 뽀륵!",
			LOW   = "아... 물 기분 좋아, 뽀륵!",
			EMPTY = "너무 말랐어, 꼬륵.",
		}
	},
	WORTOX = {
		HUNGER = {
			FULL  = "이렇게나 많이 먹다니 나도 참 필멸자들 같기는!",
			HIGH  = "재밌는 장난 칠 기운이 쑥쑥! 흐유유!",
			MID   = "밥 한 술만이라도... 필멸자스럽기는.",
			LOW   = "맛있는 영혼이 먹고 싶어! 장난은 좀 나중에...",
			EMPTY = "영혼이 먹고 싶어서 미치겠어!",
		},
		SANITY = {
			FULL  = "머리가 아주 맑아... 재미가 아주 많아! 흐유유!",
			HIGH  = "머리 좀 맑아지게 영혼 좀 흡수해 볼까?",
			MID   = "도약 좀 많이 했더니 머리 좀 많이 아파...",
			LOW   = "그림자들 장난 솜씨 정말 탐나네! 흐유유!",
			EMPTY = "내 마음의 광기는 차원이 다르게 순수하지!",
		},
		HEALTH = {
			FULL  = "말썽 피기 딱 좋은 상태야!",
			HIGH  = "살짝 좀 긁혔네. 영혼이면 다 고치지!",
			MID   = "혼을 좀 바치면 상처가 아물겠지... 흐유유!",
			LOW   = "내 본래의 영혼이 약해지고 있어...",
			EMPTY = "이젠 내 영혼이 내 영혼이 아니겠네! 흐유유...",
		},
		WETNESS = {
			FULL  = "푹 젖었어!",
			HIGH  = "나는 세상에서 제일 축축한 임프다!",
			MID   = "이제 내 앞날엔 임프 젖은내 뿐이야.",
			LOW   = "세상에 나에게 세례를 내려주고 있어!",
			EMPTY = "하늘 위를 잘 봐야지 하늘하늘 털 마르지!",
		}
	},
	WANDA = {
		HUNGER = {
			FULL  = "소화 좀 시킬 시간이 필요해!",							-- >75%
			HIGH  = "방금 먹은 거 때문에 배불러. 있다가 먹었나.",						-- >55%
			MID   = "간식 먹을 시간 정도는 충분해!", 					-- >35%
			LOW   = "내 배가 시간선을 따라가고 있어!", 						-- >15%
			EMPTY = "뭐라도 먹지 않으면 시간에 따라잡히고 말 거야!", 	-- <15%
		},
		SANITY = {
			FULL  = "이 시간대에서는 다 정상이네!", 							-- >75%
			HIGH  = "양자 도약 같은 거 좀 할 정신머리는 돼!",							-- >55%
			MID   = "시계가 없었으면 시간 개념도 까먹었겠어!",	-- >35%
			LOW   = "현실이 무너지고 있어!", 											-- >15%
			EMPTY = "절대 안 잡혀줄 거야! 과거고, 현재고, 미래고!", 					-- <15%
		},
		HEALTH = {
			FULL  = "다들 20대가 제일 꽃다울 나이라지!",					 	-- 100%
			HIGH  = "아직도 젊음의 패기가 느껴져!", 										-- >75%
			MID   = "잠깐만! 회복할 시간이 필요해!", 							-- >50%
			LOW   = "시간이 더 필요해!", 												-- >25%
			EMPTY = "내 인생의 모래시계가 거의 다 됐어!",					 	-- <25%
		},
		WETNESS = {
			FULL  = "시간과 비는 서로 똑같아. 멈출 줄을 모르거든!", 								-- >75%
			HIGH  = "이러다 내 회중시계 다 녹슬겠네!",						-- >55%
			MID   = "내가 이 지경으로 얼마나 오래 있었더라?", 						-- >35%
			LOW   = "염병할! 비 피할 곳을 찾든지 해야지!", 					-- >15%
			EMPTY = "시간 여행이 복잡한 거에 비하면 비 좀 오는 거야 비교도 안 되지!", 	-- <15%
		}
	},
	WALTER = {
		HUNGER = {
			FULL  = "소나무 개척단은 역시 밥심으로 움직이는 법이지!", 	-- >75%
			HIGH  = "다음 하이킹 떄는 간식 좀 챙겨와야지.",			-- >55%
			MID   = "내가 워비 짐에 간식을 쌌었나...", 				-- >35%
			LOW   = "군고구마 좀 먹었으면 좋겠는데!", 						-- >15%
			EMPTY = "다들 걱정 말아요, 금방 먹을 걸 찾을 수 있을 거야!", 		-- <15%
		},
		SANITY = {
			FULL  = "개척단원 정신이 아주 최상의 상태야!", 	-- >75%
			HIGH  = "이야기 좀 들으면서 긴장 푸는 건 어떨까?", 	-- >55%
			MID   = "워비 너도 방금 그 목소리 들었지?", 		-- >35%
			LOW   = "워, 워비? 너도 방금 봤지?!", 			-- >15%
			EMPTY = "이야기 속의 괴물이 진짜였어!!", 	-- <15%
		},
		HEALTH = {
			FULL  = "멍든 데도, 쏘인 데도 없어!", 					-- 100%
			HIGH  = "소나무 개척단원이 극복 못하는 일은 없지!",		 	-- >75%
			MID   = "내 응급처치 훈련이 빛을 발할 때야!", -- >50%
			LOW   = "워비, 나 좀 안전한 곳까지 옮겨줘!", 					-- >25%
			EMPTY = "틀렸어, 난 두고 가...", 		-- <25%
		},
		WETNESS = {
			FULL  = "나 완전 쭈글쭈글해!",					 	-- >75%
			HIGH  = "수건 가져온 사람?",		-- >55%
			MID   = "배지가 다 젖었어!", 				-- >35%
			LOW   = "그냥 물 좀 묻은 거야!", 					-- >15%
			EMPTY = "이것보다 더한 우중 캠핑도 해 봤어!", 		-- <15%
		}
	}
}