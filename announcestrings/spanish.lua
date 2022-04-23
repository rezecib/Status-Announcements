ANNOUNCE_STRINGS = {
	-- These are not character-specific strings, but are here to ease translation
	-- Note that spaces at the beginning and end of these are important and should be preserved
	_ = {
		getArticle = function(name)
			--This checks if the name starts with a vowel, and uses "an" if so, "a" otherwise
			return string.find(name, "[aA]$") ~= nil and "una" or "un"
		end,
		--Goes into {S} if there are multiple items (plural)
		-- This isn't perfect for making plural even in English, but it's close enough
		S = "s",
		STAT_NAMES = {
			Hunger = "Hambre",
			Sanity = "Cordura",
			Health = "Salud",
			["Log Meter"] = "Medidor de Tronco",
			Wetness = "Humedad",
			Age = "Edad",
			Abigail = "Abigail",
			Inspiration = "Inspiración",
			--Other mod stats won't have translations, but at least we can support these
		},
		ANNOUNCE_ITEM = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "I have 6 papyrus in this chest."
			FORMAT_STRING = "{I_HAVE}{THIS_MANY} {ITEM}{S}{IN_THIS}{CONTAINER}{WITH}{PERCENT}{DURABILITY}.",
			
			-- One of these goes into {I_HAVE}
			I_HAVE = "Tengo ",
			WE_HAVE = "Tenemos ",
			
			-- {THIS_MANY} is a number if multiple, but singular varies a lot by language,
			-- so we use getArticle above to get it
			
			-- {ITEM} is acquired from item.name
			
			-- {S} uses S above
			
			-- Goes into {IN_THIS}, if present
			IN_THIS = " en esto ",
			
			-- {CONTAINER} is acquired from container.name
			
			-- One of these goes into {WITH}
			WITH = " con ", --if it's only one thing
			AND_THIS_ONE_HAS = ", y este tiene ", --if there are multiple, show durability of one
			AND_THIS_ONE_IS = ", y este es ", --if there are multiple, show durability of one
			
			-- {PERCENT} is acquired from the item's durability
			
			-- Goes into {DURABILITY}
			DURABILITY = " durabilidad",
			FRESHNESS = " frescura",
			RECHARGE = " de carga",
			
			-- Optionally added into {PERCENT}
			REMAINING = {
				DURABILITY = "quedan {AMOUNT} usos", -- note that this is unused because durability is only published as a percent to clients
				FRESHNESS = "quedan {AMOUNT} días", -- note that this is unused because perishables only publish percent to clients
				RECHARGE = "{AMOUNT} hasta que se recargue",
			},
			
			-- Optionally added into {ITEM} or {WITH} for thermal stones.
			HEATROCK = {
				"congelado",
				"frío",
				"temperatura ambiente",
				"cálido",
				"caliente",
			}
		},
		ANNOUNCE_RECIPE = {
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "Tengo una maquina de ciencia preparada y lista para fabricar" -> pre-built
			-- "Fabricare un hacha." -> known and have ingredients
			-- "Alguien podria fabricarme un motor de alquimia? necesitaria una maquina de ciencia." -> not known
			-- "Necesitamos más bastidores de secado." -> known but don't have ingredients
			FORMAT_STRING = "{START_Q}{TO_DO}{THIS_MANY} {ITEM}{S}{PRE_BUILT}{END_Q}{I_NEED}{A_PROTO}{PROTOTYPER}{FOR_IT}.",
			
			--{START_Q} is for languages that match ? at both ends
			START_Q = "¿", --English doesn't do that
			
			--One of these goes into {TO_DO}
			I_HAVE = "Tengo ", --for pre-built
			ILL_MAKE = "Voy a fabricar ", --for known recipes where you have ingredients
			CAN_SOMEONE = "Alguien podría fabricarme ", --for unknown recipes
			WE_NEED = "Necesitamos más", --for known recipes where you don't have ingredients
			
			--{THIS_MANY} uses getArticle above to get the right article ("a", "an")
			
			--{ITEM} comes from the recipe.name
			
			--{S} uses S above

			--Goes into {PRE_BUILT}
			PRE_BUILT = " preparado y listo para fabricar",
			
			--This goes into {END_Q} if it's a question
			END_Q = "?",
			
			--Goes into {I_NEED}
			I_NEED = " Necesitaría ",
			
			--Goes into {FOR_IT}
			FOR_IT = " para ello",
		},
		ANNOUNCE_INGREDIENTS = {
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "Necesito 2 piedras más cortadas y una máquina de ciencia para hacer un motor de alquimia."
			FORMAT_NEED = "Necesito {NUM_ING} más {INGREDIENT}{S}{AND}{A_PROTO}{PROTOTYPER} para fabricar {A_REC} {RECIPE}.",
			
			--If a prototyper is needed, goes into {AND}
			AND = " y ",
			
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "I have enough twigs to make 9 bird traps, but I need a science machine."
			FORMAT_HAVE = "Tengo suficiente {INGREDIENT}{ING_S} para fabricar {A_REC} {RECIPE}{REC_S}{BUT_NEED}{A_PROTO}{PROTOTYPER}.",
			
			--If a prototyper is needed, goes into {BUT_NEED}
			BUT_NEED = ", pero necesito ",
		},
		ANNOUNCE_SKIN = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "I have the Tragic Torch skin for the Torch"
			FORMAT_STRING = "Tengo la {SKIN} skin para la {ITEM}.",
			
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
				DEFAULT = "Estoy",
				BEAST = "La bestia está", --for Werebeaver
			},
			
			--{TEMPERATURE} is picked from this
			TEMPERATURE = {
				BURNING = "demasiado caliente!",
				HOT = "casi sobrecalentandome!",
				WARM = "un poco acalorado.",
				GOOD = "una temperatura confortable",
				COOL = "un poco de frio",
				COLD = "casi congelado",
				FREEZING = "me congelo!",
			},
		},
		ANNOUNCE_SEASON = "Quedan {DAYS_LEFT} días en {SEASON}.",
		ANNOUNCE_GIFT = {
			CAN_OPEN = "Tengo un regalo y estoy apunto de abrirlo!",
			NEED_SCIENCE = "Necesitaria ciencia adicional para poder abrir este regalo",
		},
		ANNOUNCE_HINT = "Anuncio",
	},
	-- Everything below is character-specific
	UNKNOWN = {
		HUNGER = {
			FULL  = "Estoy completamente lleno!", 	-- >75%
			HIGH  = "Estoy bastante lleno",			-- >55%
			MID   = "estoy sintiendo hambre", 	-- >35%
			LOW   = "Tengo hambre", 				-- >15%
			EMPTY = "Estoy hambriento!", 			-- <15%
		},
		SANITY = {
			FULL  = "Mi cerebro está en óptimas condiciones!", 			-- >75%
			HIGH  = "Me siento realmente bien!", 				-- >55%
			MID   = "Me estoy poniendo un poco ansioso.", 				-- >35%
			LOW   = "Me siento un poco loco aquí!", 			-- >15%
			EMPTY = "AAAAHHHH! ¡Atrás, bestias de sombra!", 	-- <15%
		},
		HEALTH = {
			FULL  = "Estoy en perfecta salud!", 	-- 100%
			HIGH  = "Estoy un poco arañado.", 	-- >75%
			MID   = "Estoy herido", 			-- >50%
			LOW   = "Estoy gravemente herido!", 	-- >25%
			EMPTY = "Estoy mortalmente herido!", 	-- <25%
		},
		WETNESS = {
			FULL  = "Estoy completamente empapado!", 	-- >75%
			HIGH  = "Estoy empapado!",					-- >55%
			MID   = "Estoy muy mojado!", 				-- >35%
			LOW   = "Estoy un poco mojado", 		-- >15%
			EMPTY = "Estoy bastante seco", 				-- <15%
		},
		BOAT = {
			FULL  = "¡Este barco está en perfectas condiciones!",		-- >85%
			HIGH  = "Esta embarcación todavía está en condiciones de navegar.",			-- >65%
			MID   = "Este barco está un poco golpeado.",			-- >35%
			LOW   = "¡Este barco necesita reparaciones urgentes!",	-- >0.01%
			EMPTY = "¡Este barco se está hundiendo!",					-- <0.01%
		},
	},
	WILSON = {
		HUNGER = {
			FULL  = "Estoy lleno!",
			HIGH  = "No necesito comer",
			MID   = "Podría comer un poco",
			LOW   = "Estoy realmente hambriento!",
			EMPTY = "Necesito... comida...",
		},
		SANITY = {
			FULL  = "Tan sano como pueda ser!",
			HIGH  = "Estare bien.",
			MID   = "Mi cabeza duele...",
			LOW   = "Qu-- Qué está pasando?",
			EMPTY = "¡Ayuda! Esas cosas me van a comer !!",
		},
		HEALTH = {
			FULL  = "En buen estado físico!",
			HIGH  = "Estoy herido, pero puedo seguir adelante.",
			MID   = "Yo ... creo que necesito atención médica.",
			LOW   = "He perdido mucha sangre...",
			EMPTY = "Yo.. Creo que no podre lograrlo..",
		},
		WETNESS = {
			FULL  = "He llegado a mi punto de saturación!",
			HIGH  = "Me estoy empapando!",
			MID   = "Mi ropa parece ser permeable.",
			LOW   = "Oh, H2O.",
			EMPTY = "Estoy moderadamente seco.",
		},
	},
	WILLOW = {
		HUNGER = {
			FULL  = "Me engordaré si no dejo de comer.",
			HIGH  = "Agradablemente llena.",
			MID   = "Mi fuego necesita un poco de combustible.",
			LOW   = "Ugh, me muero de hambre aquí!",
			EMPTY = "Ya estoy prácticamente piel y huesos!",
		},
		SANITY = {
			FULL  = "Creo que he tenido suficiente fuego por ahora.",
			HIGH  = "¿Acabo de ver a Bernie caminar? ... no importa.",
			MID   = "Me siento más fría de lo que debería ...",
			LOW   = "Bernie, ¿por qué me siento tan fría?",
			EMPTY = "Bernie, protégeme de esas cosas horribles!",
		},
		HEALTH = {
			FULL  = "Ningun rasguño en mí!",
			HIGH  = "Tengo un rasguño o dos. Probablemente debería quemarlos.",
			MID   = "Estos cortes están más allá de la quemadura, necesito un médico ...",
			LOW   = "Me siento débil ... podría ... morir.",
			EMPTY = "Mi fuego está casi fuera ...",
		},
		WETNESS = {
			FULL  = "Ugh, esta lluvia es la PEOR!",
			HIGH  = "¡Odio toda esta agua!",
			MID   = "Esta lluvia es demasiado",
			LOW   = "Uh oh, si esta lluvia continúa ...",
			EMPTY = "No hay suficiente lluvia para apagar el fuego.",
		},
	},
	WOLFGANG = {
		HUNGER = {
			FULL  = "Wolfgang está lleno y poderoso!",
			HIGH  = "Wolfgang debe comer y volverse más poderoso!",
			MID   = "Wolfgang podría comer más.",
			LOW   = "Wolfgang tiene un agujero en el vientre.",
			EMPTY = "Wolfgang necesita comida! ¡AHORA!",
		},
		SANITY = {
			FULL  = "Wolfgang se siente bien de la cabeza!",
			HIGH  = "La cabeza de Wolfgang se siente divertida.",
			MID   = "Wolfgang le duele la cabeza",
			LOW   = "Wolfgang ver monstruo de miedo...",
			EMPTY = "Monstruos aterradores por todas partes!",
		},
		HEALTH = {
			FULL  = "Wolfgang no necesita arreglos!",
			HIGH  = "Wolfgang necesita poco arreglo",
			MID   = "Wolfgang Adolorido",
			LOW   = "Wolfgang necesita mucha ayuda para no sentirse herido.",
			EMPTY = "Wolfgang podría morir...",
		},
		WETNESS = {
			FULL  = "Wolfgang tal vez ahora está hecho de agua!",
			HIGH  = "Es como sentarse en el estanque.",
			MID   = "A Wolfgang no le gusta la hora del baño.",
			LOW   = "Hora del agua",
			EMPTY = "Wolfgang está seco.",
		},
	},
	WENDY = {
		HUNGER = {
			FULL  = "Ninguna cantidad de comida llenará el agujero en mi corazón..",
			HIGH  = "Estoy llena, pero todavía tengo hambre por algo que ningún amigo puede proporcionar..",
			MID   = "No estoy vacía, pero no llena. Extraño..",
			LOW   = "Estoy llena de vacío.",
			EMPTY = "He encontrado la forma más lenta de morir. Inanición.",
		},
		SANITY = {
			FULL  = "Mis pensamientos son muy claros.",
			HIGH  = "Mis pensamientos se vuelven turbios.",
			MID   = "Mis pensamientos son febriles...",
			LOW   = "¿Los ves, Abigail? Estos demonios pueden permitirme unirme a ustedes, pronto.",
			EMPTY = "Llevenme con Abigail, criaturas de la oscuridad y de la noche!",
		},
		HEALTH = {
			FULL  = "Estoy bien, pero estoy segura de que volveré a lastimarme.",
			HIGH  = "Siento dolor, pero no mucho.",
			MID   = "La vida trae dolor, pero no estoy acostumbrada a esto..",
			LOW   = "Sangrar... sería fácil...",
			EMPTY = "Estaré con Abigail, pronto...",
		},
		WETNESS = {
			FULL  = "Un apocalipsis de agua!",
			HIGH  = "Una eternidad de humedad y pena.",
			MID   = "Empapada y triste.",
			LOW   = "Tal vez esta agua llenará el agujero en mi corazón.",
			EMPTY = "Mi piel es tan seca como mi corazón.",
		},
		ABIGAIL = {
			FULL  = "¡Abigail es más brillante que nunca!",
			HIGH  = "Abigail brilla intensamente.",
			MID   = "Abigail comienza a desvanecerse ...",
			LOW   = "¡Ten cuidado, Abigail! ¡Ya casi no puedo verte!",
			EMPTY = "¡No me dejes, Abigail!",
		},
	},
	WX78 = {
		HUNGER = {
			FULL  = "ESTADO DEL COMBUSTIBLE: CAPACIDAD MAXIMA",
			HIGH  = "ESTADO DEL COMBUSTIBLE: ALTO",
			MID   = "ESTADO DE COMBUSTIBLE: ACEPTABLE",
			LOW   = "ESTADO DEL COMBUSTIBLE: BAJO",
			EMPTY = "ESTADO DEL COMBUSTIBLE: CRITICO",
		},
		SANITY = {
			FULL  = "ESTADO DE CPU: COMPLETAMENTE OPERATIVO",
			HIGH  = "ESTADO DE CPU: FUNCIONAL",
			MID   = "ESTADO DE CPU: DAÑADO",
			LOW   = "ESTADO DE CPU: ERROR INMINENTE",
			EMPTY = "ESTADO DE CPU: FALLAS MÚLTIPLES DETECTADAS",
		},
		HEALTH = {
			FULL  = "ESTADO DEL CHASIS: CONDICIÓN PERFECTA",
			HIGH  = "ESTADO DEL CHASIS: CRACK DETECTADO",
			MID   = "ESTADO DEL CHASIS: DAÑO MODERADO",
			LOW   = "ESTADO DEL CHASIS: FALTA DE INTEGRIDAD",
			EMPTY = "ESTADO DEL CHASIS: NO FUNCIONAL",
		},
		WETNESS = {
			FULL  = "ESTADO DE HUMEDAD: CRITICO",
			HIGH  = "ESTADO DE HUMEDAD: CERCA DE CRÍTICO",
			MID   = "ESTADO DE HUMEDAD: INACEPTABLE",
			LOW   = "ESTADO DE HUMEDAD: TOLERABLE",
			EMPTY = "ESTADO DE HUMEDAD: ACEPTABLE",
		},
	},
	WICKERBOTTOM = {
		HUNGER = {
			FULL  = "Debería estar investigando, no llenandome a mí misma.",
			HIGH  = "Llena, pero no hinchada.",
			MID   = "Estoy sintiendo un poco de hambre.",
			LOW   = "Esta bibliotecaria necesita comida, me temo!",
			EMPTY = "¡Si no consigo comida inmediatamente, me moriré de hambre!",
		},
		SANITY = {
			FULL  = "Aquí no hay nada irrazonable.",
			HIGH  = "Creo que tengo un poco de dolor de cabeza.",
			MID   = "Estas migrañas son insoportables.",
			LOW   = "Ya no estoy seguro de que esas cosas sean imaginarias!",
			EMPTY = "¡Ayuda! ¡Estas abominaciones insondables son hostiles!",
		},
		HEALTH = {
			FULL  = "Estoy tan en forma como se puede esperar de mi edad!",
			HIGH  = "Unos moretones, pero nada importante.",
			MID   = "Mis necesidades médicas están aumentando.",
			LOW   = "Sin tratamiento, este será mi fin.",
			EMPTY = "Necesito atención médica inmediata!",
		},
		WETNESS = {
			FULL  = "Empapada positivamente!",
			HIGH  = "Estoy mojada, mojada, mojada!",
			MID   = "Me pregunto cuál es el punto de saturación de mi cuerpo...",
			LOW   = "La capa de agua comienza a acumularse.",
			EMPTY = "Estoy suficientemente desprovista de humedad.",
		},
	},
	WOODIE = {
		HUMAN = {
			HUNGER = {
				FULL  = "Todo lleno!",
				HIGH  = "Todavía lo suficientemente lleno como para cortar.",
				MID   = "Podría necesitar un bocadillo, eh!",
				LOW   = "Toca el timbre de la cena!",
				EMPTY = "Estoy hambriento!",
			},
			SANITY = {
				FULL  = "Todo bien en el frente norte!",
				HIGH  = "Todavía bien en el noggin.",
				MID   = "Creo que necesito una siesta, eh!",
				LOW   = "Quítate ya hosterías de pesadilla!",
				EMPTY = "Todos los miedos son reales, y duelen!",
			},
			HEALTH = {
				FULL  = "Ajustado como un silbato!",
				HIGH  = "Lo que no te mata te hace más fuerte, eh?",
				MID   = "Podría usar un poco de salubridad.",
				LOW   = "Eso está empezando a doler, eh...",
				EMPTY = "Ponme a descansar ... en el bosque ...",
			},
			WETNESS = {
				FULL  = "Demasiado mojado incluso para cortar, ¿eh?",
				HIGH  = "Plaid no es suficiente para este tipo de lluvia.",
				MID   = "Me estoy mojando bastante, eh?",
				LOW   = "Plaid está caliente, incluso cuando está mojado.",
				EMPTY = "Apenas una gota en mí, eh?",
			},
			["LOG METER"] = {
				FULL  = "Siempre podría tener más troncos, pero no en mi vientre en este momento, eh?",	-- > 90%
				HIGH  = "Tengo ganas de algo twiggy.",						-- > 70%
				MID   = "Los troncos se ven muy sabrosos.",									-- > 50%
				LOW   = "Puedo sentir la maldición que viene.",									-- > 25%
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
				FULL  = "Los ojos de la bestia están muy abiertos y alertas.",
				HIGH  = "La bestia parpadea en las sombras.",
				MID   = "La bestia se vuelve a mirar algo que no estaba allí.",
				LOW   = "La bestia tiembla y sus ojos tiemblan.",
				EMPTY = "La bestia gruñe y parece ser cazada por las sombras que se multiplican.",
			},
			HEALTH = {
				FULL  = "La bestia corretea vigorosamente.",
				HIGH  = "La bestia tiene algunos rasguños.",
				MID   = "La bestia lame sus heridas.",
				LOW   = "La bestia acuna su brazo.",
				EMPTY = "La bestia cojea patéticamente.",
			},
			WETNESS = {
				FULL  = "El pelaje de la bestia está completamente empapado.",
				HIGH  = "La bestia deja un rastro de pequeños charcos.",
				MID   = "El pelaje de la bestia está un poco mojado.",
				LOW   = "La bestia gotea un poco.",
				EMPTY = "El pelaje de la bestia es seco.",
			},
			["LOG METER"] = {
				FULL  = "La bestia parece casi humana.",				-- > 90%
				HIGH  = "La bestia mastica un bocado de madera.",		-- > 70%
				MID   = "La bestia mastica una ramita.",					-- > 50%
				LOW   = "La bestia mira vorazmente esos árboles.",	-- > 25%
				EMPTY = "La bestia parece hueca.",						-- < 25%
			},
		},
	},
	WES = {
		HUNGER = {
			FULL  = "*palmaditas en el estómago*",
			HIGH  = "*palmaditas en el estómago*",
			MID   = "*usa sus manos para abrir su boca*",
			LOW   = "*usa sus manos para abrir su boca, con los ojos bien abiertos*",
			EMPTY = "*Agarra el estómago hundido con una mirada de desesperación.*",
		},
		SANITY = {
			FULL  = "*saluda*",
			HIGH  = "*Pulgares hacia arriba*",
			MID   = "*frota los templos*",
			LOW   = "*mira alrededor frenéticamente*",
			EMPTY = "*Cuna su cabeza, meciéndose hacia adelante y hacia atrás.*",
		},
		HEALTH = {
			FULL  = "*palmaditas a su corazón*",
			HIGH  = "*siente el pulso, pulgar arriba*",
			MID   = "*Mueve la mano alrededor del brazo, como si lo envolviera.*",
			LOW   = "*Cuna su brazo*",
			EMPTY = "*se balancea dramáticamente, luego se cae*",
		},
		WETNESS = {
			FULL  = "*frenéticamente nada hacia arriba*",
			HIGH  = "*nada hacia arriba*",
			MID   = "*mira miserablemente el cielo*",
			LOW   = "*refugia su cabeza bajo sus brazos*",
			EMPTY = "*sonrie, sosteniendo paraguas invisible*",
		},
	},
	WAXWELL = {
		HUNGER = {
			FULL  = "¡He tenido todo un festín!",
			HIGH  = "Estoy saciado, pero no en exceso.",
			MID   = "Un bocadillo podría estar en orden.",
			LOW   = "Estoy vacío por dentro.",
			EMPTY = "¡No! ¡No gané mi libertad solo para morirme de hambre aquí!",
		},
		SANITY = {
			FULL  = "Apuesto, como pueda seguir siendo.",
			HIGH  = "Mi intelecto normalmente inquebrantable parece estar... vacilando.",
			MID   = "Uf. Me duele la cabeza.",
			LOW   = "Necesito aclarar mi mente, estoy empezando a ver a... Ellos.",
			EMPTY = "¡Ayuda! Estas sombras son bestias reales, ¡¿sabes?!",
		},
		HEALTH = {
			FULL  = "Estoy absolutamente ileso.",
			HIGH  = "Es sólo un rasguño.",
			MID   = "Puede que necesite un vendaje.",
			LOW   = "Este no es mi Canto del Cisne, pero estoy cerca.",
			EMPTY = "¡No! ¡No escapé solo para morir aquí!",
		},
		WETNESS = {
			FULL  = "Más húmedo que el agua misma.",
			HIGH  = "No creo que alguna vez vuelva a estar seco de nuevo.",
			MID   = "¡Esta agua arruinará mi traje!",
			LOW   = "La humedad no es elegante...",
			EMPTY = "Seco y Apuesto.",
		},
	},
	WEBBER = {
		HUNGER = {
			FULL  = "Nuestros dos estómagos están llenos!",				-- >75%
			HIGH  = "Podríamos comer un mordisco más.",					-- >55%
			MID   = "Creemos que es hora de almorzar!",			-- >35%
			LOW   = "Nos comeríamos las sobras de mamá en este punto...",-- >15%
			EMPTY = "Nuestros estómagos están vacíos!",						-- <15%
		},
		SANITY = {
			FULL  = "Nos sentimos bien descansados!",							-- >75%
			HIGH  = "Una siesta no haría daño.",							-- >55%
			MID   = "Nos duele la cabeza...",							-- >35%
			LOW   = "Cuándo fue la última vez que tuvimos una siesta?!",	-- >15%
			EMPTY = "No te tenemos miedo, cosas temibles!",		-- <15%
		},
		HEALTH = {
			FULL  = "Ni siquiera tenemos un rasguño!",				-- 100%
			HIGH  = "Vamos a necesitar una curita.",				-- >75%
			MID   = "Vamos a necesitar más que una curita...",	-- >50%
			LOW   = "Nos duele el cuerpo...",							-- >25%
			EMPTY = "No queremos morir aún...",					-- <25%
		},
		WETNESS = {
			FULL  = "Waah, estamos empapados!", 						-- >75%
			HIGH  = "Nuestro pelaje está empapado!",							-- >55%
			MID   = "Estamos mojados", 									-- >35%
			LOW   = "Estamos desagradablemente húmedos.", 					-- >15%
			EMPTY = "Nos gusta jugar en los charcos.", 					-- <15%
		},
	},
	WATHGRITHR = {
		HUNGER = {
			FULL  = "Tengo hambre de batalla, no de carne!", 				-- >75%
			HIGH  = "Estoy lo suficientemente saciada para la batalla.",					-- >55%
			MID   = "Podría tener un bocadillo de carne.", 					-- >35%
			LOW   = "Añoro un banquete!", 							-- >15%
			EMPTY = "Me moriré de hambre sin carne!", 				-- <15%
		},
		SANITY = {
			FULL  = "No temo a ningún mortal!", 							-- >75%
			HIGH  = "Me sentiré mejor en la batalla!", 					-- >55%
			MID   = "Mi mente divaga...", 							-- >35%
			LOW   = "Estas sombras pasan a través de mi lanza...", -- >15%
			EMPTY = "Atrás, bestias de la oscuridad!", 				-- <15%
		},
		HEALTH = {
			FULL  = "Mi piel es impenetrable!", 					-- 100%
			HIGH  = "Es solo una herida carnosa", 					-- >75%
			MID   = "Estoy herida, pero todavía puedo luchar..", 			-- >50%
			LOW   = "Sin ayuda, estaré en Valhalla pronto...", 	-- >25%
			EMPTY = "Mi saga llega a su fin...", 					-- <25%
		},
		WETNESS = {
			FULL  = "Estoy completamente empapada!", 					-- >75%
			HIGH  = "¡Un guerrero tan mojado no puede luchar!",				-- >55%
			MID   = "¡Mi armadura se oxidará!", 							-- >35%
			LOW   = "No necesitaré un baño después de esto.", 				-- >15%
			EMPTY = "Lo suficientemente seco para la batalla!", 						-- <15%
		},
		INSPIRATION = {
			FULL  = "¡Mi voz es lo suficientemente fuerte para tres canciones!", 			-- >5/6, 3 songs
			HIGH  = "¡Podría cantar un dueto yo solo!",						-- >3/6, 2 songs
			MID   = "¡Estoy listo para cantar!", 									-- >1/6, 1 song
			LOW   = "Debo calentar mi voz ... ¡en el fragor de la batalla!", 	-- <1/6
		},
	},
	WINONA = {
		HUNGER = {
			FULL  = "Conseguí mi comida cuadrada para el día.",
			HIGH  = "Siempre tengo espacio para un poco más de comida!",
			MID   = "Puedo tomar mi almuerzo ya?",
			LOW   = "Me estoy quedando sin combustible, jefe.",
			EMPTY = "A la fábrica le faltará trabajo si no consigo algo de comida!",
		},
		SANITY = {
			FULL  = "Tan cuerda como nunca lo seré.",
			HIGH  = "Todo está bien bajo el capó!",
			MID   = "Creo que tengo algunos tornillos sueltos...",
			LOW   = "Mi mente está en bancarrota, yo debería ser quien la arregle.",
			EMPTY = "¡Esto es una pesadilla! ¡Decir ah! Realmente",
		},
		HEALTH = {
			FULL  = "Estoy tan sano como un caballo!",
			HIGH  = "Eh, lo arreglaré.",
			MID   = "No puedo rendirme aún.",
			LOW   = "Puedo cobrar mi pensión de trabajador todavía...?",
			EMPTY = "Creo que mi turno ha terminado...",
		},
		WETNESS = {
			FULL  = "No puedo trabajar en estas condiciones!",
			HIGH  = "Mi mono está recogiendo agua!",
			MID   = "Alguien debería poner un cartel de piso mojado.",
			LOW   = "Siempre es bueno mantenerse hidratado en el trabajo.",
			EMPTY = "Esto no es nada'.",
		},
	},
	WARLY = {
		HUNGER = {
			FULL  = "Mi cocina será mi muerte!", 	-- >75%
			HIGH  = "Creo que ya he tenido suficiente, por ahora.",			-- >55%
			MID   = "Hora de cenar con un lado del desierto.", 	-- >35%
			LOW   = "¡Me perdí la hora de la cena!", 				-- >15%
			EMPTY = "Hambre ... la peor muerte!", 			-- <15%
		},
		SANITY = {
			FULL  = "El excelente aroma de mis platos me mantiene sano.", 			-- >75%
			HIGH  = "Me siento un poco mareado.", 				-- >55%
			MID   = "No puedo pensar con claridad.", 				-- >35%
			LOW   = "Los susurros ... ayúdenme!", 			-- >15%
			EMPTY = "No puedo soportar más esta locura!", 	-- <15%
		},
		HEALTH = {
			FULL  = "Estoy perfectamente en forma.", 	-- 100%
			HIGH  = "He tenido peores al picar cebollas.", 	-- >75%
			MID   = "Estoy sangrando...", 			-- >50%
			LOW   = "Podría usar un poco de ayuda!", 	-- >25%
			EMPTY = "Supongo que este es el final, viejo amigo...", 	-- <25%
		},
		WETNESS = {
			FULL  = "Puedo sentir los peces nadando en mi camisa.", 	-- >75%
			HIGH  = "El agua arruinará mis platos perfectamente cocinados!",					-- >55%
			MID   = "Debería secarme la ropa antes de resfriarme.", 				-- >35%
			LOW   = "Este no es el momento o lugar para un baño.", 		-- >15%
			EMPTY = "Solo unas gotas sobre mi, no hay daño.", 				-- <15%
		},
	},
	WALANI = {
		HUNGER = {
			FULL  = "Mmmm, esa fue una comida hecha en el cielo..", 	-- >75%
			HIGH  = "Todavía podría ir a comer algo.",			-- >55%
			MID   = "Comida, comida, comida!", 	-- >35%
			LOW   = "Mi estómago implosionará!", 				-- >15%
			EMPTY = "Por favor ... cualquier cosa para comer!", 			-- <15%
		},
		SANITY = {
			FULL  = "Nada como navegar para mantenerme cuerdo.", 			-- >75%
			HIGH  = "Las olas me están llamando.", 				-- >55%
			MID   = "Mi cabeza se está mareando.", 				-- >35%
			LOW   = "Ugh! ¡Necesito mi tabla de surf!", 			-- >15%
			EMPTY = "¡¿Qué son esas COSAS?!", 	-- <15%
		},
		HEALTH = {
			FULL  = "Nunca me sentí mejor.", 	-- 100%
			HIGH  = "Unos pocos arañazos, sin grandes problemas.", 	-- >75%
			MID   = "¡Podría usar algo de curación!", 			-- >50%
			LOW   = "Se siente como si mi interior simplemente se rindiera sobre mí.", 	-- >25%
			EMPTY = "¡Cada hueso en mi cuerpo está roto!", 	-- <25%
		},
		WETNESS = {
			FULL  = "Estoy completamente empapado!", 	-- >75%
			HIGH  = "Mi ropa parece estar bastante mojada.",					-- >55%
			MID   = "Puede que necesite una toalla pronto.", 				-- >35%
			LOW   = "Un poco de agua nunca hace daño a nadie.", 		-- >15%
			EMPTY = "Veo una tormenta que se avecina!", 				-- <15%
		},
	},
	WOODLEGS = {
		HUNGER = {
			FULL  = "Yarr, esa fue una buena comida, señora!", 	-- >75%
			HIGH  = "Estoy bastante lleno de mi vientre.",			-- >55%
			MID   = "Es tiempo para mi comida diaria.", 	-- >35%
			LOW   = "¡Sí! Vosotros, ¿dónde estara la comida?", 				-- >15%
			EMPTY = "Me muero de hambre!", 			-- <15%
		},
		SANITY = {
			FULL  = "Sí, el mar, ella es tan bella!", 			-- >75%
			HIGH  = "Tiempo para un viaje en el mar!", 				-- >55%
			MID   = "Me extraño el mar", 				-- >35%
			LOW   = "No recuerdo la última vez que fui a navegar.", 			-- >15%
			EMPTY = "¡Soy un capitán pirata que maneja un machete, no un lubber de tierra!", 	-- <15%
		},
		HEALTH = {
			FULL  = "Yarr, ¡Seré una tuerca difícil de romper!", 	-- 100%
			HIGH  = "Eso es todo lo que tienes?", 	-- >75%
			MID   = "¡No me estoy rindiendo todavía!", 			-- >50%
			LOW   = "Las patas de madera no son ningún pollo!", 	-- >25%
			EMPTY = "Arr! Usted gana, scallywag!", 	-- <25%
		},
		WETNESS = {
			FULL  = "Me empapé hasta los huesos!", 	-- >75%
			HIGH  = "Me gusta el agua para quedarme en mi bote.",					-- >55%
			MID   = "Me saco la blusa pirata 'sobre el agua.", 				-- >35%
			LOW   = "¡Se me empapan los pitos!", 		-- >15%
			EMPTY = "Arr Una tormenta se está gestando.", 				-- <15%
		},
	},
	WILBUR = {
		HUNGER = {
			FULL  = "*salta aplaudiendo sus manos*", 	-- >75%
			HIGH  = "*aplaude alegremente *",			-- >55%
			MID   = "*se frota el vientre *", 	-- >35%
			LOW   = "*se ve triste y se frota la barriga*", 				-- >15%
			EMPTY = "OOAOE! *se frota la barriga*", 			-- <15%
		},
		SANITY = {
			FULL  = "*golpes en la cabeza*", 			-- >75%
			HIGH  = "*da el pulgar arriba*", 				-- >55%
			MID   = "*se ve asustado*", 				-- >35%
			LOW   = "*grita inquietantemente*", 			-- >15%
			EMPTY = "OOAOE! OOOAH!", 	-- <15%
		},
		HEALTH = {
			FULL  = "*libera su pecho con ambas manos*", 	-- 100%
			HIGH  = "*libera su pecho*", 	-- >75%
			MID   = "*Se frota con ternura los parches de piel faltantes*", 			-- >50%
			LOW   = "*cojea miserablemente*", 	-- >25%
			EMPTY = "OAOOE! OOOOAE!", 	-- <25%
		},
		WETNESS = {
			FULL  = "*estornuda*", 	-- >75%
			HIGH  = "*se frota los brazos*",					-- >55%
			MID   = "Ooo! Ooae!", 				-- >35%
			LOW   = "Oooh?", 		-- >15%
			EMPTY = "Ooae Oooh Oaoa! Ooooe.", 				-- <15%
		},
	},
	WURT = {
		HUNGER = {
			FULL  = "Gluf, no más.",
			HIGH  = "No tener hambre, flop.",
			MID   = "Poder comer un poco más.",
			LOW   = "¡Realmente querer comida!",
			EMPTY = "¡Realmente realmente hambrienta!",
		},
		SANITY = {
			FULL  = "¡Muy feliz!",
			HIGH  = "Cabeza estar bien, flop.",
			MID   = "Gluaj, cabeza doler.",
			LOW   = "¡Sombras tenebrosas estar viniendo!",
			EMPTY = "¡¡Glgrrr, pesadillas aterradoras!!",
		},
		HEALTH = {
			FULL  = "¡Sentirme estupenda, flop!",
			HIGH  = "¡Sentirse bien!",
			MID   = "Necesitar ayuda, faltan escamas...",
			LOW   = "*Sollozar* Es TÁN doloroso...",
			EMPTY = "Yo... necesito... ayuda...",
		},
		WETNESS = {
			FULL  = "¡Aaah, salpicar-chapotear!",
			HIGH  = "¡Sentirse bien en las escamas!",
			MID   = "¡La gente Tritón ama el agua, flop!",
			LOW   = "Ahh... ¡humedecida sentirse mejor, flop!",
			EMPTY = "Demasiado seco, glup.",
		}
	},
	WORTOX = {
		HUNGER = {
			FULL  = "¡Qué mortal de mi parte tener el estómago tan lleno!",
			HIGH  = "¡Estoy bien alimentado para un buen truco! ¡Jyuyu!",
			MID   = "En necesidad de un bocado... tan mortal.",
			LOW   = "¡Me encantaría una sabrosa alma! Guardaré los truquillos para más tarde...",
			EMPTY = "¡Mi ansia de almas se ha vuelto voraz!",
		},
		SANITY = {
			FULL  = "Tengo la mente despejada... ¡Los tiempos de diversión se acercan! ¡Jyuyu!",
			HIGH  = "¿Quizás podría chupar algunas almas para mantener la cabeza despejada?",
			MID   = "Todos mis saltos me han causado bastante dolor de cabeza...",
			LOW   = "¡Envidio los truquillos de estas sombras! ¡Jyuyu!",
			EMPTY = "¡Mi mente habita un nuevo plano de pura demencia!",
		},
		HEALTH = {
			FULL  = "¡Estoy de perfecto humor para una buena travesura!",
			HIGH  = "¡Solo es un rasguño, nada que un alma no pueda restaurar!",
			MID   = "Unas cuantas almas para cerrar estas heridas... ¡Jyuyu!",
			LOW   = "Mi propia alma se debilita...",
			EMPTY = "¡Mi alma pronto dejará de ser mía! Jyuyu...",
		},
		WETNESS = {
			FULL  = "¡¡ESTOY SUMERGIDO!!",
			HIGH  = "¡Soy el diablillo más empapado!",
			MID   = "Hay un olor a diablillo húmedo en mi futuro.",
			LOW   = "¡El mundo me está dando una ducha!",
			EMPTY = "¡Debería vigilar el cielo, si deseo permanecer seco!",
		}
	},
	WANDA = {
		HUNGER = {
			FULL  = "¡Necesito tiempo para digerir toda esta comida!",							-- >75%
			HIGH  = "Todavía estoy satisfecha de lo de antes. O después.",						-- >55%
			MID   = "¡Tengo el suficiente tiempo para tomar un refrigerio!", 					-- >35%
			LOW   = "¡Mi estómago es su propio paso del tiempo!", 						-- >15%
			EMPTY = "¡El tiempo rápidamente me alcanzará si no como en éste preciso instante!", 	-- <15%
		},
		SANITY = {
			FULL  = "¡Todo parece normal en esta línea de tiempo!", 							-- >75%
			HIGH  = "¡Me siento lo suficientemente grandiosa como para dar unos cuantos saltos cuánticos!",							-- >55%
			MID   = "¡Si no llevara relojes, ya no sabría más qué hora es!",	-- >35%
			LOW   = "¡La realidad se está rompiendo en pedazos!", 											-- >15%
			EMPTY = "¡Ustedes nunca me atraparán! ¡Ni en pasado, presente o futuro!", 					-- <15%
		},
		HEALTH = {
			FULL  = "¡Dicen que tus 20s son tus mejores años después de todo!",					 	-- 100%
			HIGH  = "¡Todavía joven y llena de vigor!", 										-- >75%
			MID   = "¡Espera un tic! ¡Necesito un momento para recuperarme!", 							-- >50%
			LOW   = "¡¡Tan solo necesito más tiempo!!", 												-- >25%
			EMPTY = "¡Los granitos de mi reloj de arena están a punto de agotarse!",					 	-- <25%
		},
		WETNESS = {
			FULL  = "El tiempo es precisamente como esta lluvia. ¡¡No se detiene!!", 								-- >75%
			HIGH  = "Si esto sigue así... ¡Mis relojes de bolsillo se oxidarán!",						-- >55%
			MID   = "¿Cuántos años habrán pasado desde que estuve así de empapada?", 						-- >35%
			LOW   = "¡Oh, caray! ¡Necesito encontrar algún refugio para esta lluvia!", 					-- >15%
			EMPTY = "¡Un poco de lluvia no es nada comparado con las complejidades de los viajes temporales!", 	-- <15%
		}
	},
	WALTER = {
		HUNGER = {
			FULL  = "¡Un Pionero Pino siempre sale con el estómago lleno!", 	-- >75%
			HIGH  = "Debería preparar un bocadillo para nuestra próxima caminata.",			-- >55%
			MID   = "Espero haber empacado unos cuantos bocadillos en Woby...", 				-- >35%
			LOW   = "¡Desearía que pudiéramos comer unos S'mores!", 						-- >15%
			EMPTY = "¡No te preocupes amiga, encontraremos algo que comer pronto!", 		-- <15%
		},
		SANITY = {
			FULL  = "¡Mi instinto pionero está mejor que nunca!", 	-- >75%
			HIGH  = "¿Qué tal una historia para calmar los nervios?", 	-- >55%
			MID   = "¿Escuchas los susurros también Woby?", 		-- >35%
			LOW   = "O-oye Woby, ¡¿viste eso?!", 			-- >15%
			EMPTY = "¡¡Los monstruos de mis historias son REALES!!", 	-- <15%
		},
		HEALTH = {
			FULL  = "¡No moretones ni picaduras de abejas por aquí!", 					-- 100%
			HIGH  = "¡Nada que un Pionero Pino no pueda soportar!",		 	-- >75%
			MID   = "¡Mi entrenamiento en primeros auxilios está a punto de ser útil!", -- >50%
			LOW   = "¡Woby debería cargarme a un lugar seguro!", 					-- >25%
			EMPTY = "Puede que tengas que seguir sin mí, amiga...", 		-- <25%
		},
		WETNESS = {
			FULL  = "¡Ahora soy todo arrugas!",					 	-- >75%
			HIGH  = "¿Alguien se acordó de empacar una toalla?",		-- >55%
			MID   = "¡Todas mis insignias están empapadas!", 				-- >35%
			LOW   = "¡Solo es un poco de agua!", 					-- >15%
			EMPTY = "¡He pasado por campamentos con peores tormentas!", 		-- <15%
		}
	},
}