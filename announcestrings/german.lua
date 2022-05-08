ANNOUNCE_STRINGS = {
	-- These are not character-specific strings, but are here to ease translation
	-- Note that spaces at the beginning and end of these are important and should be preserved
	_ = {
		getArticle = function(name)
			return string.find(name, "^[abfghkABFGHK]") ~= nil and "eine" or "ein"
		end,
		--Goes into {S} if there are multiple items (plural)
		-- This isn't perfect for making plural even in English, but it's close enough
		S = "n",
		STAT_NAMES = {
			Hunger = "Hunger",
			Sanity = "Gesundheit",
			Health = "Leben",
			Wetness = "Feuchtigkeit",
			Boat = "Boot",
			["Log Meter"] = "Holzmeter",
			Age = "Alter",
			Abigail = "Abigail",
			Inspiration = "Inspiration",
			Might = "Macht",
			--Other mod stats won't have translations, but at least we can support these
		},
		ANNOUNCE_ITEM = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "I have 6 papyrus in this chest."
			FORMAT_STRING = "{I_HAVE}{THIS_MANY} {ITEM}{S}{IN_THIS}{CONTAINER}{WITH}{PERCENT}{DURABILITY}.",
			
			--One of these goes into {I_HAVE}
			I_HAVE = "Ich habe ",
			WE_HAVE = "Wir haben ",
			
			--{THIS_MANY} is a number if multiple, but singular varies a lot by language,
			-- so we use getArticle above to get it
			
			--{ITEM} is acquired from item.name
			
			--{S} uses S above
			
			--Goes into {IN_THIS}, if present
			IN_THIS = " in dieser ",
			
			--{CONTAINER} is acquired from container.name
			
			--One of these goes into {WITH}
			WITH = " mit ", --if it's only one thing
			AND_THIS_ONE_HAS = ", und dieser hat ", --if there are multiple, show durability of one
			AND_THIS_ONE_IS = ", und dieser ist ", --if there are multiple, show durability of one
			
			--{PERCENT} is acquired from the item's durability
			
			--Goes into {DURABILITY}
			DURABILITY = " Haltbarkeit",
			FRESHNESS = " Frische",
			RECHARGE = " Aufladung",
			
			-- Optionally added into {PERCENT}
			REMAINING = {
				DURABILITY = "{AMOUNT} Verwendungen übrig", -- note that this is unused because durability is only published as a percent to clients
				FRESHNESS = "Noch {AMOUNT} Tage", -- note that this is unused because perishables only publish percent to clients
				RECHARGE = "{AMOUNT} bis zum Aufladen",
			},
			
			-- Optionally added into {ITEM} or {WITH} for thermal stones.
			HEATROCK = {
				"eingefroren",
				"kalt",
				"zimmertemperatur",
				"warm",
				"heiß",
			}
		},
		ANNOUNCE_RECIPE = {
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "I have a science machine pre-built and ready to place" -> pre-built
			-- "Ich werd eine Axt bauen" -> known and have ingredients
			-- "Kann jemand mir eine Alchemiemaschine bauen? Ich brauche eine Wissenschaftsmaschine dafür." -> not known
			-- "Wir brauchen mehr Dörrstangen." -> known but don't have ingredients
			FORMAT_STRING = "{START_Q}{TO_DO}{THIS_MANY} {ITEM}{S}{PRE_BUILT}{END_Q}{I_NEED}{A_PROTO}{PROTOTYPER}{FOR_IT}.",
			
			--{START_Q} is for languages that match ? at both ends
			START_Q = "", --English doesn't do that
			
			--One of these goes into {TO_DO}
			I_HAVE = "Ich habe ", --for pre-built
			ILL_MAKE = "Ich werde bauen ", --for known recipes where you have ingredients
			CAN_SOMEONE = "Kann jemand mir bauen ", --for unknown recipes
			WE_NEED = "Wir brauchen mehr", --for known recipes where you don't have ingredients
			
			--{THIS_MANY} uses getArticle above to get the right article ("a", "an")
			
			--{ITEM} comes from the recipe.name
			
			--{S} uses S above

			--Goes into {PRE_BUILT}
			PRE_BUILT = " vorbereitet und bereit zum aufstellen",
			
			--This goes into {END_Q} if it's a question
			END_Q = "?",
			
			--Goes into {I_NEED}
			I_NEED = " Ich brauche ",
			
			--Goes into {FOR_IT}
			FOR_IT = " für es",
		},
		ANNOUNCE_INGREDIENTS = {
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "Ich brauche 2 zusätzliche geschliffene Steine und eine Wissenschaftsmaschine um eine Alchemiemaschine zu bauen."
			FORMAT_NEED = "Ich brauche {NUM_ING} zusätzliche {INGREDIENT}{S}{AND}{A_PROTO}{PROTOTYPER} zum bauen {A_REC} {RECIPE}.",
			
			--If a prototyper is needed, goes into {AND}
			AND = " und ",
			
			-- This needs to reflect the translating language's grammar
			-- Examples of what this makes:
			-- "Ich habe genug Zweige um 9 Vogelfallen zu bauen, aber ich brauche eine Wissenschaftsmaschine."
			FORMAT_HAVE = "Ich habe genug {INGREDIENT}{ING_S} zum bauen {A_REC} {RECIPE}{REC_S}{BUT_NEED}{A_PROTO}{PROTOTYPER}.",
			
			--If a prototyper is needed, goes into {BUT_NEED}
			BUT_NEED = ", aber ich brauche ",
		},
		ANNOUNCE_SKIN = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "Ich habe den tragische Fackel Überzug für die Fackel"
			FORMAT_STRING = "Ich habe den {SKIN} Überzug für das {ITEM}.",
			
			--{SKIN} comes form the skin's name
			
			--{ITEM} comes from the item's name
		},
		ANNOUNCE_TEMPERATURE = {
			-- This needs to reflect the translating language's grammar
			-- For example, this might become "Ich habe eine angenehme Temperatur"
			-- or "Das Biest ist am erfrieren!"
			FORMAT_STRING = "{PRONOUN} {TEMPERATURE}",
			
			--{PRONOUN} is picked from this
			PRONOUN = {
				DEFAULT = "Ich bin",
				BEAST = "Das Biest ist", --for Werebeaver
			},
			
			--{TEMPERATURE} is picked from this
			TEMPERATURE = {
				BURNING = "überhitzen!",
				HOT = "fast am überhitzen!",
				WARM = "ein bischen heiß.",
				GOOD = "eine angenehme Temperatur.",
				COOL = "ein bischen kalt.",
				COLD = "fast am erfrieren!",
				FREEZING = "ich erfriere!",
			},
		},
		ANNOUNCE_SEASON = "Es sind {DAYS_LEFT} Tage übrig im {SEASON}.",
		ANNOUNCE_GIFT = {
			CAN_OPEN = "Ich habe ein Geschenk und ich werde es gleich öffnen!",
			NEED_SCIENCE = "Ich brauche zusätzliche Wissenschaft um dieses Geschenk zu öffnen!",
		},
		ANNOUNCE_HINT = "Ankündigen",
	},
	-- Everything below is character-specific
	UNKNOWN = {
		HUNGER = {
			FULL  = "Ich bin pappsatt!", 	-- >75%
			HIGH  = "Ich bin ziemlich voll.",			-- >55%
			MID   = "Ich bin bischen hungrig.", 	-- >35%
			LOW   = "Ich bin hungrig!", 				-- >15%
			EMPTY = "Ich bin am verhungern!", 			-- <15%
		},
		SANITY = {
			FULL  = "Mein Gehirn ist in Topzustand!", 			-- >75%
			HIGH  = "Ich fühle mich ziemlich gut.", 				-- >55%
			MID   = "Ich werde ein bischen nervös.", 				-- >35%
			LOW   = "Ich fühle mich etwas verrückt, hier!", 			-- >15%
			EMPTY = "AAAAHHHH! Bleibt weg ihr Alpträume!", 	-- <15%
		},
		HEALTH = {
			FULL  = "Ich bin topfit!", 	-- 100%
			HIGH  = "Ich hab ein paar Schrammen.", 	-- >75%
			MID   = "Ich bin verletzt.", 			-- >50%
			LOW   = "Ich bin schwer verletzt!", 	-- >25%
			EMPTY = "Ich bin tödlich verwundet!", 	-- <25%
		},
		WETNESS = {
			FULL  = "Ich bin komplett durchnässt!", 	-- >75%
			HIGH  = "Ich bin durchnässt!",					-- >55%
			MID   = "Ich bin zu nass!", 				-- >35%
			LOW   = "Ich werde etwas feucht.", 		-- >15%
			EMPTY = "Ich bin ziemlich trocken.", 				-- <15%
		},
		BOAT = {
			FULL  = "Dieses Boot ist in perfektem Zustand!",		-- >85%
			HIGH  = "Dieses Fahrzeug ist immer noch seetüchtig.",			-- >65%
			MID   = "Dieses Schiff ist ein bisschen heruntergekommen.",			-- >35%
			LOW   = "Dieses Boot ist dringend reparaturbedürftig!",	-- >0.01%
			EMPTY = "Dieses Schiff sinkt!",					-- <0.01%
		},
	},
	WILSON = {
		HUNGER = {
			FULL  = "Ich bin pappsatt!",
			HIGH  = "Ich benötige nichts zum essen.",
			MID   = "Ich könnte einen Snack vertragen.",
			LOW   = "Ich bin echt hungrig!",
			EMPTY = "Ich... brauche... Essen...",
		},
		SANITY = {
			FULL  = "So ausgewogen wie man nur sein kann!",
			HIGH  = "Mir gehts gut.",
			MID   = "Mein Kopf tut weh...",
			LOW   = "Wa-- was ist los!?",
			EMPTY = "Hilfe! Die Dinger werden mich fressen!!",
		},
		HEALTH = {
			FULL  = "Fit wie ein Turnschuh!",
			HIGH  = "Bin verletzt, aber kann noch weitergehen.",
			MID   = "Ich... Ich glaube ich brauche Erste Hilfe.",
			LOW   = "Ich habe soviel Blut verloren...",
			EMPTY = "Ich... Ich werd hier draußen jämmerlich verrecken...",
		},
		WETNESS = {
			FULL  = "Ich habe meinen Sättigungspunkt erreicht!",
			HIGH  = "Wasser, so durchnässt!",
			MID   = "Meine Kleidung scheint durchlässig.",
			LOW   = "Oh, H2O.",
			EMPTY = "Ich bin ziemlich trocken.",
		},
	},
	WILLOW = {
		HUNGER = {
			FULL  = "Ich werd fett, wenn ich nicht aufhöre zu essen.",
			HIGH  = "Angenehm satt.",
			MID   = "Mein Feuer braucht Brennstoff.",
			LOW   = "Ugh, Ich verhungere hier drüben!",
			EMPTY = "Ich bin quasi nur Haut und Knochen!",
		},
		SANITY = {
			FULL  = "Ich glaube ich hatte jetzt genug Feuer.",
			HIGH  = "Hab ich Bernie tanzen sehen? ... ne, vergiss es.",
			MID   = "Ich fühle mich kälter als sonst...",
			LOW   = "Bernie, warum friere ich so!?",
			EMPTY = "Bernie, beschütz mich vor diesen schrecklichen Dingern!",
		},
		HEALTH = {
			FULL  = "Keine einzige Schramme!",
			HIGH  = "Ich hab 1 oder 2 Schrammen. Ich sollte sie veröden.",
			MID   = "Diese Fleischwunden brennen, Ich brauch einen Arzt...",
			LOW   = "Ich fühle mich schwach... Ich könnte... sterben.",
			EMPTY = "Mein Feuer ist fast erloschen...",
		},
		WETNESS = {
			FULL  = "Uff, dieser Wolkenbruch ist das Letzte!",
			HIGH  = "Ich hasse all dieses Wasser!",
			MID   = "Dieser Platzregen ist zu viel.",
			LOW   = "Oh ha, wenn dieser Regen weiter...",
			EMPTY = "Nicht genug Regen um dieses Feuer zu löschen.",
		},
	},
	WOLFGANG = {
		HUNGER = {
			FULL  = "Wolfgang ist voll und mächtig!",
			HIGH  = "Wolfgang muss essen und mächtig werden!",
			MID   = "Wolfgang könnte mehr essen.",
			LOW   = "Wolfgang hat Loch im Bauch.",
			EMPTY = "Wolfgang braucht Essen! JETZT!",
		},
		SANITY = {
			FULL  = "Wolfgang fühlt sich gut im Kopp!",
			HIGH  = "Wolfgang Kopp fühlt sich lustig.",
			MID   = "Wolfgang Kopp aua",
			LOW   = "Wolfgang sieht gruselige Monster...",
			EMPTY = "Gruselige Monster überall!",
		},
		HEALTH = {
			FULL  = "Wolfgang braucht keine Flickarbeit!",
			HIGH  = "Wolfgang braucht kleinen Ölwechsel.",
			MID   = "Wolfgang schmerzt.",
			LOW   = "Wolfgang braucht viel Hilfe um sich nicht verwundet zu fühlen.",
			EMPTY = "Wolfgang könnte sterben...",
		},
		WETNESS = {
			FULL  = "Wolfgang ist jetzt vielleicht aus Wasser gemacht!",
			HIGH  = "Es ist wie in der Badewanne hocken.",
			MID   = "Wolfgang mag keinen Waschtag.",
			LOW   = "Regenzeit.",
			EMPTY = "Wolfgang ist trocken.",
		},
	},
	WENDY = {
		HUNGER = {
			FULL  = "Keine Nahrungsmenge kann das Loch in meinem Herzen stopfen.",
			HIGH  = "Ich bin voll, aber trotzdem begierig nach etwas das kein Freund geben kann.",
			MID   = "Ich bin nicht leer, aber auch nicht voll. Seltsam.",
			LOW   = "Ich bin voll von Leere.",
			EMPTY = "Ich hab die langsamste Methode zum Sterben gefunden. Verhungern.",
		},
		SANITY = {
			FULL  = "Meine Gedanken sind kristallklar.",
			HIGH  = "Meine Gedanken werden düster.",
			MID   = "Meine Gedanken sind fieberhaft...",
			LOW   = "Siehst du sie, Abigail? Diese Dämonen lassen mich dich vielleicht wiedersehen, bis bald.",
			EMPTY = "Bringt mich zu Abigail, Kreaturen der Dunkelheit und Nacht!",
		},
		HEALTH = {
			FULL  = "Mir gehts gut, aber ich bin mir sicher ich werde wieder verletzt.",
			HIGH  = "Ich spüre Schmerz, aber nicht viel.",
			MID   = "Leben bringt Schmerz, aber ich bin nicht an soviel gewöhnt.",
			LOW   = "Verbluten... wäre jetzt einfach...",
			EMPTY = "Ich werde bei Abigail sein, sehr bald...",
		},
		WETNESS = {
			FULL  = "Eine Apokalypse aus Wasser!",
			HIGH  = "Eine Ewigkeit von Feuchtigkeit und Leid.",
			MID   = "Feucht und traurig.",
			LOW   = "Vielleicht füllt dieses Wasser die Leere in meinem Herzen.",
			EMPTY = "Meine Haut ist genauso trocken wie mein Herz.",
		},
		ABIGAIL = {
			FULL  = "Abigail ist heller denn je!",
			HIGH  = "Abigail strahlt hell.",
			MID   = "Abigail beginnt zu verblassen...",
			LOW   = "Sei vorsichtig, Abigail! Ich kann dich kaum noch sehen!",
			EMPTY = "Verlass mich nicht, Abigail!",
		},
	},
	WX78 = {
		HUNGER = {
			FULL  = "TREIBSTOFF-STATUS: MAXIMALES LEISTUNGSVERMÖGEN",
			HIGH  = "TREIBSTOFF-STATUS: HOCH",
			MID   = "TREIBSTOFF-STATUS: AKZEPTABEL",
			LOW   = "TREIBSTOFF-STATUS: NIEDRIG",
			EMPTY = "TREIBSTOFF-STATUS: KRITISCH",
		},
		SANITY = {
			FULL  = "PROZESSOR-STATUS: VOLL EINSATZBEREIT",
			HIGH  = "PROZESSOR-STATUS: FUNKTIONAL",
			MID   = "PROZESSOR-STATUS: BESCHÄDIGT",
			LOW   = "PROZESSOR-STATUS: FEHLER BEVORSTEHEND",
			EMPTY = "PROZESSOR-STATUS: MEHRERE FEHLER ERFASST",
		},
		HEALTH = {
			FULL  = "EXOSKELETT-STATUS: PERFEKTER ZUSTAND",
			HIGH  = "EXOSKELETT-STATUS: BRUCH ERFASST",
			MID   = "EXOSKELETT-STATUS: MITTELMÄSSIGER SCHADEN",
			LOW   = "EXOSKELETT-STATUS: INTEGRITÄT ZUSAMMENBRECHEND",
			EMPTY = "EXOSKELETT-STATUS: NICHTFUNKTIONSTÜCHTIG",
		},
		WETNESS = {
			FULL  = "FEUCHTE-STATUS: KRITISCH",
			HIGH  = "FEUCHTE-STATUS: FAST KRITISCH",
			MID   = "FEUCHTE-STATUS: INAKZEPTABEL",
			LOW   = "FEUCHTE-STATUS: TOLERABEL",
			EMPTY = "FEUCHTE-STATUS: AKZEPTABEL",
		},
	},
	WICKERBOTTOM = {
		HUNGER = {
			FULL  = "Ich sollte Forschung betreiben und mich nicht vollstopfen.",
			HIGH  = "Satt, aber nicht aufgebläht.",
			MID   = "Ich fühle mich ein bischen hungrig.",
			LOW   = "Diese Bibliothekarin braucht Nahrung, fürchte ich!",
			EMPTY = "Wenn ich nicht sofort Nahrung bekomme, werde ich verhungern!",
		},
		SANITY = {
			FULL  = "Nichts Verdächtiges passiert.",
			HIGH  = "Ich glaube ich hab ein bischen Kopfschmerzen.",
			MID   = "Diese Migräne ist unerträglich.",
			LOW   = "Ich bin mir nicht mehr sicher, ob diese Dinger eingebildet sind!",
			EMPTY = "Hilfe! Diese abgründigen Scheußlichkeiten sind feindlich!",
		},
		HEALTH = {
			FULL  = "Ich bin topfit für mein hohes Alter!",
			HIGH  = "Ein paar Kratzer, aber nichts Schlimmes.",
			MID   = "Meine medizinische Notlage steigt an.",
			LOW   = "Ohne Heilung wird das mein Ende sein.",
			EMPTY = "Ich brauche sofortige Erste Hilfe!",
		},
		WETNESS = {
			FULL  = "Positiv durchnässt!",
			HIGH  = "Ich bin feucht, feucht, feucht!",
			MID   = "Ich frage mich was der Sättigungspunkt meines Körpers ist...",
			LOW   = "Die Schichten der Nässe steigen an.",
			EMPTY = "Ich bin hinreichend frei von Feuchtigkeit.",
		},
	},
	WOODIE = {
		HUMAN = {
			HUNGER = {
				FULL  = "Alles komplett voll!",
				HIGH  = "Satt genug zum Bäume fällen.",
				MID   = "Könnte einen Snack vertragen, hä!",
				LOW   = "Läute die Essensglocke!",
				EMPTY = "Ich verhungere!",
			},
			SANITY = {
				FULL  = "Alles gut an der Nordgrenze!",
				HIGH  = "Immernoch gut in der Rübe.",
				MID   = "Ich glaub ich brauch nen Nickerchen, hä!",
				LOW   = "Haut ab ihr Alptraumtrampel!",
				EMPTY = "Alle meine Schrecken sind echt, und tun weh!",
			},
			HEALTH = {
				FULL  = "Fit wie eine Trillerpfeife!",
				HIGH  = "Was dich nicht umbringt macht dich nur stärker, hä?",
				MID   = "Könnte etwas Gesundheit vertragen.",
				LOW   = "Das fängt echt an weh zu tun, hä...",
				EMPTY = "Legt mich zur Ruhe... im Wald...",
			},
			WETNESS = {
				FULL  = "Viel zu nass selbst zum Bäume fällen, hä?",
				HIGH  = "Schottenstoff ist nicht genug bei dieser Nässe.",
				MID   = "Ich werde richtig nass, hä?",
				LOW   = "Der Schottenüberwurf ist warm, selbst wenn er nass ist.",
				EMPTY = "Praktisch kein Tropfen, hä?",
			},
			["LOG METER"] = {
				FULL  = "Könnte immer nochmehr Holzscheite gebrauchen, aber nicht in meinem Magen, hä?",	-- > 90%
				HIGH  = "Ich sehne mich nach einem Ästchen.",						-- > 70%
				MID   = "Holzscheite sehen sehr lecker aus.",									-- > 50%
				LOW   = "Ich fühle den Fluch ausbrechen.",									-- > 25%
				EMPTY = "Graaww, hä?",	-- < 25% (this shouldn't be possible, he'll become a werebeaver)
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
				FULL  = "Die Augen vom Biest sind weit offen und wachsam.",
				HIGH  = "Das Biest zwinkert den Alpträumen zu.",
				MID   = "Das Biest dreht sich nach unsichtbaren Sachen um.",
				LOW   = "Das Biest zittert und die Augen flackern.",
				EMPTY = "Das Biest knurrt und scheint von multiplizierenden Alpträumen verfolgt zu werden.",
			},
			HEALTH = {
				FULL  = "Das Biest hüpft lebhaft.",
				HIGH  = "Das Biest hat ein paar Schrammen.",
				MID   = "Das Biest leckt seine Wunden.",
				LOW   = "Das Biest wiegt seine Pfote.",
				EMPTY = "Das Biest humpelt lächerlich.",
			},
			WETNESS = {
				FULL  = "Das Fell vom Biest ist komplett durchnässt.",
				HIGH  = "Das Biest hinterlässt eine Spur von kleinen Pfützen.",
				MID   = "Das Fell vom Biest ist ein bischen nass.",
				LOW   = "Das Biest tropft ein wenig.",
				EMPTY = "Das Fell vom Biest ist trocken.",
			},
			["LOG METER"] = {
				FULL  = "Das Biest sieht fast menschlich aus.",				-- > 90%
				HIGH  = "Das Biest kaut an einem Holzhappen.",		-- > 70%
				MID   = "Das Biest kaut an einem Zweig.",					-- > 50%
				LOW   = "Das Biest guckt gefräßig auf diese Bäume.",	-- > 25%
				EMPTY = "Das Biest sieht durchsichtig aus.",						-- < 25%
			},
		},
	},
	WES = {
		HUNGER = {
			FULL  = "*tätschelt den Magen zufrieden*",
			HIGH  = "*tätschelt den Magen*",
			MID   = "*bringt die Hand zum offnenen Mund*",
			LOW   = "*bringt die Hand zum offnenen Mund, Augen weitend*",
			EMPTY = "*umklammert eingefallenen Magen mit einem verzweifelten Ausdruck*",
		},
		SANITY = {
			FULL  = "*grüßt*",
			HIGH  = "*daumen hoch*",
			MID   = "*reibt die Schläfe*",
			LOW   = "*blickt wie wahnsinnig umher*",
			EMPTY = "*wiegt Kopf, vor und zurückwippend*",
		},
		HEALTH = {
			FULL  = "*tätschelt das Herz*",
			HIGH  = "*fühlt Puls, Daumen hoch*",
			MID   = "*bewegt Hand um den Arm, als ob er ihn verbindet*",
			LOW   = "*wiegt den Arm*",
			EMPTY = "*schwankt dramatisch, dann fällt um*",
		},
		WETNESS = {
			FULL  = "*schwimmt wie wahnsinnig nach oben*",
			HIGH  = "*schwimmt nach oben*",
			MID   = "*schaut verächtlich in den Himmel*",
			LOW   = "*versteckt Kopf unter Armen*",
			EMPTY = "*grinst, hält unsichtbaren Regenschirm*",
		},
	},
	WAXWELL = {
		HUNGER = {
			FULL  = "Ich hatte ein richtiges Festmahl.",
			HIGH  = "Ich bin satt, aber nicht übermäßig.",
			MID   = "Ein Snack scheint bestellt zu sein.",
			LOW   = "Ich bin Leer im Inneren.",
			EMPTY = "Nein! Ich hab meine Freiheit nicht erlangt nur um hier zu verhungern!",
		},
		SANITY = {
			FULL  = "Adretter gehts nichtmehr.",
			HIGH  = "Mein normalerweise standhafter Intellekt scheint... schwankend.",
			MID   = "Aua. Mein Haupt schmerzt.",
			LOW   = "Ich muss meinen Kopf freikriegen, Ich fange an ... SIE .. zu sehen.",
			EMPTY = "Hilfe! Diese Schatten sind echte Biester, weißt du!",
		},
		HEALTH = {
			FULL  = "Ich bin total unverletzt.",
			HIGH  = "Ist nur ne kleine Schramme.",
			MID   = "Ich muss mich vielleicht zusammenflicken.",
			LOW   = "Das ist nicht mein Schwanenlied, aber nah dran.",
			EMPTY = "Nein! Ich bin nicht entkommen nur um hier zu sterben!",
		},
		WETNESS = {
			FULL  = "Nasser als Wasser.",
			HIGH  = "Ich glaub nicht ich werde jemals wieder trocken.",
			MID   = "Dieser Regen wird meinen Anzug ruinieren.",
			LOW   = "Dampf ist nicht gediegen.",
			EMPTY = "Trocken und adrett.",
		},
	},
	WEBBER = {
		HUNGER = {
			FULL  = "Beide unserer Mägen sind gefüllt!",				-- >75%
			HIGH  = "Wir könnten ein Nippelchen mehr essen.",					-- >55%
			MID   = "Wir glauben es ist langsam Mittagszeit!",			-- >35%
			LOW   = "Wir könnten jetzt sogar Moms Reste essen...",-- >15%
			EMPTY = "Unsere Bäuchlein sind leer!",						-- <15%
		},
		SANITY = {
			FULL  = "Wir fühlen uns sehr gut ausgeruht!",							-- >75%
			HIGH  = "Ein Nickerchen würde nicht Schaden.",							-- >55%
			MID   = "Unsere Köpfe tun weh...",							-- >35%
			LOW   = "Wann war die letzde Zeit wenn wir Nickerchen hatten?!",	-- >15%
			EMPTY = "Wir fürchten uns nicht vor euch, schaurige Dinger!",		-- <15%
		},
		HEALTH = {
			FULL  = "Wir haben nicht mal ne Schramme!",				-- 100%
			HIGH  = "Wir brauchen bald nen Pflaster.",				-- >75%
			MID   = "Wir brauchen mehr als Pflaster...",	-- >50%
			LOW   = "Unser Körper schmerzt...",							-- >25%
			EMPTY = "Wir wollen noch nicht sterben...",					-- <25%
		},
		WETNESS = {
			FULL  = "Wääh, wir sind durchnässt!", 						-- >75%
			HIGH  = "Unser Fell ist durchnässt!",							-- >55%
			MID   = "Wir sind nass!", 									-- >35%
			LOW   = "Wir sind unangenehm feucht.", 					-- >15%
			EMPTY = "Wir lieben in Pfützen zu spielen.", 					-- <15%
		},
	},
	WATHGRITHR = {
		HUNGER = {
			FULL  = "Ich hungere nach Schlachten, nicht Fleisch!", 				-- >75%
			HIGH  = "Ich bin gesättigt genug für die Schlacht.",					-- >55%
			MID   = "Ich könnte nen Fleischhappen vertragen.", 					-- >35%
			LOW   = "Ich sehne mich nach einem Festmahl!", 							-- >15%
			EMPTY = "Ich verhungere ohne ein Mahl!", 				-- <15%
		},
		SANITY = {
			FULL  = "Ich fürchte keine Sterblichen!", 							-- >75%
			HIGH  = "Ich fühle mich besser im Kampf!", 					-- >55%
			MID   = "Meine Gedanken wandern...", 							-- >35%
			LOW   = "Diese Schatten dringen durch meinen Speer...", -- >15%
			EMPTY = "Bleibt zurück, Biester der Dunkelheit!", 				-- <15%
		},
		HEALTH = {
			FULL  = "Meine Haut ist undurchdringlich!", 					-- 100%
			HIGH  = "Ist ja nur ne Fleischwunde!", 					-- >75%
			MID   = "Ich bin verwundet, aber ich kann noch kämpfen.", 			-- >50%
			LOW   = "Ohne Hilfe, werde ich bald in Walhalla verweilen...", 	-- >25%
			EMPTY = "Meine Saga erreicht sein Ende...", 					-- <25%
		},
		WETNESS = {
			FULL  = "Ich bin komplett feucht!", 					-- >75%
			HIGH  = "Ein Krieger so feucht kann nicht kämpfen!",				-- >55%
			MID   = "Meine Rüstung wird rosten!", 							-- >35%
			LOW   = "Ich brauche kein Bad danach.", 				-- >15%
			EMPTY = "Staubtrocken für den Kampf!", 						-- <15%
		},
		INSPIRATION = {
			FULL  = "Meine Stimme ist stark genug für drei Lieder!", 			-- >5/6, 3 songs
			HIGH  = "Ich könnte alleine ein Duett singen!",						-- >3/6, 2 songs
			MID   = "Ich bin bereit zu singen!", 									-- >1/6, 1 song
			LOW   = "Ich muss meine Stimme aufwärmen... in der Hitze des Gefechts!", 	-- <1/6
		},
	},
	WINONA = {
		HUNGER = {
			FULL  = "Ich hatte schon meine anständige Mahlzeit für den Tag.",
			HIGH  = "Ich hab immer Platz für mehr Fraß!",
			MID   = "Darf ich bitte in die Mittagspause?",
			LOW   = "Ich geh schon auf dem Zahnfleisch, Chef.",
			EMPTY = "Die Fabrik wird einen Arbeiter verlieren wenn ich nicht schnell Fraß kriege!",
		},
		SANITY = {
			FULL  = "So vernünftig wie immer.",
			HIGH  = "Alles gut unter der Motorhaube!",
			MID   = "Ich glaube ich hab paar Schrauben locker...",
			LOW   = "Mein Verstand ist gebrochen, Ich sollte ihn selbst reparieren.",
			EMPTY = "Dies ist ein Alptraum! Haha! Ich meins ernst.",
		},
		HEALTH = {
			FULL  = "Ich bin genauso gesund wie ein Pferd!",
			HIGH  = "Eh, Ich werds abarbeiten.",
			MID   = "Ich kann jetzt nicht aufgeben.",
			LOW   = "Kann ich endlich meine Betriebsrente einsacken...?",
			EMPTY = "Ich glaub meine Schicht ist zu Ende...",
		},
		WETNESS = {
			FULL  = "Ich kann SO nicht arbeiten!",
			HIGH  = "Mein Blaumann sammelt Feuchtigkeit an!",
			MID   = "Jemand sollte ein Schild: Vorsicht Rutschgefahr! aufstellen.",
			LOW   = "Sorgen Sie immer für einen ausgeglichenen Flüssigkeitshaushalt während der Arbeit.",
			EMPTY = "Das ist nichts.",
		},
	},
	WARLY = {
		HUNGER = {
			FULL  = "Meine Kochkunst ist mein Verderben!", 	-- >75%
			HIGH  = "Ich glaube ich hatte genug, für jetzt.",			-- >55%
			MID   = "Zeit für Abendessen plus Nachtisch.", 	-- >35%
			LOW   = "Ich hab das Abendbrot verpasst!", 				-- >15%
			EMPTY = "Verhungern... der schlimmste Tod!", 			-- <15%
		},
		SANITY = {
			FULL  = "Das exquisite Aroma meiner Kochkunst hält mich gesund.", 			-- >75%
			HIGH  = "Ich fühle mich etwas benebelt.", 				-- >55%
			MID   = "Ich kann nicht klar denken.", 				-- >35%
			LOW   = "Das Flüstern... helft mir!", 			-- >15%
			EMPTY = "Ich kann diesen Wahnsinn nicht länger aushalten!", 	-- <15%
		},
		HEALTH = {
			FULL  = "Ich bin komplettfit.", 	-- 100%
			HIGH  = "Es war schlimmer als ich Zwiebeln geschnitten habe.", 	-- >75%
			MID   = "Ich blute...", 			-- >50%
			LOW   = "Ich könnte einen Verband gebrauchen!", 	-- >25%
			EMPTY = "Glaube dies ist das Ende, alter Freund...", 	-- <25%
		},
		WETNESS = {
			FULL  = "Ich fühle die Fische in meiner Kleidung schwimmen.", 	-- >75%
			HIGH  = "Wasser wird meine exquisiten Speisen verderben!",					-- >55%
			MID   = "Ich sollte meine Kleidung trocknen bevor ich mich erkälte.", 				-- >35%
			LOW   = "Dies ist nicht die Zeit oder der Ort für ein Bad.", 		-- >15%
			EMPTY = "Nur ein paar Spritzer, kein Problem.", 				-- <15%
		},
	},
	WALANI = {
		HUNGER = {
			FULL  = "Mmmm lecker, das war ein Festmahl des Himmels.", 	-- >75%
			HIGH  = "Ich könnte immernoch einen Snack vertragen.",			-- >55%
			MID   = "Essen, Essen, Essen!", 	-- >35%
			LOW   = "Mein Magen wird implodieren!", 				-- >15%
			EMPTY = "Bitte... irgendwas zu essen!", 			-- <15%
		},
		SANITY = {
			FULL  = "Es gibt nichts besseres als Surfen um mich fit zu halten.", 			-- >75%
			HIGH  = "Das Meer ruft mich.", 				-- >55%
			MID   = "Meinem Kopf wirds schwindelig.", 				-- >35%
			LOW   = "Uff! Ich brauch mein Surfbrett!", 			-- >15%
			EMPTY = "Was sind diese... Dinger?!", 	-- <15%
		},
		HEALTH = {
			FULL  = "Hab mich niemals besser gefühlt.", 	-- 100%
			HIGH  = "Ein paar Schrammen, kein großes Brimborium.", 	-- >75%
			MID   = "Ich könnte etwas Heilung vertragen!", 			-- >50%
			LOW   = "Fühlt sich an als ob meine Eingeweide aufgegeben haben.", 	-- >25%
			EMPTY = "Jeder einzelne Knochen in meinem Körper ist zersplittert!", 	-- <25%
		},
		WETNESS = {
			FULL  = "Ich bin durch und durch feucht!", 	-- >75%
			HIGH  = "Meine Kleidung scheint ziemlich feucht zu sein.",					-- >55%
			MID   = "Ich brauch gleich mal ein Handtuch.", 				-- >35%
			LOW   = "Ein bischen Feuchtigkeit hat noch niemanden geschadet.", 		-- >15%
			EMPTY = "Ich sehe einen Sturm aufziehen!", 				-- <15%
		},
	},
	WOODLEGS = {
		HUNGER = {
			FULL  = "Harr, das war ein tolles Mahl, Bürschchen!", 	-- >75%
			HIGH  = "Mein Bäuchlein ist ziemlich voll.",			-- >55%
			MID   = "Es ist Zeit für mein tägliches Mahl.", 	-- >35%
			LOW   = "Aye! Ihr Gesindel, wo ist mein Mahl!?", 				-- >15%
			EMPTY = "Ich werd zu Tode verhungern!", 			-- <15%
		},
		SANITY = {
			FULL  = "Aye, die See, sie ist eine Schönheit!", 			-- >75%
			HIGH  = "Zeit für einen Ritt auf der See!", 				-- >55%
			MID   = "Ich vermisse meine liebe See...", 				-- >35%
			LOW   = "Kann mich nicht an das letzte Mal segeln erinnern.", 			-- >15%
			EMPTY = "Ich bin ein Säbel rasselnder Piratenkapitän, nicht eine Landratte!", 	-- <15%
		},
		HEALTH = {
			FULL  = "Harr, Ich bin eine harte Nuss zu knacken!", 	-- 100%
			HIGH  = "War das schon alles?", 	-- >75%
			MID   = "Ich geb nochnicht auf!", 			-- >50%
			LOW   = "Woodlegs ist kein Angsthase!", 	-- >25%
			EMPTY = "Yarr! Du gewinnst, Gesinde!", 	-- <25%
		},
		WETNESS = {
			FULL  = "Ich bin bis auf die Knochen durchnässt!", 	-- >75%
			HIGH  = "Ich mag wenn die Gischt 'unter dem Bug' bleibt.",					-- >55%
			MID   = "Mein Matrosenhemd füllt sich mit Wasser.", 				-- >35%
			LOW   = "Meine Kniebundhose ist durchnässt!", 		-- >15%
			EMPTY = "Yarr! Ein Sturm braut sich zusammen.", 				-- <15%
		},
	},
	WILBUR = {
		HUNGER = {
			FULL  = "*hüpft herum in die Hände klatschend*", 	-- >75%
			HIGH  = "*klatscht glücklich in die Hände*",			-- >55%
			MID   = "*krault seinen Bauch*", 	-- >35%
			LOW   = "*guckt traurig und krault Bauch*", 				-- >15%
			EMPTY = "OOAOE! *reibt Bauch*", 			-- <15%
		},
		SANITY = {
			FULL  = "*klopft auf den Kopf*", 			-- >75%
			HIGH  = "*zeigt Daumen hoch*", 				-- >55%
			MID   = "*schaut schreckhaft*", 				-- >35%
			LOW   = "*schreit gespenstisch*", 			-- >15%
			EMPTY = "OOAOE! OOOAH!", 	-- <15%
		},
		HEALTH = {
			FULL  = "*trommelt auf die Brust mit beiden Händen*", 	-- 100%
			HIGH  = "*trommelt auf die Brust*", 	-- >75%
			MID   = "*streichelt sanft Flecken mit ausgefallenem Fell*", 			-- >50%
			LOW   = "*humpelt mitleiderregend*", 	-- >25%
			EMPTY = "OAOOE! OOOOAE!", 	-- <25%
		},
		WETNESS = {
			FULL  = "*nießt*", 	-- >75%
			HIGH  = "*reibt Hände zusammen*",					-- >55%
			MID   = "Ooo! Ooae!", 				-- >35%
			LOW   = "Oooh?", 		-- >15%
			EMPTY = "Ooae Oooh Oaoa! Ooooe.", 				-- <15%
		},
	},
}