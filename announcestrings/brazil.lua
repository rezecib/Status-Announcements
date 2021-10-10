ANNOUNCE_STRINGS = {
	-- These are not character-specific strings, but are here to ease translation
	-- Note that spaces at the beginning and end of these are important and should be preserved
	_ = {
		getArticle = function(name)
			--This checks if the name starts with a vowel, and uses "an" if so, "a" otherwise
			return "1"
		end,
		--Goes into {S} if there are multiple items (plural)
		-- This isn't perfect for making plural even in English, but it's close enough
		S = "s",
		STAT_NAMES = {
			Hunger = "Fome",
			Sanity = "Sanidade",
			Health = "Vida",
			["Log Meter"] = "Medidor de Tronco",
			Wetness = "Umidade",
			Age = "Idade",
			Abigail = "Abigail",
			Inspiration = "Inspiração",
			--Other mod stats won't have translations, but at least we can support these
		},
		ANNOUNCE_ITEM = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "I have 6 papyrus in this chest."
			FORMAT_STRING = "{I_HAVE}{THIS_MANY} {ITEM}{S}{IN_THIS}{CONTAINER}{WITH}{PERCENT}{DURABILITY}.",
			
			--One of these goes into {I_HAVE}
			I_HAVE = "Eu tenho ",
			WE_HAVE = "Nós temos ",
			
			--{THIS_MANY} is a number if multiple, but singular varies a lot by language,
			-- so we use getArticle above to get it
			
			--{ITEM} is acquired from item.name
			
			--{S} uses S above
			
			--Goes into {IN_THIS}, if present
			IN_THIS = " neste ",
			
			--{CONTAINER} is acquired from container.name
			
			--One of these goes into {WITH}
			WITH = " com ", --if it's only one thing
			AND_THIS_ONE_HAS = ", e este tem ", --if there are multiple, show durability of one
			AND_THIS_ONE_IS = ", e este é ", --if there are multiple, show durability of one
			
			--{PERCENT} is acquired from the item's durability
			
			--Goes into {DURABILITY}
			DURABILITY = " de durabilidade",
			FRESHNESS = " de frescura",
			RECHARGE = " de carga",
			
			-- Optionally added into {PERCENT}
			REMAINING = {
				FORMAT = "{LEFT}",
				DURABILITY = "{AMOUNT} usos restantes", -- note that this is unused because durability is only published as a percent to clients
				FRESHNESS = "faltam {AMOUNT} dias", -- note that this is unused because perishables only publish percent to clients
				RECHARGE = "{AMOUNT} até a carga",
			},
			
			-- Optionally added into {ITEM} or {WITH} for thermal stones.
			HEATROCK = {
				"congelados",
				"frio",
				"temperatura ambiente",
				"caloroso",
				"quente",
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
			I_HAVE = "Eu tenho ", --for pre-built
			ILL_MAKE = "Eu farei ", --for known recipes where you have ingredients
			CAN_SOMEONE = "Alguém pode me fazer ", --for unknown recipes
			WE_NEED = "Nós precisamos de mais", --for known recipes where you don't have ingredients
			
			--{THIS_MANY} uses getArticle above to get the right article ("a", "an")
			
			--{ITEM} comes from the recipe.name
			
			--{S} uses S above

			--Goes into {PRE_BUILT}
			PRE_BUILT = " pre-construída(o) e pronta(o) para ser colocada",
			
			--This goes into {END_Q} if it's a question
			END_Q = "?",
			
			--Goes into {I_NEED}
			I_NEED = " Eu precisaria de ",
			
			--{PROTOTYPER} is taken from the recipepopup.teaser:GetString with this function
			getPrototyper = function(teaser)
				--This extracts from sentences like "Use a (science machine) to..." and "Use an (alchemy engine) to..."
				return teaser:gmatch("Use uma (.*) para")():gsub("\n", "")
			end,
			
			--Goes into {FOR_IT}
			FOR_IT = " para isso",
		},
		ANNOUNCE_INGREDIENTS = {
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "I need 2 more cut stones and a science machine to make an alchemy engine."
			FORMAT_NEED = "Eu preciso de mais {NUM_ING} {INGREDIENT}{S}{AND}{A_PROTO}{PROTOTYPER} para fazer {A_REC} {RECIPE}.",
			
			--If a prototyper is needed, goes into {AND}
			AND = " e ",
			
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "I have enough twigs to make 9 bird traps, but I need a science machine."
			FORMAT_HAVE = "Eu tenho {INGREDIENT}{ING_S} o suficiente para fazer {A_REC} {RECIPE}{REC_S}{BUT_NEED}{A_PROTO}{PROTOTYPER}.",
			
			--If a prototyper is needed, goes into {BUT_NEED}
			BUT_NEED = ", mas eu preciso ",
		},
		ANNOUNCE_SKIN = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "I have the Tragic Torch skin for the Torch"
			FORMAT_STRING = "Eu tenho {SKIN} para a {ITEM}.",
			
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
				DEFAULT = "Eu estou",
				BEAST = "A fera está", --for Werebeaver
			},
			
			--{TEMPERATURE} is picked from this
			TEMPERATURE = {
				BURNING = "pegando fogo!",
				HOT = "queimando!",
				WARM = "um pouco quente.",
				GOOD = "á uma temperatura confortável.",
				COOL = "com um pouco de frio.",	
				COLD = "congelando!",
				FREEZING = "congelando, que frio!!",
			},
		},
		ANNOUNCE_SEASON = "Faltam {DAYS_LEFT} dias para o {SEASON}.",
		ANNOUNCE_GIFT = {
			CAN_OPEN = "Tenho um presente e estou prestes a abri-lo!",
			NEED_SCIENCE = "Eu preciso de ciência adicional para abrir esse presente!",
		},
		ANNOUNCE_HINT = "Anunciar",
	},
	-- Everything below is character-specific
	UNKNOWN = {
		HUNGER = {
			FULL  = "Estou completamente satisfeito!", 	-- >75%
			HIGH  = "Estou muito satisfeito.",			-- >55%
			MID   = "Estou ficando com fome.", 	-- >35%
			LOW   = "Estou com fome!", 				-- >15%
			EMPTY = "Estou morrendo de fome!", 			-- <15%
		},
		SANITY = {
			FULL  = "Meu cérebro está em condições de pico!", 			-- >75%
			HIGH  = "Sinto-me muito bem.", 				-- >55%
			MID   = "Estou um pouco ansioso.", 				-- >35%
			LOW   = "Estou me sentindo um pouco louco, aqui!", 			-- >15%
			EMPTY = "AAAAHHHH! Atrás, bestas da sombra!", 	-- <15%
		},
		HEALTH = {
			FULL  = "Estou em perfeita saúde!", 	-- 100%
			HIGH  = "Eu sou um pouco arranhado.", 	-- >75%
			MID   = "Estou ferido.", 			-- >50%
			LOW   = "Estou gravemente ferido!", 	-- >25%
			EMPTY = "Estou mortalmente ferido!", 	-- <25%
		},
		WETNESS = {
			FULL  = "Estou completamente encharcado!", 	-- >75%
			HIGH  = "Estou encharcado!",					-- >55%
			MID   = "Estou muito molhado!", 				-- >35%
			LOW   = "Estou ficando um pouco molhado.", 		-- >15%
			EMPTY = "Estou completamente seco.", 				-- <15%
		},
	},
	WILSON = {
		HUNGER = {
			FULL  = "Estou cheio!",
			HIGH  = "Não preciso comer.",
			MID   = "Preciso de um pouco de comida.",
			LOW   = "Eu realmente estou com fome.",
			EMPTY = "Eu... preciso... URGENTEMENTE DE COMIDA...",
		},
		SANITY = {
			FULL  = "Tão lúcido quanto possível!",
			HIGH  = "Eu vou ficar bem.",
			MID   = "Minha cabeça dói...",
			LOW   = "Pela Charlie , o que está acontecendo!?",
			EMPTY = "Alguem me ajuda! Essas coisas vão me comer!!!!",
		},
		HEALTH = {
			FULL  = "Afinado como um violino!",
			HIGH  = "Estou com alguns arranhões, mas eu posso continuar.",
			MID   = "Eu... Acho que preciso de atenção médica.",
			LOW   = "Perdi muito sangue...",
			EMPTY = "Eu vou morrer...",
		},
		WETNESS = {
			FULL  = "Eu alcancei o meu ponto máximo de saturação!",
			HIGH  = "Água é isso aí!",
			MID   = "Estou molhado.",
			LOW   = "Oh, H2O.",
			EMPTY = "Estou moderadamente seco.",
		},
	},
	WILLOW = {
		HUNGER = {
			FULL  = "Vou engordar se não parar de comer.",
			HIGH  = "Agradavelmente cheia.",
			MID   = "Meu fogo precisa de um pouco de combustível.",
			LOW   = "Ugh, eu estou morrendo de fome aqui!",
			EMPTY = "Eu estou praticamente pele e ossos!",
		},
		SANITY = {
			FULL  = "Acho que já tive fogo suficiente.",
			HIGH  = "Acabei de ver Bernie de pé? ... não, não importa.",
			MID   = "Eu me sinto mais frio do que devia...",
			LOW   = "Bernie, por que sinto tanto frio!?",
			EMPTY = "Bernie, protege-me dessas coisas horríveis!",
		},
		HEALTH = {
			FULL  = "Sem um arranhão!",
			HIGH  = "Eu tenho um arranhão ou dois. Eu provavelmente deveria queimá-los.",
			MID   = "Estes cortes são além da queima, preciso de um médico...",
			LOW   = "Sinto-me fraca... Talvez... morrer.",
			EMPTY = "Meu fogo está quase acabando...",
		},
		WETNESS = {
			FULL  = "Ugh, esta chuva é o pior!",
			HIGH  = "Eu odeio toda essa água!",
			MID   = "Esta chuva é demais.",
			LOW   = "Ah, se a chuva continuar...",
			EMPTY = "Chuva não suficiente para apagar o fogo.",
		},
	},
	WOLFGANG = {
		HUNGER = {
			FULL  = "Wolfgang é completo e poderoso!",
			HIGH  = "Wolfgang deve comer e se tornar mais poderoso!",
			MID   = "Wolfgang poderia comer mais.",
			LOW   = "Wolfgang tem um buraco na barriga.",
			EMPTY = "Wolfgang precisa de comida! AGORA!",
		},
		SANITY = {
			FULL  = "Wolfgang se sentir bem da cabeça!",
			HIGH  = "Cabeça de Wolfgang sentir sensação engraçada.",
			MID   = "Cabeça de Wolfgang ferida.",
			LOW   = "Wolfgang ver monstros assustadores...",
			EMPTY = "Monstros assustadores em todos os lugares!",
		},
		HEALTH = {
			FULL  = "Wolfgang não está ferido!",
			HIGH  = "Wolfgang precisa de pequenos reparos.",
			MID   = "Wolfgang ferido.",
			LOW   = "Wolfgang precisa muito de ajuda para não morrer.",
			EMPTY = "Wolfgang pode morrer...",
		},
		WETNESS = {
			FULL  = "Wolfgang agora talvez feito de água!",
			HIGH  = "É como estar sentado na lagoa.",
			MID   = "Wolfgang não gosta de uma hora do banho.",
			LOW   = "Tempo de água.",
			EMPTY = "Wolfgang está seco.",
		},
	},
	WENDY = {
		HUNGER = {
			FULL  = "Nenhuma quantidade de comida vai encher o buraco no meu coração.",
			HIGH  = "Eu estou completa, mas ainda continuo com fome por algo que nenhum amigo pode me fornecer.",
			MID   = "Não estou vazia, mas não completa. Estranho.",
			LOW   = "Estou cheio de vazio.",
			EMPTY = "Eu encontrei a forma mais lenta de morrer. Fome.",
		},
		SANITY = {
			FULL  = "Meus pensamentos correm com clareza",
			HIGH  = "Meus pensamentos as vezes ficam turvos.",
			MID   = "Meus pensamentos estão febris...",
			LOW   = "Você os vê, Abigail? Estes demônios podem me deixar acompanhá-la, em breve.",
			EMPTY = "Leve-me para Abigail, criaturas da escuridão e da noite!",
		},
		HEALTH = {
			FULL  = "Estou bem, mas tenho certeza que vou me machucar outra vez.",
			HIGH  = "Eu sinto dor, mas não muito grande.",
			MID   = "A vida traz dor, mas eu não estou acostumada a isso.",
			LOW   = "Sangrar ... seria fácil...",
			EMPTY = "Estarei com Abigail, em breve...",
		},
		WETNESS = {
			FULL  = "Um apocalipse de água!",
			HIGH  = "Uma eternidade de umidade e tristeza.",
			MID   = "Encharcada e triste.",
			LOW   = "Talvez esta água preencha o buraco no meu coração.",
			EMPTY = "Minha pele está tão seca quanto meu coração.",
		},
		ABIGAIL = {
			FULL  = "Abigail está mais brilhante do que nunca!",
			HIGH  = "Abigail brilha intensamente.",
			MID   = "Abigail está começando a desaparecer ...",
			LOW   = "Tenha cuidado, Abigail! Eu mal posso te ver mais!",
			EMPTY = "Não me deixe, Abigail!",
		},
	},
	WX78 = {
		HUNGER = {
			FULL  = "Estatísticas de combustível: Capacidade máxima",
			HIGH  = "Estatísticas de combustível: Alta",
			MID   = "Estatísticas de combustível: Aceitável",
			LOW   = "Estatísticas de combustível: Baixa",
			EMPTY = "Estatísticas de combustível: Crítica",
		},
		SANITY = {
			FULL  = "Estatísticas de CPU: Totalmente operacional",
			HIGH  = "Estatísticas de CPU: Funcional",
			MID   = "Estatísticas de CPU: Estragado",
			LOW   = "Estatísticas de CPU: Falha eminente",
			EMPTY = "Estatísticas de CPU: Múltiplas falhas detectadas",
		},
		HEALTH = {
			FULL  = "Estado do Chassis: Perfeita condição",
			HIGH  = "Estado do Chassis: Crack detectado",
			MID   = "Estado do Chassis: Dano moderado",
			LOW   = "Estado do Chassis: Falha de integridade",
			EMPTY = "Estado do Chassis: Não funcional",
		},
		WETNESS = {
			FULL  = "Estado de umidade: Crítica",
			HIGH  = "Estado de umidade: Proximo ao crítico",
			MID   = "Estado de umidade: Inaceitável",
			LOW   = "Estado de umidade: Tolerável",
			EMPTY = "Estado de umidade: Aceitável",
		},
	},
	WICKERBOTTOM = {
		HUNGER = {
			FULL  = "Eu deveria estar fazendo pesquisa, não me enchendo.",
			HIGH  = "Cheia, mas não inchada.",
			MID   = "Eu estou me sentindo um pouco peckish.",
			LOW   = "Está bibliotecária precisa de comida, eu tenho medo!",
			EMPTY = "Se eu não conseguir comida imediatamente, vou morrer de fome!",
		},
		SANITY = {
			FULL  = "Nada irracional acontecendo aqui.",
			HIGH  = "Eu acredito que tenho um pouco de dor de cabeça.",
			MID   = "Estas enxaquecas são insuportáveis.",
			LOW   = "Eu não tenho certeza se essas coisas são imaginárias, mas!",
			EMPTY = "Ajuda! Essas abominações insondáveis são hostis!",
		},
		HEALTH = {
			FULL  = "Estou tão em forma como pode ser esperado para a minha idade!",
			HIGH  = "Algumas contusões, mas nada importante.",
			MID   = "Minhas necessidades médicas são montagem.",
			LOW   = "Sem tratamento, este será o meu fim!",
			EMPTY = "Requerem atenção médica imediata!",
		},
		WETNESS = {
			FULL  = "Positivamente encharcada!",
			HIGH  = "Eu estou molhada, molhada, molhada!",
			MID   = "Gostaria de saber qual é o ponto de saturação do meu corpo...",
			LOW   = "A camada de água começa a acumular.",
			EMPTY = "Eu sou suficientemente desprovida de umidade.",
		},
	},
	WOODIE = {
		HUMAN = {
			HUNGER = {
				FULL  = "Tudo lotado!!",
				HIGH  = "Ainda cheio o suficiente para cortar.",
				MID   = "Posso precisar de um lanche, eh!",
				LOW   = "Toque o sino do jantar.",
				EMPTY = "Estou morrendo de fome!",
			},
			SANITY = {
				FULL  = "Tudo de bom na fachada Norte!",
				HIGH  = "Ainda bem da cabeça.",
				MID   = "Acho que preciso de um cochilo, hein.",
				LOW   = "Saiam daqui criaturas das sombras!",
				EMPTY = "Todos os meus medos são reais!",
			},
			HEALTH = {
				FULL  = "Afinado como um apito!",
				HIGH  = "O que não te mata te faz mais forte, eh?",
				MID   = "Poderia usar um pouco de salubridade.",
				LOW   = "Isso realmente está começando a doer...",
				EMPTY = "Ponha-me a descansar ... na floresta...",
			},
			WETNESS = {
				FULL  = "Muito molhado até mesmo para cortar, hein?",
				HIGH  = "A manta não é suficiente para este tipo de chuva.",
				MID   = "Eu estou ficando muito molhado, hein?",
				LOW   = "Quente do xadrez, mesmo quando molhado.",
				EMPTY = "Dificilmente uma gota cairá em mim, estou seco!!",
			},
			["LOG METER"] = {
				FULL  = "Sempre poderia ter mais troncos, mas não na minha barriga agora!",	-- > 90%
				HIGH  = "Eu tenho um desejo por algo bizarro.",						-- > 70%
				MID   = "Os troncos estão olhando para mim.",									-- > 50%
				LOW   = "Eu posso sentir a maldição chegando.",									-- > 25%
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
				FULL  = "Os olhos da fera são largos e alerta.",
				HIGH  = "A besta pisca em sombras!",
				MID   = "A besta vira para olhar para algo que não está lá.",
				LOW   = "A besta está a tremer e seus olhos estão se contraindo.",
				EMPTY = "O animal rosna e aparenta estar sendo caçado pelas sombras.",
			},
			HEALTH = {
				FULL  = "A besta está vigorosamente.",
				HIGH  = "A besta tem alguns arranhões.",
				MID   = "A fera lambe suas feridas.",
				LOW   = "A besta embala o seu braço.",
				EMPTY = "A besta manca pateticamente.",
			},
			WETNESS = {
				FULL  = "A pele da fera está completamente encharcada",
				HIGH  = "A fera deixa um rastro de pequenas poças.",
				MID   = "A pele da fera está um pouco molhada.",
				LOW   = "A besta pinga um pouco.",
				EMPTY = "A pele da fera está seca.",
			},
			["LOG METER"] = {
				FULL  = "A besta parece quase humana.",				-- > 90%
				HIGH  = "A besta mastiga um bocado de madeira.",		-- > 70%
				MID   = "A besta come um galho.",					-- > 50%
				EMPTY = "A besta parece oca.",						-- < 25%
				LOW   = "A besta olha vorazmente para aquelas árvores.",	-- > 25%
			},
		},
	},
	WES = {
		HUNGER = {
			FULL  = "*Tapa o estômago*",
			HIGH  = "*Tapa o estômago*",
			MID   = "*Traz a mão para abrir a boca*",
			LOW   = "*Traz a mão para abrir a boca, olhos bem abertos*",
			EMPTY = "*Garras de estômago afundado com um olhar de desespero*",
		},
		SANITY = {
			FULL  = "*Saudações*",
			HIGH  = "*Polegares para cima*",
			MID   = "*Esfrega templos*",
			LOW   = "*Olhares ao redor freneticamente*",
			EMPTY = "*Cabeça de berços, balançando para frente e para trás*",
		},
		HEALTH = {
			FULL  = "*Coração de mimos*",
			HIGH  = "*Sente o pulso, polegares para cima*",
			MID   = "*Movimentos de mão em volta do braço, como se envolvê-lo*",
			LOW   = "*Braço de berços*",
			EMPTY = "*Balança drasticamente e depois cai*",
		},
		WETNESS = {
			FULL  = "*Nadando freneticamente para cima*",
			HIGH  = "*Nada para cima*",
			MID   = "*Olha miseravelmente para o céu*",
			LOW   = "*Abrigos cabeça sob os braços*",
			EMPTY = "*Sorrisos, segurando guarda-chuva invisível*",
		},
	},
	WAXWELL = {
		HUNGER = {
			FULL  = "Estou com o estômago cheio.",
			HIGH  = "Estou saciado, mas não em excesso.",
			MID   = "Um lanche seria bom.",
			LOW   = "Estou vazio por dentro.",
			EMPTY = "Não! Eu não ganhei minha liberdade apenas para morrer de fome aqui!",
		},
		SANITY = {
			FULL  = "Elegante, como pode ser.",
			HIGH  = "Meu intelecto normalmente inabalável, aliais parece ser ... vacilante.",
			MID   = "Ugh, minha cabeça dói",
			LOW   = "Eu preciso limpar minha cabeça, estou começando a ver... as sombras ....",
			EMPTY = "Ajuda! Estas sombras são bestas reais, você sabe!!",
		},
		HEALTH = {
			FULL  = "Estou completamente indemne.",
			HIGH  = "É só um arranhão.",
			MID   = "Talvez eu precise me remendar.",
			LOW   = "Está não é a minha canção de cisne, mas estou perto.",
			EMPTY = "Não! Eu não escapei apenas para morrer aqui!",
		},
		WETNESS = {
			FULL  = "Mais molhado que a própria água.",
			HIGH  = "Eu não acho que eu vou ficar seco novamente.",
			MID   = "Esta água arruinará meu terno.",
			LOW   = "Umidade não é estilosa.",
			EMPTY = "Seco e elegante.",
		},
	},
	WEBBER = {
		HUNGER = {
			FULL  = "Dois de nossos estômagos estão cheios!",				-- >75%
			HIGH  = "Podemos comer mais um pedacinho.",					-- >55%
			MID   = "Pensamos que é hora de almoçar!",			-- >35%
			LOW   = "Nós comemos as sobras da mãe neste ponto...",-- >15%
			EMPTY = "Nossas barrigas estão vazias!",						-- <15%
		},
		SANITY = {
			FULL  = "Sentimo-nos bem descansados!",							-- >75%
			HIGH  = "Um cochilo não faria mal.",							-- >55%
			MID   = "Nossa que dor de cabeça...",							-- >35%
			LOW   = "Quando foi a última vez que tiramos uma soneca?!",	-- >15%
			EMPTY = "Não temos medo de você, coisas assustadoras!",		-- <15%
		},
		HEALTH = {
			FULL  = "Não temos sequer um arranhão!",				-- 100%
			HIGH  = "Nós vamos precisar de um Band-Aid.",				-- >75%
			MID   = "Nós vamos precisar mais do que um Band-Aid...",	-- >50%
			LOW   = "Nosso corpo dói...",							-- >25%
			EMPTY = "Nós não queremos morrer ainda...",					-- <25%
		},
		WETNESS = {
			FULL  = "Waah, estamos encharcados!", 						-- >75%
			HIGH  = "Nossa pele está embebida!",							-- >55%
			MID   = "Estamos molhados!", 									-- >35%
			LOW   = "Estamos desagradavelmente úmidos.", 					-- >15%
			EMPTY = "Nós gostamos de se jogar em poças.", 					-- <15%
		},
	},
	WATHGRITHR = {
		HUNGER = {
			FULL  = "Eu tenho fome de batalha, não de carne!", 				-- >75%
			HIGH  = "Estou saciado o suficiente para a batalha.",					-- >55%
			MID   = "Eu poderia ter um lanche de carne.", 					-- >35%
			LOW   = "Eu anseio por uma festa!", 							-- >15%
			EMPTY = "Vou morrer de fome sem comer carne!", 				-- <15%
		},
		SANITY = {
			FULL  = "Eu não temo mortal!", 							-- >75%
			HIGH  = "Eu vou me sentir melhor na batalha!", 					-- >55%
			MID   = "Minha mente vagueia...", 							-- >35%
			LOW   = "Essas sombras passam pela minha lança...", -- >15%
			EMPTY = "Fique atrás, bestas da escuridão!", 				-- <15%
		},
		HEALTH = {
			FULL  = "Minha pele é impenetrável.", 					-- 100%
			HIGH  = "É apenas uma ferida de carne!", 					-- >75%
			MID   = "Estou ferida, mas ainda posso lutar.", 			-- >50%
			LOW   = "Sem ajuda, estarei em Valhalla em breve...", 	-- >25%
			EMPTY = "Minha saga chega ao fim...", 					-- <25%
		},
		WETNESS = {
			FULL  = "Estou completamente encharcada!", 					-- >75%
			HIGH  = "Um guerreiro não pode lutar molhado!",				-- >55%
			MID   = "Minha armadura está enferrujada!", 							-- >35%
			LOW   = "Não vou precisar de um banho depois disso.", 				-- >15%
			EMPTY = "Seca o suficiente para a batalha!", 						-- <15%
		},
		INSPIRATION = {
			FULL  = "Minha voz é forte o suficiente para três músicas!", 			-- >5/6, 3 songs
			HIGH  = "Eu poderia cantar um dueto sozinho!",						-- >3/6, 2 songs
			MID   = "Estou pronto para cantar!", 									-- >1/6, 1 song
			LOW   = "Devo aquecer minha voz ... no calor da batalha!", 	-- <1/6
		},
	},
	WINONA = {
		HUNGER = {
			FULL  = "Eu consegui minha refeição para o dia.",
			HIGH  = "Eu sempre tenho espaço para um pouco mais de comida!",
			MID   = "Posso ir ao meu intervado de almoço?",
			LOW   = "Estou ficando sem combustível, chefe.",
			EMPTY = "A fábrica vai ser um trabalho duro, caso eu não conseguir algum rango",
		},
		SANITY = {
			FULL  = "Tão sã como eu jamais serei.",
			HIGH  = "Tudo certo por aqui!",
			MID   = "Eu acho que tenho alguns parafusos soltos...",
			LOW   = "Minha mente está quebrada, eu deveria ser a única a corriga-la.",
			EMPTY = "Isto é um pesadelo! Ha! Mesmo assim.",
		},
		HEALTH = {
			FULL  = "Estou tão saudável quanto um cavalo!",
			HIGH  = "Beleza, eu vou resolver isso.",
			MID   = "Eu não posso desistir ainda.",
			LOW   = "Posso pegar a pensão do meu trabalho ainda...?",
			EMPTY = "Acho que o meu turno acabou...",
		},
		WETNESS = {
			FULL  = "Não posso trabalhar nessas condições!",
			HIGH  = "Meu macacão está coletando água!",
			MID   = "Alguém deveria colocar um sinal de chão molhado.",
			LOW   = "É sempre bom ficar hidratada durante o trabalho.",
			EMPTY = "Isso não é nada.",
		},
	},
	WARLY = {
		HUNGER = {
			FULL  = "Minha culinária será a morte de mim!", 	-- >75%
			HIGH  = "Acho que já chega, por agora.",			-- >55%
			MID   = "Hora do jantar, com um lado do deserto.", 	-- >35%
			LOW   = "Eu perdi a hora do jantar!", 				-- >15%
			EMPTY = "Fome... a pior morte!", 			-- <15%
		},
		SANITY = {
			FULL  = "O excelente aroma dos meus pratos me mantem sã.", 			-- >75%
			HIGH  = "Sinto-me um pouco tonto.", 				-- >55%
			MID   = "Estou com um pouco de enxaquecas.", 				-- >35%
			LOW   = "Não consigo pensar direito.", 			-- >15%
			EMPTY = "Não aguento mais essa insanidade!", 	-- <15%
		},
		HEALTH = {
			FULL  = "Estou perfeitamente apto.", 	-- 100%
			HIGH  = "Já tive piores quando picar cebolas.", 	-- >75%
			MID   = "Estou sangrando...", 			-- >50%
			LOW   = "Eu poderia pedir alguma ajuda!", 	-- >25%
			EMPTY = "Acho que este é o fim, velho amigo...", 	-- <25%
		},
		WETNESS = {
			FULL  = "Eu posso sentir os peixes nadando em minha camisa.", 	-- >75%
			HIGH  = "Água vai arruinar os meus pratos perfeitamente preparados!",					-- >55%
			MID   = "Eu deveria secar minhas roupas antes de pegar um resfriado.", 				-- >35%
			LOW   = "Este não é o momento ou lugar para um banho.", 		-- >15%
			EMPTY = "Apenas algumas gotas em mim, nenhum dano.", 				-- <15%
		},
	},
	WALANI = {
		HUNGER = {
			FULL  = "Mmm, isso foi uma refeição feita no céu.", 	-- >75%
			HIGH  = "Eu ainda poderia fazer um lanche.",			-- >55%
			MID   = "comida, comida, comidaaaa!", 	-- >35%
			LOW   = "Meu estômago vai implodir!", 				-- >15%
			EMPTY = "Por favor ... qualquer coisa para comer!", 			-- <15%
		},
		SANITY = {
			FULL  = "Nada como surfar para me manter sã.", 			-- >75%
			HIGH  = "As ondas estão me chamando.", 				-- >55%
			MID   = "Minha cabeça está ficando tonta.", 				-- >35%
			LOW   = "Ugh! Preciso da minha prancha!", 			-- >15%
			EMPTY = "O que são essas ... COISAS?!", 	-- <15%
		},
		HEALTH = {
			FULL  = "Nunca me senti melhor.", 	-- 100%
			HIGH  = "Alguns arranhões, sem grandes confusões.", 	-- >75%
			MID   = "Eu poderia usar alguma cura!", 			-- >50%
			LOW   = "Parece que meu interior simplesmente desistiu de mim.", 	-- >25%
			EMPTY = "Cada osso no meu corpo está quebrado!", 	-- <25%
		},
		WETNESS = {
			FULL  = "Estou completamente encharcado!", 	-- >75%
			HIGH  = "As minhas roupas parecem estar muito molhadas.",					-- >55%
			MID   = "Posso precisar de uma toalha em breve.", 				-- >35%
			LOW   = "Um pouco de água nunca machuca ninguém.", 		-- >15%
			EMPTY = "Vejo uma tempestade vindo!", 				-- <15%
		},
	},
	WOODLEGS = {
		HUNGER = {
			FULL  = "Yarr, que foi uma boa refeição, laddy!", 	-- >75%
			HIGH  = "Eu fico bem cheio em mim barriga.",			-- >55%
			MID   = "É hora para minha refeição diária.", 	-- >35%
			LOW   = "Preciso de comida marujo!", 				-- >15%
			EMPTY = "Eu vou morrer de fome até a morte!", 			-- <15%
		},
		SANITY = {
			FULL  = "Sim, o mar, ela é uma beleza!", 			-- >75%
			HIGH  = "Tempo para uma viagem no mar!", 				-- >55%
			MID   = "Sinto falta do mar...", 				-- >35%
			LOW   = "Não me lembro da última vez que fui navegar.", 			-- >15%
			EMPTY = "Eu sou o capitão pirata empunhando uma espada, não um marinheiro!", 	-- <15%
		},
		HEALTH = {
			FULL  = "Yarr, eu sou um osso duro de roer!", 	-- 100%
			HIGH  = "É que todos vós tem?", 	-- >75%
			MID   = "Eu não estou desistindo ainda!", 			-- >50%
			LOW   = "Woodlegs não é nenhuma galinha!", 	-- >25%
			EMPTY = "Arr! Você ganha, malandrão!", 	-- <25%
		},
		WETNESS = {
			FULL  = "Encharcado até os ossos!", 	-- >75%
			HIGH  = "Eu gosto de água, claro, se permanecer sobre meu barco.",					-- >55%
			MID   = "Da pra lavar minha camisa.", 				-- >35%
			LOW   = "Minhas calças estão molhadas!", 		-- >15%
			EMPTY = "Arr! lá vem uma tempestade.", 				-- <15%
		},
	},
	WILBUR = {
		HUNGER = {
			FULL  = "*Anda por ai a bater palmas de suas mãos*", 	-- >75%
			HIGH  = "*bate as mãos alegremente*",			-- >55%
			MID   = "*esfrega a barriga dele*", 	-- >35%
			LOW   = "*olhar triste e esfrega de barriga*", 				-- >15%
			EMPTY = "OOAOE! *esfrega helly*", 			-- <15%
		},
		SANITY = {
			FULL  = "*Bate na cabeça*", 			-- >75%
			HIGH  = "*Dá os polegares para cima*", 				-- >55%
			MID   = "*Parece assustado*", 				-- >35%
			LOW   = "*Grita assustadoramente*", 			-- >15%
			EMPTY = "OOAOE! OOOAH!", 	-- <15%
		},
		HEALTH = {
			FULL  = "*Libra o peito com ambas as mãos*", 	-- 100%
			HIGH  = "*Peito de libras*", 	-- >75%
			MID   = "*Esfrega ternamente manchas de pelo*", 			-- >50%
			LOW   = "*Bota miseravelmente*", 	-- >25%
			EMPTY = "OAOOE! OOOOAE!", 	-- <25%
		},
		WETNESS = {
			FULL  = "*Espirra*", 	-- >75%
			HIGH  = "*Esfrega os braços juntos*",					-- >55%
			MID   = "Ooo! Ooae!", 				-- >35%
			LOW   = "Oooh?", 		-- >15%
			EMPTY = "Ooae Oooh Oaoa! Ooooe.", 				-- <15%
		},
	},
}