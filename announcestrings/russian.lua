ANNOUNCE_STRINGS = {
	-- These are not character-specific strings, but are here to ease translation
	-- Note that spaces at the beginning and end of these are important and should be preserved
	_ = {
		getArticle = function(name)
			--This checks if the name starts with a vowel, and uses "" if so, "" otherwise
			return ""
		end,
		--Goes into {S} if there are multiple items (plural)
		-- This isn't perfect for making plural even in English, but it's close enough
		S = "",
		STAT_NAMES = {
			Hunger = "Голод",
			Sanity = "Рассудок",
			Health = "Здоровье",
			Wetness = "Влажность",
			Boat = "Лодка",
			["Log Meter"] = "Бревно метр",
			Age = "возраст",
			Abigail = "Абигейл",
			Inspiration = "Вдохновение",
			Might = "мощь",
			--Other mod stats won't have translations, but at least we can support these
		},
		ANNOUNCE_ITEM = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "I have 6 papyrus in this chest."
			FORMAT_STRING = "{I_HAVE}{THIS_MANY} {ITEM}{S}{IN_THIS}{CONTAINER}{WITH}{PERCENT}{DURABILITY}.",
			
			--One of these goes into {I_HAVE}
			I_HAVE = "У меня есть ",
			WE_HAVE = "У нас есть ",
			
			--{THIS_MANY} is a number if multiple, but singular varies a lot by language,
			-- so we use getArticle above to get it
			
			--{ITEM} is acquired from item.name
			
			--{S} uses S above
			
			--Goes into {IN_THIS}, if present
			IN_THIS = " на них ",
			
			--{CONTAINER} is acquired from container.name
			
			--One of these goes into {WITH}
			WITH = " на нём ", --if it's only one thing
			AND_THIS_ONE_HAS = ", на них ", --if there are multiple, show durability of one
			AND_THIS_ONE_IS = ", и этот ", --if there are multiple, show durability of one
			
			--{PERCENT} is acquired from the item's durability
			
			--Goes into {DURABILITY}
			DURABILITY = " прочности",
			FRESHNESS = " свежесть",
			RECHARGE = " зарядом",
			
			-- Optionally added into {PERCENT}
			REMAINING = {
				DURABILITY = "Осталось {AMOUNT} использований", -- note that this is unused because durability is only published as a percent to clients
				FRESHNESS = "осталось {AMOUNT} дней", -- note that this is unused because perishables only publish percent to clients
				RECHARGE = "{AMOUNT} до подзарядки",
			},
			
			-- Optionally added into {ITEM} or {WITH} for thermal stones.
			HEATROCK = {
				"замороженный",
				"холодно",
				"комнатная температура",
				"тепло",
				"горячий",
			}
		},
		ANNOUNCE_RECIPE = {
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "I have a science machine pre-built and ready to place" -> pre-built
			-- "I'll make an axe." -> known and have ingredients
			-- "Can someone make me an alchemy engine? I would need a science machine for it." -> not known
			-- "We need more drying racks." -> known but don't have ingredients
			FORMAT_STRING = "{START_Q}{TO_DO}{THIS_MANY} {ITEM}{S}{PRE_BUILT}{END_Q}{I_NEED}{A_PROTO}{PROTOTYPER}{FOR_IT}.",
			
			--{START_Q} is for languages that match ? at both ends
			START_Q = "", --English doesn't do that
			
			--One of these goes into {TO_DO}
			I_HAVE = "I have ", --for pre-built
			ILL_MAKE = "I'll make ", --for known recipes where you have ingredients
			CAN_SOMEONE = "Can someone make me ", --for unknown recipes
			WE_NEED = "We need more", --for known recipes where you don't have ingredients
			
			--{THIS_MANY} uses getArticle above to get the right article ("a", "an")
			
			--{ITEM} comes from the recipe.name
			
			--{S} uses S above

			--Goes into {PRE_BUILT}
			PRE_BUILT = " pre-built and ready to place",
			
			--This goes into {END_Q} if it's a question
			END_Q = "?",
			
			--Goes into {I_NEED}
			I_NEED = " I would need ",
			
			--Goes into {FOR_IT}
			FOR_IT = " for it",
		},
		ANNOUNCE_INGREDIENTS = {
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "I need 2 more cut stones and a science machine to make an alchemy engine."
			FORMAT_NEED = "I need {NUM_ING} more {INGREDIENT}{S}{AND}{A_PROTO}{PROTOTYPER} to make {A_REC} {RECIPE}.",
			
			--If a prototyper is needed, goes into {AND}
			AND = " and ",
			
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "I have enough twigs to make 9 bird traps, but I need a science machine."
			FORMAT_HAVE = "I have enough {INGREDIENT}{ING_S} to make {A_REC} {RECIPE}{REC_S}{BUT_NEED}{A_PROTO}{PROTOTYPER}.",
			
			--If a prototyper is needed, goes into {BUT_NEED}
			BUT_NEED = ", but I need ",
		},
		ANNOUNCE_SKIN = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "I have the Tragic Torch skin for the Torch"
			FORMAT_STRING = "I have the {SKIN} skin for the {ITEM}.",
			
			--{SKIN} comes form the skin's name
			
			--{ITEM} comes from the item's name
		},
		ANNOUNCE_TEMPERATURE = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "I'm at a comfortable temperature"
			-- or "The beast is freezing!"
			FORMAT_STRING = "{PRONOUN} {TEMPERATURE}",
			
			--{PRONOUN} is picked from this
			PRONOUN = {
				DEFAULT = "",
				BEAST = "Зверь", --for Werebeaver
			},
			
			--{TEMPERATURE} is picked from this
			TEMPERATURE = {
				BURNING = "Я перегрелся!",
				HOT =  "Я почти перегрелся!",
				WARM = "Мне немного жарко",
				GOOD = "Я нахожусь в комфортной температуре.",
				COOL = "Мне немного холодно.",
				COLD = "Мне очень холодно!",
				FREEZING = "Я переохладился!",
			},
		},
		ANNOUNCE_SEASON = "{SEASON} осталось {DAYS_LEFT} дня.",
		ANNOUNCE_GIFT = {
			CAN_OPEN = "У меня есть подарок, и я собираюсь его открыть!",
			NEED_SCIENCE = "Мне нужна наука, чтобы открыть этот подарок!",
		},
		ANNOUNCE_HINT = "Announce",
	},
	-- Everything below is character-specific
	UNKNOWN = {
		HUNGER = {
			FULL  = "I'm completely stuffed!", 	-- >75%
			HIGH  = "I'm pretty full.",			-- >55%
			MID   = "I'm getting peckish.", 	-- >35%
			LOW   = "I'm hungry!", 				-- >15%
			EMPTY = "I'm starving!", 			-- <15%
		},
		SANITY = {
			FULL  = "My brain is in peak condition!", 			-- >75%
			HIGH  = "I'm feeling pretty good.", 				-- >55%
			MID   = "I'm getting a bit anxious.", 				-- >35%
			LOW   = "I'm feeling a bit crazy, here!", 			-- >15%
			EMPTY = "AAAAHHHH! Stay back, beasts of shadow!", 	-- <15%
		},
		HEALTH = {
			FULL  = "I'm in perfect health!", 	-- 100%
			HIGH  = "I'm a bit scratched up.", 	-- >75%
			MID   = "I'm wounded.", 			-- >50%
			LOW   = "I'm grievously wounded!", 	-- >25%
			EMPTY = "I'm mortally wounded!", 	-- <25%
		},
		WETNESS = {
			FULL  = "I'm completely drenched!", 	-- >75%
			HIGH  = "I'm soaked!",					-- >55%
			MID   = "I'm too wet!", 				-- >35%
			LOW   = "I'm getting a bit wet.", 		-- >15%
			EMPTY = "I'm quite dry.", 				-- <15%
		},
		BOAT = {
			FULL  = "Лодка в идеальном состоянии!",		-- >85%
			HIGH  = "Это судно все еще мореходно.",			-- >65%
			MID   = "Этот корабль немного потрепан.",			-- >35%
			LOW   = "Лодка срочно нуждается в ремонте!",	-- >0.01%
			EMPTY = "Этот корабль тонет!",					-- <0.01%
		},
	},
	WILSON = {
		HUNGER = {
			FULL  = "Я полон!",
			HIGH  = "Я не нуждаюсь в еде",
			MID   = "Я мог бы немного поесть",
			LOW   = "Я голоден",
			EMPTY = "Мне...нужна...еда!",
		},
		SANITY = {
			FULL  = "Я в здравом уме!",
			HIGH  = "Я буду в порядке.",
			MID   = "Моя голова болит...",
			LOW   = "Чт - что происходит !?",
			EMPTY = "Помогите! Эти штуки съедят меня !!",
		},
		HEALTH = {
			FULL  = "Как огурчик!",
			HIGH  = "Мне больно, но я могу продолжать.",
			MID   = "Я ... Мне кажется, мне нужна медицинский осмотр.",
			LOW   = "Я потерял так много крови...",
			EMPTY = "Я ... Я не собираюсь это делать ...",
		},
		WETNESS = {
			FULL  = "Я С головы до ног пропитался водой!",
			HIGH  = "Водяной путь!",
			MID   = "Моя одежда кажется не водонепроницаемой",
			LOW   = "Ох, H2O.",
			EMPTY = "Я практически сухой",
		},
	},
	WILLOW = {
		HUNGER = {
			FULL  = "Я растолстею, если не перестану есть.",
			HIGH  = "Приятно сыта.",
			MID   = "Моему огню нужно немного топлива.",
			LOW   = "Ух, я начинаю умираю с голоду!",
			EMPTY = "Я уже практически кожа да кости!",
		},
		SANITY = {
			FULL  = "Думаю, у меня было достаточно огня сегодня.",
			HIGH  = "Я только что видела, как Берни ходит? ... нет, не важно.",
			MID   = "Мне холоднее, чем следовало бы...",
			LOW   = "Берни, почему мне так холодно!?",
			EMPTY = "Берни, спаси меня от этих ужасных вещей!",
		},
		HEALTH = {
			FULL  = "На мне ни единой царапины!",
			HIGH  = "У меня царапина или две. Наверное, мне надо прижечь их.",
			MID   = "Эти раны невозможно прижечь, мне нужен  доктор...",
			LOW   = "Я чувствую слабость... Я могу... умереть...",
			EMPTY = "Мой огонь почти почти погас...",
		},
		WETNESS = {
			FULL  = "Угх, этот дождь - ХУДШЕЕ!",
			HIGH  = "Я не люблю всю эту воду!",
			MID   = "Этот дождь слишком сильный.",
			LOW   = "Ох, если этот дождь не прекратится...",
			EMPTY = "Недостаточно дождя что бы потушить огонь.",
		},
	},
	WOLFGANG = {
		HUNGER = {
			FULL  = "Вольфганг полон и могуч!",
			HIGH  = "Вольфганг должен поесть и стать ещё сильнее!",
			MID   = "Вольфганг мог бы есть больше.",
			LOW   = "У Вольфганга отверстие в животе.",
			EMPTY = "Вольфгангу нужна еда! Сейчас же!",
		},
		SANITY = {
			FULL  = "У Вольфганга хорошо с головой!",
			HIGH  = "Голова Вольфганга смешная!",
			MID   = "Голова Вольфганга болит",
			LOW   = "Вольфганг видит страшного монстра...",
			EMPTY = "Страшные монстры везде!",
		},
		HEALTH = {
			FULL  = "Вольфганг не нуждается в лечении!",
			HIGH  = "Вольфгангу нужно немного подлечиться.",
			MID   = "Вольфганг ранен..",
			LOW   = "Вольфгангу нужна много помощи, чтобы не чувствовать боли",
			EMPTY = "Вольфганг может умереть...",
		},
		WETNESS = {
			FULL  = "Вольфганг, может быть, теперь сделан из воды!",
			HIGH  = "Это как сидеть в пруду.",
			MID   = "Вольфганг не любит время ванны.",
			LOW   = "Водное время",
			EMPTY = "Вольфганг сухой.",
		},
	},
	WENDY = {
		HUNGER = {
			FULL  = "Никакое количество пищи не заполнит дыру в моем сердце.",
			HIGH  = "Я полна, но все еще жаждую чего-то, чего ни один друг не может предоставить.",
			MID   = "Я не пустая, но не полная. Странно.",
			LOW   = "Я полна пустоты.",
			EMPTY = "Я нашла самый медленный способ умереть. Голодание.",
		},
		SANITY = {
			FULL  = "Мои мысли кристально чисты.",
			HIGH  = "Мои мысли затуманиваются.",
			MID   = "Мои мысли лихорадочны...",
			LOW   = "Ты их видишь,Абигейл?Эти демоны могут позволить мне присоединиться к тебе,в ближайшее время",
			EMPTY = "Отведите меня к Абигейл, творения тьмы и ночи!",
		},
		HEALTH = {
			FULL  = "Я в порядке, но я уверена, что мне снова будет больно.",
			HIGH  = "Я чувствую боль, но небольшую",
			MID   = "Жизнь приносит боль, но я к этому не привыкла.",
			LOW   = "Истекаю кровью... было бы легко...",
			EMPTY = "Я скоро буду с Абигейл...",
		},
		WETNESS = {
			FULL  = "Апокалипсис воды!",
			HIGH  = "Дождь и печаль",
			MID   = "Мокрая и грустная.",
			LOW   = "Возможно, эта вода заполнит дыру в моем сердце.",
			EMPTY = "Моя кожа такая же сухая, как и мое сердце.",
		},
		ABIGAIL = {
			FULL  = "Эбигейл ярче, чем когда-либо!",
			HIGH  = "Абигейл ярко светится.",
			MID   = "Абигейл начинает увядать ...",
			LOW   = "Будь осторожна, Эбигейл! Я тебя больше не вижу!",
			EMPTY = "Не оставляй меня, Эбигейл!",
		},
	},
	WX78 = {
		HUNGER = {
			FULL  = "СОСТОЯНИЕ ТОПЛИВА: МАКСИМАЛЬНАЯ ЗАПОЛНЕНОСТЬ",
			HIGH  = "СОСТОЯНИЕ ТОПЛИВА: ВЫСОКОЕ",
			MID   = "СОСТОЯНИЕ ТОПЛИВА: ДОПУСТИМОЕ",
			LOW   = "СОСТОЯНИЕ ТОПЛИВА: МАЛО",
			EMPTY = "СОСТОЯНИЕ ТОПЛИВА: КРИТИЧНО",
		},
		SANITY = {
			FULL  = "СОСТОЯНИЕ CPU : ПОЛНАЯ ЭКСПЛУАТАЦИЯ",
			HIGH  = "СОСТОЯНИЕ CPU : ФУНКЦИОНИРУЕТ",
			MID   = "СОСТОЯНИЕ CPU : ПОВРЕЖДЕН",
			LOW   = "СОСТОЯНИЕ CPU : СБОЙ НЕИЗБЕЖЕН",
			EMPTY = "СОСТОЯНИЕ CPU : МНОЖЕСТВО НЕИСПРАВНОСТЕЙ ЗАМЕЧЕНО",
		},
		HEALTH = {
			FULL  = "СОСТОЯНИЕ КОРПУСА: ОТЛИЧНОЕ СОСТОЯНИЕ",
			HIGH  = "СОСТОЯНИЕ КОРПУСА: ОБНАРУЖЕНА ТРЕЩИНА",
			MID   = "СОСТОЯНИЕ КОРПУСА: СРЕДНЕЕ ПОВРЕЖДЕНИЕ",
			LOW   = "СОСТОЯНИЕ КОРПУСА: СБОЙ ЦЕЛОСТНОСТИ",
			EMPTY = "СОСТОЯНИЕ КОРПУСА: НЕФУНКЦИОНИРУЮЩЕЕ",
		},
		WETNESS = {
			FULL  = "СОСТОЯНИЕ ВЛАГИ: КРИТИЧЕСКОЕ",
			HIGH  = "СОСТОЯНИЕ ВЛАГИ: ПОЧТИ КРИТИЧЕСКОЕ",
			MID   = "СОСТОЯНИЕ ВЛАГИ: НЕПРИЕМЛИМОЕ",
			LOW   = "СОСТОЯНИЕ ВЛАГИ: ДОПУСТИМОЕ",
			EMPTY = "СОСТОЯНИЕ ВЛАГИ: ПРИЕМЛИМОЕ",
		},
	},
	WICKERBOTTOM = {
		HUNGER = {
			FULL  = "Я должена заниматься исследованиями, а не набивать себя едой.",
			HIGH  = "Сыта, но не сильно",
			MID   = "Я немного проголодалась",
			LOW   = "Боюсь, библиотекарю нужна еда!",
			EMPTY = "Если я не получу еду немедленно, я буду голодать!",
		},
		SANITY = {
			FULL  = "Здесь нет ничего необоснованного.",
			HIGH  = "Кажется, у меня немного разболелась голова.",
			MID   = "Эти мигрени невыносимы.",
			LOW   = "Я больше не уверена, что эти вещи воображаемые!",
			EMPTY = "Помогите! Эти непостижимые мерзости враждебны!",
		},
		HEALTH = {
			FULL  = "Я в хорошей форме, как и следовало ожидать для моего возраста!",
			HIGH  = "Несколько синяков, но ничего серьезного.",
			MID   = "Мои медицинские потребности растут.",
			LOW   = "Без лечения, это будет конец для меня.",
			EMPTY = "Мне нужна немедленная медицинский осмотр!",
		},
		WETNESS = {
			FULL  = "Насквозь промокла!",
			HIGH  = "Я мокрая, мокрая, мокрая!",
			MID   = "Интересно, какова точка насыщения моего тела...",
			LOW   = "Слой воды начинает накапливаться.",
			EMPTY = "Я достаточно лишена влаги.",
		},
	},
	WOODIE = {
		HUMAN = {
			HUNGER = {
				FULL  = "Все в порядке!",
				HIGH  = "Ещё рано...",
				MID   = "Наверное, нужно перекусить, а?",
				LOW   = "Кольцо обеденного звонка!",
				EMPTY = "Я голоден!",
			},
			SANITY = {
				FULL  = "Все хорошо на Северном фронте!",
				HIGH  = "Все еще прекрасно в ноггине.",
				MID   = "Я думаю, мне нужен сон, а!",
				LOW   = "Мне мерещатся какие то звери, а?",
				EMPTY = "Все мои страхи реальны и опасны!",
			},
			HEALTH = {
				FULL  = "Подходите как свисток!",
				HIGH  = "То, что тебя не убивает, делает тебя сильнее, а?",
				MID   = "Можно использовать немного здоровья.",
				LOW   = "Это действительно начинает болеть, а ...",
				EMPTY = "Поставьте меня отдохнуть ... в лес ...",
			},
			WETNESS = {
				FULL  = "Слишком влажно даже что бы рубить, а?",
				HIGH  = "Пледа нехватит для такого дождя.",
				MID   = "Я становлюсь очень мокрым, а?",
				LOW   = "Плед теплый, даже когда он мокрый.",
				EMPTY = "Едва ли капля на меня, а?",
			},
			["LOG METER"] = {
				FULL  = "Всегда можно было бы иметь больше бревен,а?",	-- > 90%
				HIGH  = "Я жажду чего-то странного.",						-- > 70%
				MID   = "Бревна выглядят довольно вкусно.",									-- > 50%
				LOW   = "Я чувствую, как надвигается проклятие.",									-- > 25%
				EMPTY = "Что, а?",	-- < 25% (this shouldn't be possible, he'll become a werebeaver)
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
				FULL  = "The beast's eyes are wide and alert.",
				HIGH  = "The beast blinks at the shadows.",
				MID   = "The beast turns to look at something that isn't there.",
				LOW   = "The beast's shaking and his eyes are twitching.",
				EMPTY = "The beast growls and appears to be being hunted by the multiplying shadows.",
			},
			HEALTH = {
				FULL  = "The beast scampers vigorously.",
				HIGH  = "The beast has a few scratches.",
				MID   = "The beast licks its wounds.",
				LOW   = "The beast cradles its arm.",
				EMPTY = "The beast limps pathetically.",
			},
			WETNESS = {
				FULL  = "The beast's fur is completely soaked.",
				HIGH  = "The beast leaves a trail of small puddles.",
				MID   = "The beast's fur is a bit wet.",
				LOW   = "The beast drips a little.",
				EMPTY = "The beast's fur is dry.",
			},
			["LOG METER"] = {
				FULL  = "The beast looks almost human.",				-- > 90%
				HIGH  = "The beast chews on a mouthful of wood.",		-- > 70%
				MID   = "The beast munches on a twig.",					-- > 50%
				LOW   = "The beast looks ravenously at those trees.",	-- > 25%
				EMPTY = "The beast looks hollow.",						-- < 25%
			},
		},
	},
	WES = {
		HUNGER = {
			FULL  = "*гладит живот*",
			HIGH  = "*гладит живот*",
			MID   = "*показывает рукой на открытый рот*",
			LOW   = "*показывает рукой на рот, глаза открыты широко*",
			EMPTY = "*показывает рукой на урчащий живот*",
		},
		SANITY = {
			FULL  = "*приветствует*",
			HIGH  = "*показывает класс*",
			MID   = "*потирает веки*",
			LOW   = "*судорожно поглядывает вокруг*",
			EMPTY = "*качает головой, раскачиваясь вперёд и назад*",
		},
		HEALTH = {
			FULL  = "*гладит сердце*",
			HIGH  = "*чувствует пульс,палец вверх*",
			MID   = "*крутит руку вокруг другой, как будто её перевязывает*",
			LOW   = "*гладит руку*",
			EMPTY = "*драматично качается, затем падает*",
		},
		WETNESS = {
			FULL  = "*лихорадочно плывет вверх*",
			HIGH  = "*плывет вверх*",
			MID   = "*грустно смотрит на небо*",
			LOW   = "*делает руками крышу*",
			EMPTY = "*улыбается, держа невидимый зонт*",
		},
	},
	WAXWELL = {
		HUNGER = {
			FULL  = "У меня был настоящий праздник.",
			HIGH  = "Я сыт, но не до избытка.",
			MID   = "Может, закуска будет?",
			LOW   = "Внутри меня ничего не осталось.",
			EMPTY = "Нет! Я заслужил свою свободу не для того, чтобы голодать здесь!",
		},
		SANITY = {
			FULL  = "Щеголь, как может быть.",
			HIGH  = "Мой обычный непоколебимый интеллект кажется ... колеблющимся.",
			MID   = "Нгх. Моя голова болит.",
			LOW   = "Мне нужно очистить голову, я начинаю видеть ... Их.",
			EMPTY = "Помогите! Эти тени - настоящие звери, знаете ли!",
		},
		HEALTH = {
			FULL  = "Я совершенно невредим.",
			HIGH  = "Это просто царапина.",
			MID   = "Мне нужно привести себя в порядок.",
			LOW   = "Это не моя лебединая песня, но я рядом.",
			EMPTY = "Нет! Я сбежал не для того, чтобы умереть здесь!",
		},
		WETNESS = {
			FULL  = "Лучше, чем сама вода.",
			HIGH  = "Не думаю, что когда-нибудь буду сухой снова.",
			MID   = "Эта вода испортит мой костюм.",
			LOW   = "Сырость это не щеголь.",
			EMPTY = "Сухой и влажный.",
		},
	},
	WEBBER = {
		HUNGER = {
			FULL  = "Оба наших желудка полны!",				-- >75%
			HIGH  = "Мы могли бы поесть еще немного.",					-- >55%
			MID   = "Мы думаем, что пришло время обеда!",			-- >35%
			LOW   = "Мы бы съели мамины объедки в этот момент...",-- >15%
			EMPTY = "Наши животики пусты!",						-- <15%
		},
		SANITY = {
			FULL  = "Мы чувствуем себя хорошо отдохнувшими!",							-- >75%
			HIGH  = "Не помешает вздремнуть.",							-- >55%
			MID   = "Наша голова болит...",							-- >35%
			LOW   = "Когда мы в последний раз спали?!",	-- >15%
			EMPTY = "Мы не боимся вас, страшные твари!",		-- <15%
		},
		HEALTH = {
			FULL  = "На нас ни царапины!",				-- 100%
			HIGH  = "Нам скоро понадобится пластырь.",				-- >75%
			MID   = "Нам понадобится больше, чем пластырь...",	-- >50%
			LOW   = "Наше тело болит...",							-- >25%
			EMPTY = "Мы ещё не хотим умирать...",					-- <25%
		},
		WETNESS = {
			FULL  = "Вааа, мы промокли до нитки!", 						-- >75%
			HIGH  = "Наш мех промокла насквозь!",							-- >55%
			MID   = "Мы мокрые!", 									-- >35%
			LOW   = "Мы неприятно промокли.", 					-- >15%
			EMPTY = "Мы любим играть в лужицах.", 					-- <15%
		},
	},
	WATHGRITHR = {
		HUNGER = {
			FULL  = "Я жажду битвы, а не мяса!", 				-- >75%
			HIGH  = "Я достаточно сыта для битвы.",					-- >55%
			MID   = "Я могла бы перекусить мясом.", 					-- >35%
			LOW   = "Я жажду пиршества!", 							-- >15%
			EMPTY = "Я буду голодать без мяса!", 				-- <15%
		},
		SANITY = {
			FULL  = "Я не боюсь смертных!", 							-- >75%
			HIGH  = "Я буду чувствовать себя лучше в сражении!", 					-- >55%
			MID   = "Мой разум блуждает...", 							-- >35%
			LOW   = "Эти тени проходят сквозь мое копье...", -- >15%
			EMPTY = "Держитесь подальше, звери тьмы!", 				-- <15%
		},
		HEALTH = {
			FULL  = "Моя кожа непроницаема!", 					-- 100%
			HIGH  = "Это всего лишь поверхностная рана!", 					-- >75%
			MID   = "Я ранена, но я все могу ещё сражаться.", 			-- >50%
			LOW   = "Без оказания помощи я скоро окажусь в Вальхалле ...", 	-- >25%
			EMPTY = "Моя эпопея достигает конца...", 					-- <25%
		},
		WETNESS = {
			FULL  = "Я полностью промокла!", 					-- >75%
			HIGH  = "Воин, с которым мы не можем сражаться!",				-- >55%
			MID   = "Мои доспехи будут ржаветь!", 							-- >35%
			LOW   = "Мне не понадобится ванна после этого.", 				-- >15%
			EMPTY = "Достаточно сухая для битвы!", 						-- <15%
		},
		INSPIRATION = {
			FULL  = "Мой голос достаточно силен для трех песен!", 			-- >5/6, 3 songs
			HIGH  = "Мог бы сам спеть дуэтом!",						-- >3/6, 2 songs
			MID   = "Я готов петь!", 									-- >1/6, 1 song
			LOW   = "Я должен согреть свой голос ... в пылу битвы!", 	-- <1/6
		},
	},
	WINONA = {
		HUNGER = {
			FULL  = "Я уже получила свой обед на день.",
			HIGH  = "У меня всегда есть немного места для жрачки!",
			MID   = "Могу ли я взять перерыв на обед?",
			LOW   = "У меня заканчивается топливо, босс..",
			EMPTY = "На фабрике будет не хватать рабочего, если я не получу немного жратвы!",
		},
		SANITY = {
			FULL  = "Настолько в уме, насколько это возможно.",
			HIGH  = "Все хорошо под капотом!",
			MID   = "Кажется, у меня пара болтов потерялось...",
			LOW   = "Мой разум сломан, я должена быть тем, кто это исправит.",
			EMPTY = "Это просто кошмар какой-то! Ха! Точно-точно.",
		},
		HEALTH = {
			FULL  = "Я здорова, как лошадь!",
			HIGH  = "Эх, я буду работать над этим.",
			MID   = "Я не могу пока что сдаваться",
			LOW   = "Могу ли я получить свою пенсию уже...?",
			EMPTY = "Думаю, моя смена закончилась...",
		},
		WETNESS = {
			FULL  = "Я не могу работать в таких условиях!",
			HIGH  = "Мой комбинезон набирает воду!",
			MID   = "Кто-то должен повесить табличку с мокрым полом.",
			LOW   = "Всегда хорошо оставаться гидратированным во время работы.",
			EMPTY = "Это ничего.",
		},
	},
	--[[
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
			LOW   = "*looks sad and rubs belly*", 				-- >15%
			EMPTY = "OOAOE! *rubs belly*", 			-- <15%
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
	},]]
}