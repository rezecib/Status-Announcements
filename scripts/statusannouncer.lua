local WHISPER = false
local WHISPER_ONLY = false
local EXPLICIT = true
local OVERRIDEB = true
local OVERRIDESELECT = true
local SHOWDURABILITY = true
local SHOWPROTOTYPER = true
local SHOWEMOJI = true

local setters = {
	WHISPER = function(v) WHISPER = v end,
	WHISPER_ONLY = function(v) WHISPER_ONLY = v end,
	EXPLICIT = function(v) EXPLICIT = v end,
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

local StatusAnnouncer = Class(function(self)
	self.cooldown = false
	self.cooldowns = {}
	self.stats = {}
	self.button_to_stat = {}
	self.char_messages = STRINGS._STATUS_ANNOUNCEMENTS.UNKNOWN
end,
nil,
{
})

function StatusAnnouncer:Announce(message)
	if not self.cooldown and not self.cooldowns[message] then
		local whisper = TheInput:IsKeyDown(KEY_CTRL) or TheInput:IsControlPressed(CONTROL_MENU_MISC_3)
		self.cooldown = ThePlayer:DoTaskInTime(1, function() self.cooldown = false end)
		self.cooldowns[message] = ThePlayer:DoTaskInTime(10, function() self.cooldowns[message] = nil end)
		TheNet:Say(STRINGS.LMB .. " " .. message, WHISPER_ONLY or WHISPER ~= whisper)
	end
	return true
end

local function get_container_name(container)
	if not container then return end
	local container_name = container:GetBasicDisplayName()
	local container_prefab = container and container.prefab
	local underscore_index = container_prefab and container_prefab:find("_container")
	--container name was empty or blank, and matches the bundle container prefab naming system
	if type(container_name) == "string" and container_name:find("^%s*$") and underscore_index then
		container_name = STRINGS.NAMES[container_prefab:sub(1, underscore_index-1):upper()]
	end
	return container_name and container_name:lower()
end

local function time_remaining_str(remaining_s)
	local remaining = ""
	local remaining_m = 0
	local remaining_h = 0
	if remaining_s >= 60 then
		remaining_m = math.floor(remaining_s / 60)
		remaining_s = remaining_s - 60*remaining_m
	end
	if remaining_m >= 60 then
		remaining_h = math.floor(remaining_m / 60)
		remaining_m = remaining_m - 60*remaining_h
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
		remaining = time_remaining_str(remaining_s)
	end
	local S = STRINGS._STATUS_ANNOUNCEMENTS._ --To save some table lookups
	if item.prefab == "heatrock" then
		-- Try to get thermal stone temperature range to announce
		local image_hash = item.replica.inventoryitem:GetImage()
		local hash_lookup = {}
		local skin_name = item:GetSkinName() or "heat_rock"
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
			local equipped_item = container:GetEquippedItem(slot)
			if equipped_item and equipped_item.prefab == item.prefab then
				num_equipped = num_equipped + (equipped_item.replica.stackable and equipped_item.replica.stackable:StackSize() or 1)
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
	return self:Announce(announce_str)
end

function StatusAnnouncer:AnnounceRecipe(slot, recipepopup, ingnum)
	local S = STRINGS._STATUS_ANNOUNCEMENTS._ --To save some table lookups
	local builder = slot.owner.replica.builder
	local buffered = builder:IsBuildBuffered(slot.recipe.name)
	local knows = builder:KnowsRecipe(slot.recipe.name) or CanPrototypeRecipe(slot.recipe.level, builder:GetTechTrees())
	local can_build = builder:CanBuild(slot.recipe.name)
	local strings_name = STRINGS.NAMES[slot.recipe.product:upper()] or STRINGS.NAMES[slot.recipe.name:upper()]
	local name = strings_name and strings_name:lower() or "<missing_string>"
	local a = S.getArticle(name)
	local ingredient = nil
	recipepopup = recipepopup or slot.recipepopup
	local ing = recipepopup.ing or {recipepopup.ingredient}
	if ingnum == nil then --mouse controls, we have to find the focused ingredient
		for i, ing in ipairs(ing) do
			if ing.focus then ingredient = ing end
		end
	else --controller controls, we pick it by number (determined by which button was pressed)
		ingredient = ing[ingnum]
	end
	if ingnum and ingredient == nil then return end --controller button for ingredient that doesn't exist
	local prototyper = ""
	if recipepopup.teaser.shown then
		--we patch RecipePopup in the modmain to insert _original_string when the teaser string gets set
		local teaser_string = recipepopup.teaser._original_string
		local CRAFTING = STRINGS.UI.CRAFTING
		for needs_string, prototyper_prefab in pairs(needs_strings) do
			if teaser_string == CRAFTING[needs_string] then
				prototyper = STRINGS.NAMES[prototyper_prefab]:lower()
			end
		end
	end
	local a_proto = ""
	local proto = ""
	if ingredient == nil then --announce the recipe (need more x, can make x, have x ready)
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
		return self:Announce(announce_str)
	else --announce the ingredient (need more, have enough to make x of recipe)
		local num = 0
		local ingname = nil
		local ingtooltip = nil
		if ingredient.ing then
			-- RecipePopup
			ingname = ingredient.ing.texture:sub(1,-5)
			ingtooltip = ingredient.tooltip
		else
			-- Quagmire_RecipePopup
			ingname = recipepopup.recipe.ingredients[1].type
			ingtooltip = STRINGS.NAMES[string.upper(ingname)]
		end
		local ing_s = S.S
		local amount_needed = 1
		for k,v in pairs(slot.recipe.ingredients) do
			if ingname == v.type then amount_needed = v.amount end
		end
		local has, num_found = slot.owner.replica.inventory:Has(ingname, RoundBiasedUp(amount_needed * slot.owner.replica.builder:IngredientMod()))
		for k,v in pairs(slot.recipe.character_ingredients) do
			if ingname == v.type then
				amount_needed = v.amount
				has, num_found = slot.owner.replica.builder:HasCharacterIngredient(v)
				ing_s = "" --health and sanity are already plural
			end
		end
		num = amount_needed - num_found
		local can_make = math.floor(num_found / amount_needed)*slot.recipe.numtogive
		local ingredient_str = (ingtooltip or "<missing_string>"):lower()
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
		return self:Announce(announce_str)
	end
end

function StatusAnnouncer:AnnounceSkin(recipepopup)
	local skin_name = recipepopup.skins_spinner.GetItem()
	local item_name = STRINGS.NAMES[string.upper(recipepopup.recipe.product)] or recipepopup.recipe.name
	if skin_name ~= item_name then --don't announce default skins
		return self:Announce(subfmt(STRINGS._STATUS_ANNOUNCEMENTS._.ANNOUNCE_SKIN.FORMAT_STRING,
									{SKIN = GetSkinName(skin_name), ITEM = item_name}))
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
		return self:Announce(string.format("(%d\176) %s", temp, message))
	else
		return self:Announce(message)
	end
end

function StatusAnnouncer:AnnounceSeason()
	return self:Announce(subfmt(
		STRINGS._STATUS_ANNOUNCEMENTS._.ANNOUNCE_SEASON,
		{
			DAYS_LEFT = TheWorld.state.remainingdaysinseason,
			SEASON = STRINGS.UI.SERVERLISTINGSCREEN.SEASONS[TheWorld.state.season:upper()],
		}
	))
end

--NOTE: Your mod is responsible for adding and deciding when to show/hide the controller button hint
-- look at the modmain for examples-- most stats just show/hide with controller inventory,
-- but moisture requires some special handling
function StatusAnnouncer:RegisterStat(name, widget, controller_btn,
										thresholds, category_names, value_fn, switch_fn)
	self.button_to_stat[controller_btn] = name
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
function StatusAnnouncer:RegisterCommonStats(HUD, prefab, hunger, sanity, health, moisture, wereness, pethealth, inspiration)
	local stat_categorynames = {"EMPTY", "LOW", "MID", "HIGH", "FULL"}
	local default_thresholds = {	.15,	.35,	.55,	.75		 }
	
	local status = HUD.controls.status
	local has_weremode = type(status.wereness) == "table"
	local switch_fn = has_weremode
		and function(ThePlayer) return ThePlayer.weremode:value() ~= 0 and "WEREBEAVER" or "HUMAN" end
		or nil 
	
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
	if wereness ~= false and has_weremode then
		self:RegisterStat(
			"Log Meter",
			status.wereness,
			CONTROL_ROTATE_LEFT, -- Left Bumper
			{ .25, .5, .7, .9 },
			stat_categorynames,
			function(ThePlayer)
				return	ThePlayer.player_classified.currentwereness:value(),
						100 -- looks like the only way is to hardcode this; not networked
			end,
			switch_fn
		)
	end
	if pethealth ~= false and ThePlayer.components.pethealthbar ~= nil then
		self:RegisterStat(
			"Abigail",
			status.pethealthbadge,
			CONTROL_ROTATE_LEFT, -- Left Bumper
			{ .25, .5, .7, .9 },
			stat_categorynames,
			function(ThePlayer)
				return	math.floor(ThePlayer.components.pethealthbar:GetMaxHealth() * ThePlayer.components.pethealthbar:GetPercent() + 0.5),
						ThePlayer.components.pethealthbar:GetMaxHealth()
			end,
			switch_fn
		)
	end
	if inspiration ~= false and status.inspirationbadge ~= nil then
		self:RegisterStat(
			"Inspiration",
			status.inspirationbadge,
			CONTROL_ROTATE_LEFT, -- Left Bumper
			TUNING.BATTLESONG_THRESHOLDS,
			{"LOW", "MID", "HIGH", "FULL"},
			function(ThePlayer)
				return	ThePlayer.player_classified.currentinspiration:value(),
						TUNING.INSPIRATION_MAX
			end,
			switch_fn
		)
	end
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
end

local function has_seasons(HUD, ignore_focus)
	return HUD.controls.seasonclock and (ignore_focus or HUD.controls.seasonclock.focus)
		or HUD.controls.status.season and (ignore_focus or HUD.controls.status.season.focus)
end

function StatusAnnouncer:OnHUDMouseButton(HUD)
	for stat_name,data in pairs(self.stats) do
		if data.widget.focus then
			return self:Announce(self:ChooseStatMessage(stat_name))
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
	if HUD:IsControllerCraftingOpen() then
		local cc = HUD.controls.crafttabs.controllercrafting
		local slot = cc.oldslot or cc.craftslots.slots[cc.selected_slot]
		local recipepopup = cc.recipepopup or slot.recipepopup
		if control == CONTROL_MENU_MISC_2 then --Y
			return self:AnnounceRecipe(slot, recipepopup)
		elseif control == CONTROL_INVENTORY_USEONSCENE then --d-pad left
			return self:AnnounceRecipe(slot, recipepopup, 1)
		elseif control == CONTROL_INVENTORY_EXAMINE then --d-pad up
			return self:AnnounceRecipe(slot, recipepopup, 2)
		elseif control == CONTROL_INVENTORY_USEONSELF then --d-pad right
			return self:AnnounceRecipe(slot, recipepopup, 3)
		elseif control == CONTROL_INVENTORY_DROP and recipepopup.skins_spinner then --d-pad down
			return self:AnnounceSkin(recipepopup)
		end
	elseif HUD:IsControllerInventoryOpen()
	or (HUD.controls.status._weremode and HUD._statuscontrollerbuttonhintsshown) then
		local stat = self.button_to_stat[control]
		if stat and self.stats[stat].widget.shown then
			return self:Announce(self:ChooseStatMessage(stat))
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
	self.char_messages = STRINGS._STATUS_ANNOUNCEMENTS[prefab:upper()] or STRINGS._STATUS_ANNOUNCEMENTS.UNKNOWN
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