local GetModuleDefinitionFromNetID = require("wx78_moduledefs").GetModuleDefinitionFromNetID

local WHISPER = false
local WHISPER_ONLY = false
local EXPLICIT = true
local TIME_STYLE = "smart"
local OVERRIDEB = true
local OVERRIDESELECT = true
local SHOWDURABILITY = true
local SHOWPROTOTYPER = true
local SHOWEMOJI = true

local setters = {
	WHISPER = function(v) WHISPER = v end,
	WHISPER_ONLY = function(v) WHISPER_ONLY = v end,
	EXPLICIT = function(v) EXPLICIT = v end,
	TIME_STYLE = function(v) TIME_STYLE = v end,
	OVERRIDEB = function(v) OVERRIDEB = v end,
	OVERRIDESELECT = function(v) OVERRIDESELECT = v end,
	SHOWDURABILITY = function(v) SHOWDURABILITY = v end,
	SHOWPROTOTYPER = function(v) SHOWPROTOTYPER = v end,
	SHOWEMOJI = function(v) SHOWEMOJI = v end,
}

local needs_strings = {
	NEEDSCIENCEMACHINE = "RESEARCHLAB",
	NEEDALCHEMYENGINE = "RESEARCHLAB2",
	NEEDSHADOWMANIPULATOR = "RESEARCHLAB3",
	NEEDPRESTIHATITATOR = "RESEARCHLAB4",
	NEEDSANCIENT_FOUR = "ANCIENT_ALTAR",
}

-- This just makes it so that if a message category hasn't been written for a character, it falls back to the UNKNOWN lines.
local char_messages_metatable = {
	__index = function(t, k)
		-- Putting this here so we don't copy it into every translation
		if k == "MIGHT" then
			return {
				HIGH = GetString("wolfgang", "ANNOUNCE_NORMALTOMIGHTY"),
				MID  = GetString("wolfgang", "ANNOUNCE_MIGHTYTONORMAL"),
				LOW  = GetString("wolfgang", "ANNOUNCE_NORMALTOWIMPY"),
			}
		end
		return STRINGS._STATUS_ANNOUNCEMENTS[t.prefab]
			and STRINGS._STATUS_ANNOUNCEMENTS[t.prefab][k]
			or STRINGS._STATUS_ANNOUNCEMENTS.UNKNOWN[k]
	end
}

local StatusAnnouncer = Class(function(self)
	self.cooldown = false
	self.cooldowns = {}
	self.stats = {}
	self.button_to_stat = {}
	self.char_messages = {}
	setmetatable(self.char_messages, char_messages_metatable)
	self.interceptors = {}
end,
nil,
{
})

local announce_types = {
	ITEM = true,
	RECIPE = true,
	INGREDIENT = true,
	SKIN = true,
	TEMPERATURE = true,
	SEASON = true,
	STAT = true,
	WX78CIRCUITS = true,
}

function StatusAnnouncer:RegisterInterceptor(modname, announce_type, interceptor_fn)
	if type(interceptor_fn) ~= "function" or not announce_types[announce_type] then
		return
	end
	if not self.interceptors[announce_type] then
		self.interceptors[announce_type] = {}
	end
	self.interceptors[announce_type][modname] = interceptor_fn
end

function StatusAnnouncer:ProcessInterceptors(announce_type, announce_str, data)
	local result = nil
	for _, interceptor in pairs(self.interceptors[announce_type] or {}) do
		result = interceptor(announce_str, data)
		if type(result) == "string" then
			announce_str = result
		end
	end
	return announce_str
end

function StatusAnnouncer:Announce(message, key)
	if type(key) ~= "string" then
		key = "__UNKNOWN__"
	end
	if not self.cooldown and not self.cooldowns[key] then
		local whisper = TheInput:IsControlPressed(CONTROL_FORCE_ATTACK) or TheInput:IsControlPressed(CONTROL_MENU_MISC_3)
		self.cooldown = ThePlayer:DoTaskInTime(1, function() self.cooldown = false end)
		self.cooldowns[key] = ThePlayer:DoTaskInTime(10, function() self.cooldowns[key] = nil end)
		TheNet:Say(STRINGS.LMB .. " " .. message, WHISPER_ONLY or WHISPER ~= whisper)
	end
	return true
end

-- Maps containers that are missing strings to a prefab name that should have the correct name
local container_prefab_map = {
	shadow_container = "magician_chest"
}

local function get_container_name(container)
	if not container then return end
	if container and container_prefab_map[container.prefab] then
		local remapped_name = STRINGS.NAMES[container_prefab_map[container.prefab]:upper()]
		return remapped_name and remapped_name:lower()
	end
	local container_name = container:GetBasicDisplayName()
	local container_prefab = container and container.prefab
	local underscore_index = container_prefab and container_prefab:find("_container")
	--container name was empty or blank, and matches the bundle container prefab naming system
	if type(container_name) == "string" and container_name:find("^%s*$") and underscore_index then
		container_name = STRINGS.NAMES[container_prefab:sub(1, underscore_index-1):upper()]
	end
	return container_name and container_name:lower()
end

function StatusAnnouncer:FormatSecondsAsRealTime(remaining_s)
	local remaining = ""
	local remaining_m = 0
	local remaining_h = 0
	if remaining_s >= 60 then
		remaining_m = math.floor(remaining_s / 60)
		remaining_s = remaining_s - 60 * remaining_m
	end
	if remaining_m >= 60 then
		remaining_h = math.floor(remaining_m / 60)
		remaining_m = remaining_m - 60 * remaining_h
	end
	remaining = remaining_s .. "s"
	if remaining_m > 0 then
		remaining = remaining_m .. "m" .. remaining
	end
	if remaining_h > 0 then
		remaining = remaining_h .. "h" .. remaining
	end
	return remaining
end

function StatusAnnouncer:FormatSecondsAsGameDays(seconds)
	local remaining_days = seconds / TUNING.TOTAL_DAY_TIME
	local remaining = string.format("%.2f days", remaining_days)

	return remaining
end

function StatusAnnouncer:SecondsToTimeRemainingString(seconds)
	if TIME_STYLE == "smart" then
		-- For the smart setting, short periods of time will display as real time. 
		-- Periods of time longer than a day will be converted into game days.
		if seconds < TUNING.TOTAL_DAY_TIME then
			return self:FormatSecondsAsRealTime(seconds)
		else
			return self:FormatSecondsAsGameDays(seconds)
		end
	elseif TIME_STYLE == "real" then
		return self:FormatSecondsAsRealTime(seconds)
	elseif TIME_STYLE == "game" then
		return self:FormatSecondsAsGameDays(seconds)
	else
		-- This shouldn't ever happen, but just in case...
		return string.format("(%d?)", seconds)
	end
end
	

function StatusAnnouncer:AnnounceItem(slot)
	local item = slot.tile.item
	local container = slot.container
	local percent_type = nil
	local percent = nil
	local remaining = nil
	local thermal_stone_warmth = nil
	if slot.tile.percent then
		percent_type = "DURABILITY"
		percent = slot.tile.percent:GetString()
	elseif slot.tile.hasspoilage then
		if type(item.replica) == "table"
		and type(item.replica.inventoryitem) == "table"
		and type(item.replica.inventoryitem.classified) == "table" then
			percent_type = "FRESHNESS"
			-- .62 comes from the way perish values are serialized; they presumably use a 6-bit unsigned int,
			-- and assign 63 (max value) as "default, unknown"; 0-62 span the actual perish values;
			-- so 1/62 would convert this to a fraction, and 100/62 (or 1/.62) convert to percentage points
			percent = math.floor(item.replica.inventoryitem.classified.perish:value()*(1/.62)) .. "%"
		end
	elseif item:HasTag("rechargeable") then
		percent_type = "RECHARGE"
		percent = math.floor(slot.tile.rechargepct*100) .. "%"
		local remaining_s = math.floor(slot.tile.rechargetime*(1 - slot.tile.rechargepct) + 0.5)
		remaining = self:SecondsToTimeRemainingString(remaining_s)
	end
	local S = STRINGS._STATUS_ANNOUNCEMENTS._ --To save some table lookups
	if item.prefab == "heatrock" then
		-- Try to get thermal stone temperature range to announce
		local image_hash = item.replica.inventoryitem:GetImage()
		local hash_lookup = {}
		local skin_name = item.AnimState:GetSkinBuild()
		if skin_name == "" then
			skin_name = "heat_rock"
		end
		for i = 1,5 do
			hash_lookup[hash(skin_name .. i .. ".tex")] = i
		end
		local range = hash_lookup[image_hash]
		if range ~= nil and range >= 1 and range <= 5 then
			thermal_stone_warmth = S.ANNOUNCE_ITEM.HEATROCK[range]
		end
	end
	if container == nil or (container and container.type == "pack") then
		--\equipslots/        \backpacks/
		container = ThePlayer.replica.inventory
	end
	local num_equipped = 0
	if not container.type then --this is an inventory
		--add in items in equipslots, which don't normally get counted by Has
		for _,slot in pairs(EQUIPSLOTS) do
			if container.GetEquippedItem then
				local equipped_item = container:GetEquippedItem(slot)
				if equipped_item and equipped_item.prefab == item.prefab then
					num_equipped = num_equipped + (equipped_item.replica.stackable and equipped_item.replica.stackable:StackSize() or 1)
				end
			end
		end
	end
	local container_name = get_container_name(container.type and container.inst)
	-- Try to trace the path from construction container to the constructionsite that spawned it
	if not container_name then
		if not container_name then
			local player = container.inst.entity:GetParent()
			local constructionbuilder = player and player.components and player.components.constructionbuilder
			if constructionbuilder and constructionbuilder.constructionsite then
				container_name = get_container_name(constructionbuilder.constructionsite)
			end
		end
	end
	local name = item:GetBasicDisplayName():lower()
	local has, num_found = container:Has(item.prefab, 1)
	num_found = num_found + num_equipped
	local i_have = ""
	local in_this = ""
	if container_name then -- this is a chest
		i_have = S.ANNOUNCE_ITEM.WE_HAVE
		in_this = S.ANNOUNCE_ITEM.IN_THIS
	else -- this is a backpack or inventory
		i_have = S.ANNOUNCE_ITEM.I_HAVE
		container_name = ""
	end
	local this_many = "" .. num_found
	local plural = num_found > 1
	local with = ""
	local durability = ""
	if SHOWDURABILITY and percent then
		with = plural
				and S.ANNOUNCE_ITEM.AND_THIS_ONE_HAS
				 or S.ANNOUNCE_ITEM.WITH
		durability = percent and S.ANNOUNCE_ITEM[percent_type]
		if remaining ~= nil and percent ~= "100%" then
			local remaining_str = subfmt(S.ANNOUNCE_ITEM.REMAINING[percent_type],
										{
											AMOUNT = remaining,
										})
			percent = remaining_str .. " (" .. percent .. ")"
			durability = ""
		end
	else
		percent = ""
	end
	local a = S.getArticle(name)
	local s = S.S
	if (not plural) or string.find(name, s.."$") ~= nil then
		s = ""
	end
	if thermal_stone_warmth then
		if plural then
			with = S.ANNOUNCE_ITEM.AND_THIS_ONE_IS .. thermal_stone_warmth .. S.ANNOUNCE_ITEM.WITH
		else
			name = thermal_stone_warmth .. " " .. name
		end
	end
	if this_many == nil or this_many == "1" then this_many = a end
	local announce_str = subfmt(S.ANNOUNCE_ITEM.FORMAT_STRING,
								{
									I_HAVE = i_have,
									THIS_MANY = this_many,
									ITEM = name,
									S = s,
									IN_THIS = in_this,
									CONTAINER = container_name,
									WITH = with,
									PERCENT = percent,
									DURABILITY = durability,
								})
	local data = {
		item = item,
		container = container,
		slot = slot,
	}
	announce_str = self:ProcessInterceptors("ITEM", announce_str, data)
	return self:Announce(announce_str, "ITEM_" .. tostring(item.GUID))
end

-- Almost identical to CraftingMenuDetails:_GetHintTextForRecipe
-- copied for stability reasons, and out of respect for the naming hint that it was intended to be local
local function GetMinPrototyperTree(recipe)
	local validmachines = {}
	local adjusted_level = deepcopy(recipe.level)

	-- Adjust recipe's level for bonus so that the hint gives the right message
	local tech_bonus = ThePlayer.replica.builder:GetTechBonuses()
	for k, v in pairs(adjusted_level) do
		adjusted_level[k] = math.max(0, v - (tech_bonus[k] or 0))
	end

	for k, v in pairs(TUNING.PROTOTYPER_TREES) do
		local canbuild = CanPrototypeRecipe(adjusted_level, v)
		if canbuild then
			table.insert(validmachines, {TREE = tostring(k), SCORE = 0})
		end
	end

	if #validmachines > 0 then
		if #validmachines == 1 then
			--There's only once machine is valid. Return that one.
			return validmachines[1].TREE
		end

		--There's more than one machine that gives the valid tech level! We have to find the "lowest" one (taking bonus into account).
		for k,v in pairs(validmachines) do
			for rk,rv in pairs(adjusted_level) do
				local prototyper_level = TUNING.PROTOTYPER_TREES[v.TREE][rk]
				if prototyper_level and (rv > 0 or prototyper_level > 0) then
					if rv == prototyper_level then
						--recipe level matches, add 1 to the score
						v.SCORE = v.SCORE + 1
					elseif rv < prototyper_level then
						--recipe level is less than prototyper level, remove 1 per level the prototyper overshot the recipe
						v.SCORE = v.SCORE - (prototyper_level - rv)
					end
				end
			end
		end

		table.sort(validmachines, function(a,b) return (a.SCORE) > (b.SCORE) end)

		return validmachines[1].TREE
	end

	return "CANTRESEARCH"
end

local tree_to_prefab = {
	SCIENCEMACHINE = "RESEARCHLAB",
	ALCHEMYMACHINE = "RESEARCHLAB2",
	SHADOWMANIPULATOR = "RESEARCHLAB3",
	PRESTIHATITATOR = "RESEARCHLAB4",
	ANCIENTALTAR_LOW = "ANCIENT_ALTAR_BROKEN",
	ANCIENTALTAR_HIGH = "ANCIENT_ALTAR",
	FISHING = "TACKLESTATION",
	SEAFARING_STATION = "SEAFARING_PROTOTYPER",
	-- Spidercraft doesn't seem to correspond to any prefab, so leaving it out
	-- A bunch more from TUNING.PROTOTYPER_TREES could be added here,
	-- but these were the only ones in CraftingMenuDetails
}

local function GetMinPrototyper(recipe)
	local prefab = tree_to_prefab[GetMinPrototyperTree(recipe)]
	if prefab ~= nil then
		return STRINGS.NAMES[prefab] or prefab
	end
	return prefab
end

function StatusAnnouncer:AnnounceRecipe(recipe, ingredient)
	if recipe == nil then
		return false
	end
	local S = STRINGS._STATUS_ANNOUNCEMENTS._ --To save some table lookups
	local builder = ThePlayer.replica.builder
	local buffered = builder:IsBuildBuffered(recipe.name)
	local knows = builder:KnowsRecipe(recipe.name) or CanPrototypeRecipe(recipe.level, builder:GetTechTrees())
	local can_build = builder:HasIngredients(recipe.name)
	local recipe_product = recipe.product
	local strings_name = STRINGS.NAMES[recipe_product:upper()]
	if not strings_name then
		recipe_product = recipe.name
		strings_name = STRINGS.NAMES[recipe_product:upper()]
	end
	local key = "RECIPE_" .. tostring(recipe_product)
	local name = strings_name and strings_name:lower() or "<missing_string>"
	local a = S.getArticle(name)
	local prototyper = ""
	if not knows then
		prototyper = GetMinPrototyper(recipe) or prototyper
	end
	local a_proto = ""
	local proto = ""
	local data = {
		recipe = recipe,
		ingredient = ingredient,
		buffered = buffered,
		knows = knows,
		can_build = can_build,
		prototyper = prototyper,
	}
	if ingredient == nil then
		-- announce the recipe (need more x, can make x, have x ready)
		local start_q = ""
		local to_do = ""
		local s = ""
		local pre_built = ""
		local end_q = ""
		local i_need = ""
		local for_it = ""
		if buffered then
			to_do = S.ANNOUNCE_RECIPE.I_HAVE
			pre_built = S.ANNOUNCE_RECIPE.PRE_BUILT
		elseif can_build and knows then
			to_do = S.ANNOUNCE_RECIPE.ILL_MAKE
		elseif knows then
			to_do = S.ANNOUNCE_RECIPE.WE_NEED
			a = ""
			s = string.find(name, S.S.."$") == nil and S.S or ""
		else
			to_do = S.ANNOUNCE_RECIPE.CAN_SOMEONE
			if prototyper ~= "" and SHOWPROTOTYPER then
				i_need = S.ANNOUNCE_RECIPE.I_NEED
				a_proto = S.getArticle(prototyper) .. " "
				proto = prototyper
				for_it = S.ANNOUNCE_RECIPE.FOR_IT
			end
			start_q = S.ANNOUNCE_RECIPE.START_Q
			end_q = S.ANNOUNCE_RECIPE.END_Q
		end
		local announce_str = subfmt(S.ANNOUNCE_RECIPE.FORMAT_STRING,
									{
										START_Q = start_q,
										TO_DO = to_do,
										THIS_MANY = a,
										ITEM = name,
										S = s,
										PRE_BUILT = pre_built,
										END_Q = end_q,
										I_NEED = i_need,
										A_PROTO = a_proto,
										PROTOTYPER = proto,
										FOR_IT = for_it,
									})
		if string.find(announce_str, "\?\.$") ~= nil then
			-- In some cases (maybe only reachable through testing partial code),
			-- it ends up with ?. at the end, so trim the period
			announce_str = announce_str:sub(1, announce_str:len() - 1)
		end
		announce_str = self:ProcessInterceptors("RECIPE", announce_str, data)
		return self:Announce(announce_str, key)
	else --announce the ingredient (need more, have enough to make x of recipe)
		local num = 0
		key = key .. "_" .. ingredient
		local ing_s = S.S
		local amount_needed = 1
		-- No special handling for tech ingredients (sculpting block), but it seems to work fine anyway?
		for k,v in pairs(recipe.ingredients) do
			if ingredient == v.type then amount_needed = v.amount end
		end
		local has, num_found = ThePlayer.replica.inventory:Has(ingredient, RoundBiasedUp(amount_needed * ThePlayer.replica.builder:IngredientMod()))
		for k,v in pairs(recipe.character_ingredients) do
			if ingredient == v.type then
				amount_needed = v.amount
				has, num_found = ThePlayer.replica.builder:HasCharacterIngredient(v)
				ing_s = "" -- health and sanity are already plural
			end
		end
		num = amount_needed - num_found
		local can_make = math.floor(num_found / amount_needed)*recipe.numtogive
		local ingredient_str = (STRINGS.NAMES[ingredient:upper()] or "<missing_string>"):lower()
		if num == 1 or ingredient_str:find(ing_s.."$") ~= nil then ing_s = "" end
		local announce_str = "";
		if num > 0 then
			local and_str = ""
			if prototyper ~= "" and SHOWPROTOTYPER then
				and_str = S.ANNOUNCE_INGREDIENTS.AND
				a_proto = S.getArticle(prototyper) .. " "
				proto = prototyper
			end
			announce_str = subfmt(S.ANNOUNCE_INGREDIENTS.FORMAT_NEED,
									{
										NUM_ING = num,
										INGREDIENT = ingredient_str,
										S = ing_s,
										AND = and_str,
										A_PROTO = a_proto,
										PROTOTYPER = proto,
										A_REC = S.getArticle(name),
										RECIPE = name,
									})
		else
			local but_need = ""
			if prototyper ~= "" and SHOWPROTOTYPER then
				but_need = S.ANNOUNCE_INGREDIENTS.BUT_NEED
				a_proto = S.getArticle(prototyper) .. " "
				proto = prototyper
			end
			local a_rec = ""
			local rec_s = ""
			if can_make > 1 then
				a_rec = can_make .. ""
				rec_s = S.S
				if string.find(name, rec_s.."$") ~= nil then --already plural
					rec_s = ""
				end
			else
				a_rec = S.getArticle(name)
			end
			announce_str = subfmt(S.ANNOUNCE_INGREDIENTS.FORMAT_HAVE,
									{
										INGREDIENT = ingredient_str,
										ING_S = ing_s,
										A_REC = a_rec,
										RECIPE = name,
										REC_S = rec_s,
										BUT_NEED = but_need,
										A_PROTO = a_proto,
										PROTOTYPER = proto,
									})
		end
		data.num_found = num_found
		data.amount_needed = amount_needed
		announce_str = self:ProcessInterceptors("INGREDIENT", announce_str, data)
		return self:Announce(announce_str, key)
	end
end

function StatusAnnouncer:AnnounceSkin(recipe, skin)
	local recipe_name = recipe.product
	local item_name = STRINGS.NAMES[string.upper(recipe.product)]
	if not item_name then
		recipe_name = recipe.name
		item_name = recipe_name
	end
	if skin ~= item_name then --don't announce default skins
		local message = subfmt(STRINGS._STATUS_ANNOUNCEMENTS._.ANNOUNCE_SKIN.FORMAT_STRING,
									{SKIN = GetSkinName(skin), ITEM = item_name})
		local data = {
			recipe = recipe,
			skin = skin,
		}
		message = self:ProcessInterceptors("SKIN", message, data)
		return self:Announce(message, "SKIN_" .. recipe_name)
	end
end

function StatusAnnouncer:AnnounceTemperature(pronoun)
	local S = STRINGS._STATUS_ANNOUNCEMENTS._.ANNOUNCE_TEMPERATURE --To save some table lookups
	local temp = ThePlayer:GetTemperature()
	local pronoun = pronoun and S.PRONOUN[pronoun] or S.PRONOUN.DEFAULT
	local message = S.TEMPERATURE.GOOD
	local TUNING = TUNING
	if temp >= TUNING.OVERHEAT_TEMP then
		message = S.TEMPERATURE.BURNING
	elseif temp >= TUNING.OVERHEAT_TEMP - 5 then
		message = S.TEMPERATURE.HOT
	elseif temp >= TUNING.OVERHEAT_TEMP - 15 then
		message = S.TEMPERATURE.WARM
	elseif temp <= 0 then
		message = S.TEMPERATURE.FREEZING
	elseif temp <= 5 then
		message = S.TEMPERATURE.COLD
	elseif temp <= 15 then
		message = S.TEMPERATURE.COOL
	end
	message = subfmt(S.FORMAT_STRING,
						{
							PRONOUN = pronoun,
							TEMPERATURE = message,
						})
	if EXPLICIT then
		message = string.format("(%d\176) %s", temp, message)
	end
	local data = {
		pronoun = pronoun,
		temp = temp
	}
	message = self:ProcessInterceptors("TEMPERATURE", message, data)
	return self:Announce(message, "TEMPERATURE")
end

function StatusAnnouncer:AnnounceSeason()
	local data = {
		days_left = TheWorld.state.remainingdaysinseason,
		season = TheWorld.state.season
	}
	local message = subfmt(
		STRINGS._STATUS_ANNOUNCEMENTS._.ANNOUNCE_SEASON,
		{
			DAYS_LEFT = data.days_left,
			SEASON = STRINGS.UI.SERVERLISTINGSCREEN.SEASONS[data.season:upper()],
		}
	)
	message = self:ProcessInterceptors("SEASON", message, data)
	return self:Announce(message, "SEASON")
end

local function FormatChipList(S, chip_order, chips, charged)
	local chips_string = ""
	for _, chip in ipairs(chip_order) do
		if chips[chip] then
			if chips_string ~= "" then
				chips_string = chips_string .. ", "
			end
			local chip_name = STRINGS.NAMES["WX78MODULE_" .. chip:upper()]
			if type(chip_name) ~= "string" then
				chip_name = chip
			else
				chip_name = S.GetCircuitName(chip_name)
			end
			chips_string = chips_string .. subfmt(
				S.FORMAT_STRING_CHIP,
				{
					COUNT = chips[chip],
					CIRCUIT_NAME = chip_name,
				})
		end
	end
	if chips_string == "" then return chips_string end
	return subfmt(
		S.FORMAT_STRING_CHARGED,
		{
			CIRCUIT_LIST = chips_string,
			CHARGE_STATE = charged and S.CHARGED or S.UNCHARGED
		})
end

function StatusAnnouncer:AnnounceWxCircuits(widget)
	local charge = widget.energy_level
	local chip_order = {}
	local charged_chips = {}
	local uncharged_chips = {}
	local modules_table = widget.owner:GetModulesData()
	for i, module_index in ipairs(modules_table) do
		if module_index ~= 0 then
			local module_def = GetModuleDefinitionFromNetID(module_index)
			local modname = module_def.name
			charge = charge - module_def.slots
			local add_to = charge < 0 and uncharged_chips or charged_chips
			if not uncharged_chips[modname] and not charged_chips[modname] then
				table.insert(chip_order, modname)
			end
			add_to[modname] = (add_to[modname] or 0) + 1
		end
	end
	local S = STRINGS._STATUS_ANNOUNCEMENTS._.ANNOUNCE_CIRCUITS
	local charged_list = FormatChipList(S, chip_order, charged_chips, true)
	local uncharged_list = FormatChipList(S, chip_order, uncharged_chips, false)
	local separator = ""
	if charged_list ~= "" and uncharged_list ~= "" then
		separator = S.SEPARATOR
	end
	local message = subfmt(
		S.FORMAT_STRING,
		{
			CIRCUITS = S.CIRCUITS,
			CHARGED = charged_list,
			SEPARATOR = separator,
			UNCHARGED = uncharged_list,
		}
	)
	local data = {
		widget = widget,
		chip_order = chip_order,
		charged_chips = charged_chips,
		uncharged_chips = uncharged_chips,
	}
	message = self:ProcessInterceptors("WX78CIRCUITS", message, data)
	return self:Announce(message, "WX78CIRCUITS")
end

--NOTE: Your mod is responsible for adding and deciding when to show/hide the controller button hint
-- look at the modmain for examples-- most stats just show/hide with controller inventory,
-- but moisture requires some special handling
function StatusAnnouncer:RegisterStat(name, widget, controller_btn,
										thresholds, category_names, value_fn, switch_fn)
	if controller_btn ~= nil then
		self.button_to_stat[controller_btn] = name
	end
	self.stats[name] = {
		--The widget that should be focused when announcing this stat
		widget = widget,
		--The button on the controller that announces this stat
		controller_btn = controller_btn,
		--the numerical thresholds at which messages change (must be sorted in increasing order!)
		thresholds = thresholds,
		--the names of the buckets between the thresholds, for looking up strings
		category_names = category_names,
		--value_fn(ThePlayer) returns the current and maximum of the stat
		value_fn = value_fn,
		--switch_fn(ThePlayer) returns the mode (e.g. HUMAN for Woodie vs WEREBEAVER for Werebeaver)
		--if this is nil, it assumes there's just one table (look at Woodie's table in announcestrings vs the others)
		switch_fn = switch_fn,
	}
end

--The other arguments are here so that mods can use them to override this function
-- and avoid some of these stats if their character doesn't have them
function StatusAnnouncer:RegisterCommonStats(
		HUD, prefab, hunger, sanity, health, moisture,
		wereness, pethealth, inspiration, boat, mightiness)
	local stat_categorynames = {"EMPTY", "LOW", "MID", "HIGH", "FULL"}
	local default_thresholds = {	.15,	.35,	.55,	.75		 }

	local status = HUD.controls.status
	local has_weremode = type(status.wereness) == "table"
	local switch_fn = has_weremode
		and function(ThePlayer) return ThePlayer.weremode:value() ~= 0 and "WEREBEAVER" or "HUMAN" end
		or nil

	-- Base stats
	if hunger ~= false and type(status.stomach) == "table" then
		self:RegisterStat(
			"Hunger",
			status.stomach,
			CONTROL_INVENTORY_USEONSCENE, -- D-Pad Left
			default_thresholds,
			stat_categorynames,
			function(ThePlayer)
				return	ThePlayer.player_classified.currenthunger:value(),
						ThePlayer.player_classified.maxhunger:value()
			end,
			switch_fn
		)
	end
	if sanity ~= false and type(status.brain) == "table" then
		self:RegisterStat(
			"Sanity",
			status.brain,
			CONTROL_INVENTORY_EXAMINE, -- D-Pad Up
			default_thresholds,
			stat_categorynames,
			function(ThePlayer)
				return	ThePlayer.player_classified.currentsanity:value(),
						ThePlayer.player_classified.maxsanity:value()
			end,
			switch_fn
		)
	end
	if health ~= false and type(status.heart) == "table" then
		self:RegisterStat(
			"Health",
			status.heart,
			CONTROL_INVENTORY_USEONSELF, -- D-Pad Right
			{.25, .5, .75, 1},
			stat_categorynames,
			function(ThePlayer)
				return	ThePlayer.player_classified.currenthealth:value(),
						ThePlayer.player_classified.maxhealth:value()
			end,
			switch_fn
		)
	end

	-- Context-specific stats that everyone has
	if moisture ~= false and type(status.moisturemeter) == "table" then
		self:RegisterStat(
			"Wetness",
			status.moisturemeter,
			CONTROL_ROTATE_RIGHT, -- Right Bumper
			default_thresholds,
			stat_categorynames,
			function(ThePlayer)
				return	ThePlayer.player_classified.moisture:value(),
						ThePlayer.player_classified.maxmoisture:value()
			end,
			switch_fn
		)
	end
	if boat ~= false and type(status.boatmeter) == "table" then
		self:RegisterStat(
			"Boat",
			status.boatmeter,
			CONTROL_ROTATE_LEFT, -- Left Bumper
			{ .0001, .35, .65, .85 },
			stat_categorynames,
			function(player)
				local boat = player.components.walkableplatformplayer and player.components.walkableplatformplayer.platform
				local healthsyncer = boat and boat.components.healthsyncer
				if not (healthsyncer and healthsyncer.max_health) then
					return 0, 0
				else
					return math.ceil(healthsyncer.max_health * healthsyncer:GetPercent()), healthsyncer.max_health -- Klei yydsb
				end
			end,
			switch_fn
		)
	end

	-- Character-specific stats
	if wereness ~= false and has_weremode then
		self:RegisterStat(
			"Wereness",
			status.wereness,
			nil,
			{ .25, .5, .7, .9 },
			stat_categorynames,
			function(ThePlayer)
				return	ThePlayer.player_classified.currentwereness:value(),
						100 -- looks like the only way is to hardcode this; not networked
			end,
			switch_fn
		)
	end
	if pethealth ~= false and ThePlayer.components.pethealthbar ~= nil and type(status.pethealthbadge) == "table" then
		self:RegisterStat(
			"Abigail",
			status.pethealthbadge,
			nil,
			{ .25, .5, .7, .9 },
			stat_categorynames,
			function(ThePlayer)
				return	math.floor(ThePlayer.components.pethealthbar:GetMaxHealth() * ThePlayer.components.pethealthbar:GetPercent() + 0.5),
						ThePlayer.components.pethealthbar:GetMaxHealth()
			end,
			switch_fn
		)
	end
	if inspiration ~= false and type(status.inspirationbadge) == "table" then
		self:RegisterStat(
			"Inspiration",
			status.inspirationbadge,
			nil,
			TUNING.BATTLESONG_THRESHOLDS,
			{"LOW", "MID", "HIGH", "FULL"},
			function(ThePlayer)
				return	ThePlayer.player_classified.currentinspiration:value(),
						TUNING.INSPIRATION_MAX or 100
			end,
			switch_fn
		)
	end
	if mightiness ~= false and type(status.mightybadge) == "table" then
		self:RegisterStat(
			"Might",
			status.mightybadge,
			nil,
			{
				(TUNING.WIMPY_THRESHOLD or 25)/100,
				(TUNING.MIGHTY_THRESHOLD or 75)/100,
			},
			{"LOW", "MID", "HIGH"},
			function(ThePlayer)
				return	ThePlayer.player_classified.currentmightiness:value(),
						TUNING.MIGHTINESS_MAX or 100
			end,
			switch_fn
		)
	end
end

local function has_seasons(HUD, ignore_focus)
	return HUD.controls.seasonclock and (ignore_focus or HUD.controls.seasonclock.focus)
		or HUD.controls.status.season and (ignore_focus or HUD.controls.status.season.focus)
end

function StatusAnnouncer:AnnounceStat(stat, widget)
	local message = self:ChooseStatMessage(stat)
	local data = {
		stat = stat,
		widget = widget,
	}
	message = self:ProcessInterceptors("STAT", message, data)
	return self:Announce(message, stat)
end

function StatusAnnouncer:OnHUDMouseButton(HUD)
	for stat_name,data in pairs(self.stats) do
		if data and data.widget and data.widget.focus then
			local widget = data.widget
			if widget.name and widget.name == "BoatMeter" and widget.boat == nil then
				return false
			end
			if widget.name and widget.name:find("MoistureMeter") and not widget.active then
				return false
			end
			return self:AnnounceStat(stat_name, widget)
		end
	end
	if HUD.controls.status.temperature and HUD.controls.status.temperature.focus then
		return self:AnnounceTemperature(HUD.controls.status._weremode and "BEAST" or nil)
	end
	if has_seasons(HUD, false) then
		return self:AnnounceSeason()
	end
end

function StatusAnnouncer:OnHUDControl(HUD, control)
	if HUD:IsCraftingOpen() and TheInput:ControllerAttached() then
		if control == CONTROL_CANCEL then
			local details = HUD.controls.craftingmenu.craftingmenu.details_root
			if details and details.data and details.data.recipe then
				return self:AnnounceRecipe(details.data.recipe)
			end
		end
	elseif HUD:IsControllerInventoryOpen()
	or (HUD.controls.status._weremode and HUD._statuscontrollerbuttonhintsshown) then
		local stat = self.button_to_stat[control]
		if stat and self.stats[stat].widget.shown then
			local widget = self.stats[stat].widget
			if widget.name and widget.name == "BoatMeter" and widget.boat == nil then
				return false
			end
			if widget.name and widget.name:find("MoistureMeter") and not widget.active then
				return false
			end
			return self:AnnounceStat(stat, widget)
		end
		if OVERRIDEB and HUD.controls.status.temperature and control == CONTROL_CANCEL then
			return self:AnnounceTemperature(HUD.controls.status._weremode and "BEAST" or nil)
		end
		if OVERRIDESELECT and control == CONTROL_MAP and has_seasons(HUD, true) then
			return self:AnnounceSeason()
		end
	end
end

local function get_category(thresholds, percent)
	local i = 1
	while thresholds[i] ~= nil and percent >= thresholds[i] do
		i = i + 1
	end
	return i
end

function StatusAnnouncer:ChooseStatMessage(stat)
	local cur, max = self.stats[stat].value_fn(ThePlayer)
	local percent = cur/max
	local stat_name = self.stat_names[stat] or stat
	if stat == "Health" and ThePlayer:HasTag("health_as_oldage") then
		stat_name = self.stat_names["Age"] or "Age"
		-- I wanted to make this more generic, but unfortunately it's encapsulated by widgets/wandaagebadge
		-- in a way that doesn't really promote extensibility
		max = TUNING.WANDA_MAX_YEARS_OLD
		cur = max - cur
		-- Conveniently, percent already makes sense because it's essentially considering Wanda to have 60 health
		-- (where 60 is Age 20 and 0 is Age 80)
	end
	local messages = self.stats[stat].switch_fn
						and self.char_messages[self.stats[stat].switch_fn(ThePlayer)]
						or self.char_messages
	local category = get_category(self.stats[stat].thresholds, percent)
	local category_name = self.stats[stat].category_names[category]
	local message = messages[stat:upper()][category_name]
	if EXPLICIT then
		return string.format("(%s: %d/%d) %s", stat_name, cur, max, message)
	else
		return message
	end
end

function StatusAnnouncer:ClearCooldowns()
	self.cooldown = false
	self.cooldowns = {}
end

function StatusAnnouncer:ClearStats()
	self.stats = {}
	self.button_to_stat = {}
end

function StatusAnnouncer:SetCharacter(prefab)
	self:ClearCooldowns()
	self:ClearStats()
	self.char_messages.prefab = prefab:upper()
	self.stat_names = {}
	for stat, name in pairs(STRINGS._STATUS_ANNOUNCEMENTS._.STAT_NAMES) do
		self.stat_names[stat] = name
	end
	if SHOWEMOJI then
		for stat, emoji in pairs(STRINGS._STATUS_ANNOUNCEMENTS._.STAT_EMOJI) do
			if TheInventory:CheckOwnership("emoji_"..emoji) then
				self.stat_names[stat] = ":"..emoji
			end
		end
	end
end

function StatusAnnouncer:SetLocalParameter(parameter, value)
	if setters[parameter] then setters[parameter](value) end
end

return StatusAnnouncer
