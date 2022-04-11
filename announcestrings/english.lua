ANNOUNCE_STRINGS = {
	-- These are not character-specific strings, but are here to ease translation
	-- Note that spaces at the beginning and end of these are important and should be preserved
	_ = {
		getArticle = function(name)
			--This checks if the name starts with a vowel, and uses "an" if so, "a" otherwise
			return string.find(name, "^[aeoiuAOIEU]") ~= nil and "an" or "a"
		end,
		--Goes into {S} if there are multiple items (plural)
		-- This isn't perfect for making plural even in English, but it's close enough
		S = "s",
		STAT_NAMES = {
			Hunger = "Hunger",
			Sanity = "Sanity",
			Health = "Health",
			["Log Meter"] = "Log Meter",
			Wetness = "Wetness",
			Age = "Age",
			Boat = "Boat",
			Abigail = "Abigail",
			Inspiration = "Inspiration",
			--Other mod stats won't have translations, but at least we can support these
		},
		ANNOUNCE_ITEM = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "I have 6 papyrus in this chest."
			FORMAT_STRING = "{I_HAVE}{THIS_MANY} {ITEM}{S}{IN_THIS}{CONTAINER}{WITH}{PERCENT}{DURABILITY}.",

			-- One of these goes into {I_HAVE}
			I_HAVE = "I have ",
			WE_HAVE = "We have ",

			-- {THIS_MANY} is a number if multiple, but singular varies a lot by language,
			-- so we use getArticle above to get it

			-- {ITEM} is acquired from item.name

			-- {S} uses S above

			-- Goes into {IN_THIS}, if present
			IN_THIS = " in this ",

			-- {CONTAINER} is acquired from container.name

			-- One of these goes into {WITH}
			WITH = " with ", --if it's only one thing
			AND_THIS_ONE_HAS = ", and this one has ", --if there are multiple, show durability of one
			AND_THIS_ONE_IS = ", and this one is ", --if there are multiple, show durability of one

			-- {PERCENT} is acquired from the item's durability

			-- Goes into {DURABILITY}
			DURABILITY = " durability",
			FRESHNESS = " freshness",
			RECHARGE = " charge",

			-- Optionally added into {PERCENT}
			REMAINING = {
				DURABILITY = "{AMOUNT} uses left", -- note that this is unused because durability is only published as a percent to clients
				FRESHNESS = "{AMOUNT} days left", -- note that this is unused because perishables only publish percent to clients
				RECHARGE = "{AMOUNT} until charged",
			},

			-- Optionally added into {ITEM} or {WITH} for thermal stones.
			HEATROCK = {
				"frozen",
				"cold",
				"room-temperature",
				"warm",
				"hot",
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
				DEFAULT = "I'm",
				BEAST = "The beast is", --for Werebeaver
			},

			--{TEMPERATURE} is picked from this
			TEMPERATURE = {
				BURNING = "overheating!",
				HOT = "almost overheating!",
				WARM = "a little bit hot.",
				GOOD = "at a comfortable temperature.",
				COOL = "a little bit cold.",
				COLD = "almost freezing!",
				FREEZING = "freezing!",
			},
		},
		ANNOUNCE_SEASON = "There are {DAYS_LEFT} days left in {SEASON}.",
		ANNOUNCE_GIFT = {
			CAN_OPEN = "I have a gift and I'm about to open it!",
			NEED_SCIENCE = "I require additional science to open this gift!",
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
			FULL  = "Pretty healthy!",
			HIGH  = "Not tooo bad?",
			MID   = "Ahh, be careful.",
			LOW   = "Help!",
			EMPTY = "󰂡", -- :angri: from DST Nitro
		}
	},
	WILSON = {
		HUNGER = {
			FULL  = "I'm stuffed!",
			HIGH  = "I don't need to eat.",
			MID   = "I could go for a bit to eat.",
			LOW   = "I'm really hungry!",
			EMPTY = "I... need... food...",
		},
		SANITY = {
			FULL  = "As sane as can be!",
			HIGH  = "I'll be fine.",
			MID   = "My head hurts...",
			LOW   = "Wha-- what's going on!?",
			EMPTY = "Help! Those things are gonna eat me!!",
		},
		HEALTH = {
			FULL  = "Fit as a fiddle!",
			HIGH  = "I'm hurt, but I can keep going.",
			MID   = "I... I think I need medical attention.",
			LOW   = "I've lost so much blood...",
			EMPTY = "I'm... I'm not going to make it...",
		},
		WETNESS = {
			FULL  = "I've reached my saturation point!",
			HIGH  = "Water way to go!",
			MID   = "My clothes appear to be permeable.",
			LOW   = "Oh, H2O.",
			EMPTY = "I'm moderately dry.",
		},
	},
	WILLOW = {
		HUNGER = {
			FULL  = "I'll get fat if I don't stop eating.",
			HIGH  = "Pleasantly full.",
			MID   = "My fire needs a little fuel.",
			LOW   = "Ugh, I'm starving over here!",
			EMPTY = "I'm practically skin and bones already!",
		},
		SANITY = {
			FULL  = "I think I've had enough fire for now.",
			HIGH  = "Did I just see Bernie walk? ... no, never mind.",
			MID   = "I feel colder than I should...",
			LOW   = "Bernie, why do I feel so cold!?",
			EMPTY = "Bernie, protect me from those horrible things!",
		},
		HEALTH = {
			FULL  = "Not a scratch on me!",
			HIGH  = "I have a scratch or two. I should probably burn them.",
			MID   = "These gashes are beyond burning, I need a doctor...",
			LOW   = "I feel weak... I might... die.",
			EMPTY = "My fire is almost out...",
		},
		WETNESS = {
			FULL  = "Ugh, this rain is the WORST!",
			HIGH  = "I hate all this water!",
			MID   = "This rain is too much.",
			LOW   = "Uh oh, if this rain keeps up...",
			EMPTY = "Not enough rain to put out the fire.",
		},
	},
	WOLFGANG = {
		HUNGER = {
			FULL  = "Wolfgang is full and mighty!",
			HIGH  = "Wolfgang must eat and become more mighty!",
			MID   = "Wolfgang could eat more.",
			LOW   = "Wolfgang has hole in belly.",
			EMPTY = "Wolfgang need food! NOW!",
		},
		SANITY = {
			FULL  = "Wolfgang feel good in head!",
			HIGH  = "Wolfgang head feel funny.",
			MID   = "Wolfgang head hurt",
			LOW   = "Wolfgang see scary monster...",
			EMPTY = "Scary monsters everywhere!",
		},
		HEALTH = {
			FULL  = "Wolfgang not need fixing!",
			HIGH  = "Wolfgang need little fixing.",
			MID   = "Wolfgang hurt.",
			LOW   = "Wolfgang need much help to not feel hurt.",
			EMPTY = "Wolfgang might die...",
		},
		WETNESS = {
			FULL  = "Wolfgang is maybe now made of water!",
			HIGH  = "It is like sitting in pond.",
			MID   = "Wolfgang does not like bath time.",
			LOW   = "Water time.",
			EMPTY = "Wolfgang is dry.",
		},
	},
	WENDY = {
		HUNGER = {
			FULL  = "No amount of food will fill the hole in my heart.",
			HIGH  = "I am full, yet still hungry for something that no friend can provide.",
			MID   = "I am not empty, but not full. Strange.",
			LOW   = "I am full of emptiness.",
			EMPTY = "I have found the slowest way to die. Starvation.",
		},
		SANITY = {
			FULL  = "My thoughts run crystal clear.",
			HIGH  = "My thoughts grow murky.",
			MID   = "My thoughts are feverish...",
			LOW   = "Do you see them, Abigail? These demons may let me join you, soon.",
			EMPTY = "Take me to Abigail, creatures of darkness and night!",
		},
		HEALTH = {
			FULL  = "I am well, but I'm sure I'll get hurt again.",
			HIGH  = "I feel pain, but not much.",
			MID   = "Life brings pain, but I am not used to this much.",
			LOW   = "Bleeding out... would be easy...",
			EMPTY = "I'll be with Abigail, soon...",
		},
		WETNESS = {
			FULL  = "An apocalypse of water!",
			HIGH  = "An eternity of moisture and sorrow.",
			MID   = "Soggy and sad.",
			LOW   = "Maybe this water will fill the hole in my heart.",
			EMPTY = "My skin is as dry as my heart.",
		},
		ABIGAIL = {
			FULL  = "Abigail is brighter than ever!",
			HIGH  = "Abigail shines brightly.",
			MID   = "Abigail is beginning to fade...",
			LOW   = "Be careful, Abigail! I can hardly see you anymore!",
			EMPTY = "Don't leave me, Abigail!",
		},
	},
	WX78 = {
		HUNGER = {
			FULL  = "FUEL STATUS: MAXIMUM CAPACITY",
			HIGH  = "FUEL STATUS: HIGH",
			MID   = "FUEL STATUS: ACCEPTABLE",
			LOW   = "FUEL STATUS: LOW",
			EMPTY = "FUEL STATUS: CRITICAL",
		},
		SANITY = {
			FULL  = "CPU STATUS: FULLY OPERATIONAL",
			HIGH  = "CPU STATUS: FUNCTIONAL",
			MID   = "CPU STATUS: DAMAGED",
			LOW   = "CPU STATUS: FAILURE IMMINENT",
			EMPTY = "CPU STATUS: MULTIPLE FAILURES DETECTED",
		},
		HEALTH = {
			FULL  = "CHASSIS STATUS: PERFECT CONDITION",
			HIGH  = "CHASSIS STATUS: CRACK DETECTED",
			MID   = "CHASSIS STATUS: MODERATE DAMAGE",
			LOW   = "CHASSIS STATUS: INTEGRITY FAILING",
			EMPTY = "CHASSIS STATUS: NONFUNCTIONAL",
		},
		WETNESS = {
			FULL  = "MOISTURE STATUS: CRITICAL",
			HIGH  = "MOISTURE STATUS: NEAR CRITICAL",
			MID   = "MOISTURE STATUS: UNACCEPTABLE",
			LOW   = "MOISTURE STATUS: TOLERABLE",
			EMPTY = "MOISTURE STATUS: ACCEPTABLE",
		},
	},
	WICKERBOTTOM = {
		HUNGER = {
			FULL  = "I should be doing research, not stuffing myself.",
			HIGH  = "Filled, but not bloated.",
			MID   = "I'm feeling a tad peckish.",
			LOW   = "This librarian needs food, I'm afraid!",
			EMPTY = "If I don't get food immediately, I will starve!",
		},
		SANITY = {
			FULL  = "Nothing unreasonable going on here.",
			HIGH  = "I do believe I have a bit of a headache.",
			MID   = "These migraines are unbearable.",
			LOW   = "I'm not sure those things are imaginary, anymore!",
			EMPTY = "Help! These unfathomable abominations are hostile!",
		},
		HEALTH = {
			FULL  = "I'm as fit as can be expected for my age!",
			HIGH  = "A few bruises, but nothing major.",
			MID   = "My medical needs are mounting.",
			LOW   = "Without treatment, this will be the end of me.",
			EMPTY = "I require immediate medical attention!",
		},
		WETNESS = {
			FULL  = "Positively soaked!",
			HIGH  = "I'm wet, wet, wet!",
			MID   = "I wonder what my body's saturation point is...",
			LOW   = "The layer of water begins to build up.",
			EMPTY = "I am sufficiently devoid of moisture.",
		},
	},
	WOODIE = {
		HUMAN = {
			HUNGER = {
				FULL  = "All full up!",
				HIGH  = "Still full enough to chop.",
				MID   = "Might need a snack, eh!",
				LOW   = "Ring the dinner bell!",
				EMPTY = "I'm starving!",
			},
			SANITY = {
				FULL  = "All good on the Northern front!",
				HIGH  = "Still fine in the noggin.",
				MID   = "I think I need a nap, eh!",
				LOW   = "Take off ya nightmarish hosers!",
				EMPTY = "All of me fears are real, and hurt!",
			},
			HEALTH = {
				FULL  = "Fit as a whistle!",
				HIGH  = "What doesn't kill you makes you stronger, eh?",
				MID   = "Could use a bit of healthiness.",
				LOW   = "That's really starting to hurt, eh...",
				EMPTY = "Put me to rest... in the woods...",
			},
			WETNESS = {
				FULL  = "Far too wet even to chop, eh?",
				HIGH  = "Plaid's not enough for this kind of rain.",
				MID   = "I'm getting quite wet, eh?",
				LOW   = "Plaid's warm, even when wet.",
				EMPTY = "Hardly a drop on me, eh?",
			},
			["LOG METER"] = {
				FULL  = "Could always have more logs, but not in my belly just now, eh?",	-- > 90%
				HIGH  = "I've got a hankering for something twiggy.",						-- > 70%
				MID   = "Logs are looking pretty tasty.",									-- > 50%
				LOW   = "I can feel the curse coming on.",									-- > 25%
				EMPTY = "Mraw, eh?",	-- < 25% (this shouldn't be possible, he'll become a werebeaver)
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
			FULL  = "*pats stomach*",
			HIGH  = "*pats stomach*",
			MID   = "*brings hand to open mouth*",
			LOW   = "*brings hand to open mouth, eyes wide*",
			EMPTY = "*clutches sunken stomach with a look of despair*",
		},
		SANITY = {
			FULL  = "*salutes*",
			HIGH  = "*thumbs up*",
			MID   = "*rubs temples*",
			LOW   = "*glances around frantically*",
			EMPTY = "*cradles head, rocking back and forth*",
		},
		HEALTH = {
			FULL  = "*pats heart*",
			HIGH  = "*feels pulse, thumbs up*",
			MID   = "*moves hand around arm, as if wrapping it*",
			LOW   = "*cradles arm*",
			EMPTY = "*sways dramatically, then falls over*",
		},
		WETNESS = {
			FULL  = "*frantically swims upward*",
			HIGH  = "*swims upward*",
			MID   = "*looks miserably at the sky*",
			LOW   = "*shelters head under arms*",
			EMPTY = "*smiles, holding invisible umbrella*",
		},
	},
	WAXWELL = {
		HUNGER = {
			FULL  = "I've had quite the feast.",
			HIGH  = "I'm sated, but not to excess.",
			MID   = "A snack might be in order.",
			LOW   = "I am empty inside.",
			EMPTY = "No! I didn't earn my freedom just to starve here!",
		},
		SANITY = {
			FULL  = "Dapper as can be.",
			HIGH  = "My normally unwavering intellect seems to be... wavering.",
			MID   = "Ugh. My head hurts.",
			LOW   = "I need to clear my head, I'm beginning to see... Them.",
			EMPTY = "Help! These shadows are real beasts, you know!",
		},
		HEALTH = {
			FULL  = "I'm completely unharmed.",
			HIGH  = "It's just a scratch.",
			MID   = "I might need to patch myself up.",
			LOW   = "This isn't my swan song, but I'm close.",
			EMPTY = "No! I didn't escape just to die here!",
		},
		WETNESS = {
			FULL  = "Wetter than water itself.",
			HIGH  = "I don't think I'll ever be dry again.",
			MID   = "This water will ruin my suit.",
			LOW   = "Damp is not dapper.",
			EMPTY = "Dry and dapper.",
		},
	},
	WEBBER = {
		HUNGER = {
			FULL  = "Both of our stomachs are filled!",				-- >75%
			HIGH  = "We could eat a nibble more.",					-- >55%
			MID   = "We think it's about time for lunch!",			-- >35%
			LOW   = "We would eat mum's leftovers at this point...",-- >15%
			EMPTY = "Our tummies are empty!",						-- <15%
		},
		SANITY = {
			FULL  = "We feel well-rested!",							-- >75%
			HIGH  = "A nap wouldn't hurt.",							-- >55%
			MID   = "Our head hurts...",							-- >35%
			LOW   = "When was the last time we have had a nap?!",	-- >15%
			EMPTY = "We aren't scared of you, scary things!",		-- <15%
		},
		HEALTH = {
			FULL  = "We don't even have a scratch!",				-- 100%
			HIGH  = "We're going to need a band-aid.",				-- >75%
			MID   = "We're going to need more than a band-aid...",	-- >50%
			LOW   = "Our body aches...",							-- >25%
			EMPTY = "We don't want to die yet...",					-- <25%
		},
		WETNESS = {
			FULL  = "Waah, we're drenched!", 						-- >75%
			HIGH  = "Our fur is soaked!",							-- >55%
			MID   = "We're wet!", 									-- >35%
			LOW   = "We're unpleasantly moist.", 					-- >15%
			EMPTY = "We like playing in puddles.", 					-- <15%
		},
	},
	WATHGRITHR = {
		HUNGER = {
			FULL  = "I hunger for battle, not meat!", 				-- >75%
			HIGH  = "I'm sated enough for battle.",					-- >55%
			MID   = "I could have a meat snack.", 					-- >35%
			LOW   = "I long for a feast!", 							-- >15%
			EMPTY = "I'll starve without some meat!", 				-- <15%
		},
		SANITY = {
			FULL  = "I fear no mortal!", 							-- >75%
			HIGH  = "I'll feel better in battle!", 					-- >55%
			MID   = "My mind wanders...", 							-- >35%
			LOW   = "These shadows pass right through my spear...", -- >15%
			EMPTY = "Stay back, beasts of darkness!", 				-- <15%
		},
		HEALTH = {
			FULL  = "My skin is impenetrable!", 					-- 100%
			HIGH  = "It's just a flesh wound!", 					-- >75%
			MID   = "I'm wounded, but I can still fight.", 			-- >50%
			LOW   = "Without aid, I will be in Valhalla soon...", 	-- >25%
			EMPTY = "My saga reaches an end...", 					-- <25%
		},
		WETNESS = {
			FULL  = "I'm completely drenched!", 					-- >75%
			HIGH  = "A warrior this wet cannot fight!",				-- >55%
			MID   = "My armor will rust!", 							-- >35%
			LOW   = "I won't need a bath after this.", 				-- >15%
			EMPTY = "Dry enough for battle!", 						-- <15%
		},
		INSPIRATION = {
			FULL  = "My voice is strong enough for three songs!", 			-- >5/6, 3 songs
			HIGH  = "I could sing a duet by myself!",						-- >3/6, 2 songs
			MID   = "I am ready to sing!", 									-- >1/6, 1 song
			LOW   = "I must warm up my voice... in the heat of battle!", 	-- <1/6
		},
	},
	WINONA = {
		HUNGER = {
			FULL  = "I got my square meal for the day.",
			HIGH  = "I always got room for some more grub!",
			MID   = "Can I take my lunch break yet?",
			LOW   = "I'm running low on fuel, boss.",
			EMPTY = "The factory's gonna be short a worker if I don't get some grub!",
		},
		SANITY = {
			FULL  = "As sane as I'll ever be.",
			HIGH  = "All's good under the hood!",
			MID   = "I think I got a few screws loose...",
			LOW   = "My mind's broke, I should be the one to fix it.",
			EMPTY = "This is a nightmare! Ha! Really though.",
		},
		HEALTH = {
			FULL  = "I'm as healthy as a horse!",
			HIGH  = "Eh, I'll work it off.",
			MID   = "I can't give up yet.",
			LOW   = "Can I collect my worker's pension yet...?",
			EMPTY = "I think my shift is over...",
		},
		WETNESS = {
			FULL  = "I can't work in these conditions!",
			HIGH  = "My overalls are collecting water!",
			MID   = "Someone should put down a wet floor sign.",
			LOW   = "It's always good to stay hydrated while on the job.",
			EMPTY = "This is nothin'.",
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
	},
	WORMWOOD = {
		HUNGER = {
			FULL  = "Too much.",
			HIGH  = "No need belly stuff.",
			MID   = "Could use belly fillers.",
			LOW   = "Need stuff for belly.",
			EMPTY = "Ooh, belly hurts...",
		},
		SANITY = {
			FULL  = "Feels great!",
			HIGH  = "Head feels okay.",
			MID   = "Head hurts, but feeling okay.",
			LOW   = "Creepy things watching me.",
			EMPTY = "Creepy things hurt!",
		},
		HEALTH = {
			FULL  = "Wormwood not hurt.",
			HIGH  = "Stingy, but okay",
			MID   = "Feeling weak.",
			LOW   = "Hurts very bad.",
			EMPTY = "Help, friends!",
		},
		WETNESS = {
			FULL  = "Really really wet!",
			HIGH  = "Really wet!",
			MID   = "Feeling a bit wet.",
			LOW   = "It's raining! Woohoo!",
			EMPTY = "Feeling dry.",
		},
	},
	WURT = {
		HUNGER = {
			FULL  = "Glurgh, no more.",
			HIGH  = "Not hungry, florpt.",
			MID   = "Could eat some more.",
			LOW   = "Really want food!",
			EMPTY = "Really really hungry!",
		},
		SANITY = {
			FULL  = "Very happy!",
			HIGH  = "Head okay, flort.",
			MID   = "Glurgh, head hurt.",
			LOW   = "Scary shadows coming!",
			EMPTY = "Glargh, scary nightmares!!",
		},
		HEALTH = {
			FULL  = "Feeling great, florpt!",
			HIGH  = "Feels good!",
			MID   = "Need help, missing scales...",
			LOW   = "*Sob* Hurts so bad...",
			EMPTY = "I... need... help...",
		},
		WETNESS = {
			FULL  = "Aaah, splish-splash!",
			HIGH  = "Feels good on scales!",
			MID   = "Mermfolk love water, florp!",
			LOW   = "Ahh... wetter feel better, florp!",
			EMPTY = "Too dry, glorp.",
		}
	},
	WORTOX = {
		HUNGER = {
			FULL  = "How mortal of me to have a stomach so full!",
			HIGH  = "I'm well-fueled for a good trick! Hyuyu!",
			MID   = "In need of a morsel... so very mortal.",
			LOW   = "I'd love a tasty soul! I'll save the tricking for later...",
			EMPTY = "My craving for souls has grown ravenous!",
		},
		SANITY = {
			FULL  = "My head is clear... fun times are near! Hyuyu!",
			HIGH  = "Might I suck some souls to keep a clear head?",
			MID   = "All my hopping has caused quite the headache...",
			LOW   = "I envy the trickery of these shadows! Hyuyu!",
			EMPTY = "My mind inhabits a new plane of pure madness!",
		},
		HEALTH = {
			FULL  = "I'm in the perfect mood for a good mischief!",
			HIGH  = "Just a scratch, nothing a soul can't restore!",
			MID   = "A few souls to close these wounds... Hyuyu!",
			LOW   = "My very own soul grows weak...",
			EMPTY = "My soul is soon to not be my own! Hyuyu...",
		},
		WETNESS = {
			FULL  = "I AM DRENCHED!",
			HIGH  = "I am the soggiest imp!",
			MID   = "There is a wet imp smell in my future.",
			LOW   = "The world is giving me a shower!",
			EMPTY = "I should keep an eye on the sky, if I wish to stay dry!",
		}
	},
	WANDA = {
		HUNGER = {
			FULL  = "I need time to digest all this food!",							-- >75%
			HIGH  = "I'm still full from earlier. Or later.",						-- >55%
			MID   = "I have just enough time for a snack break!", 					-- >35%
			LOW   = "My stomach is its own passage of time!", 						-- >15%
			EMPTY = "Time will catch up to me quickly if I don't eat right now!", 	-- <15%
		},
		SANITY = {
			FULL  = "Everything looks normal in this timeline!", 							-- >75%
			HIGH  = "Feeling grand enough for some quantum leaps!",							-- >55%
			MID   = "If I didn't carry clocks I wouldn't know what time it is anymore!",	-- >35%
			LOW   = "Reality is breaking apart!", 											-- >15%
			EMPTY = "You'll never catch me! Past, present, or future!", 					-- <15%
		},
		HEALTH = {
			FULL  = "They say your 20s are your best years after all!",					 	-- 100%
			HIGH  = "Still young and full of vigor!", 										-- >75%
			MID   = "Wait a tick! I need a moment to recover!", 							-- >50%
			LOW   = "I just need more time!", 												-- >25%
			EMPTY = "The sands of my hourglass are about to run out!",					 	-- <25%
		},
		WETNESS = {
			FULL  = "Time is just like this rain. It doesn't stop!", 								-- >75%
			HIGH  = "If this keeps up, my pocket watches are going to rust!",						-- >55%
			MID   = "How many years has it been since I've been this soaked?", 						-- >35%
			LOW   = "Oh botheration! I need to find some cover from this rain!", 					-- >15%
			EMPTY = "A little rain is nothing compared to the temporal complexities of travel!", 	-- <15%
		}
	},
	WALTER = {
		HUNGER = {
			FULL  = "A pinetree pioneer always runs on a full stomach!", 	-- >75%
			HIGH  = "I should prepare a snack for our next hike.",			-- >55%
			MID   = "I hope I packed a few snacks in Woby...", 				-- >35%
			LOW   = "I wish we could eat s'mores!", 						-- >15%
			EMPTY = "Don't worry girl, we'll find some grub soon!", 		-- <15%
		},
		SANITY = {
			FULL  = "My pioneer sense is better than ever!", 	-- >75%
			HIGH  = "How about a story to ease the tension?", 	-- >55%
			MID   = "Do you hear the whispers too Woby?", 		-- >35%
			LOW   = "H-hey Woby, did you see that?!", 			-- >15%
			EMPTY = "The monsters from my stories are REAL!!", 	-- <15%
		},
		HEALTH = {
			FULL  = "No bruises or bee stings here!", 					-- 100%
			HIGH  = "Nothing a Pinetree Pioneer can't handle!",		 	-- >75%
			MID   = "My first aid training is about to come in handy!", -- >50%
			LOW   = "Woby should carry me to safety!", 					-- >25%
			EMPTY = "You might have to go on without me girl...", 		-- <25%
		},
		WETNESS = {
			FULL  = "Now I'm all pruney!",					 	-- >75%
			HIGH  = "Did anyone remember to pack a towel?",		-- >55%
			MID   = "All my badges are soaked!", 				-- >35%
			LOW   = "Just a little water!", 					-- >15%
			EMPTY = "I've camped through worse storms!", 		-- <15%
		}
	}
}