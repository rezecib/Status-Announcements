local WHISPER = false
local WHISPER_ONLY = false
local EXPLICIT = true
local OVERRIDEB = false
local SHOWDURABILITY = true
local SHOWPROTOTYPER = true

local setters = {
	WHISPER = function(v) WHISPER = v end,
	WHISPER_ONLY = function(v) WHISPER_ONLY = v end,
	EXPLICIT = function(v) EXPLICIT = v end,
	OVERRIDEB = function(v) OVERRIDEB = v end,
	SHOWDURABILITY = function(v) SHOWDURABILITY = v end,
	SHOWPROTOTYPER = function(v) SHOWPROTOTYPER = v end,
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

function StatusAnnouncer:AnnounceItem(item, percent, container, owner)
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
	local containerName = container.type and container.inst.name:lower()
	local name = item.name:lower()
	local has, num_found = container:Has(item.prefab, 1)
	num_found = num_found + num_equipped
	local i_have = ""
	local in_container = ""
	if containerName then -- this is a chest
		i_have = "We have "
		in_container = " in this " .. containerName
	else -- this is a backpack or inventory
		i_have = "I have "
	end
	local this_many = "" .. num_found
	local plural = num_found > 1
	local and_this_has_percent = percent and SHOWDURABILITY and
		(plural and ", and this one has " or " with ")..percent.." durability" or ""
	local a = "a"
	if string.find(name, "^[aeoiuAOIEU]") ~= nil then a = "an" end
	local s = "s"
	if (not plural) or string.find(name, "s$") ~= nil then
		s = ""
	end
	if this_many == nil then this_many = a end
	return self:Announce(i_have..this_many.." "..name..s..in_container..and_this_has_percent..".")
end

function StatusAnnouncer:AnnounceRecipe(slot, recipepopup, ingnum)
	local builder = slot.owner.replica.builder
	local buffered = builder:IsBuildBuffered(slot.recipe.name)
	local knows = builder:KnowsRecipe(slot.recipe.name)
	local can_build = builder:CanBuild(slot.recipe.name)
	local name = STRINGS.NAMES[slot.recipe.name:upper()]:lower()
	local a = "a"
	if string.find(name, "^[aeoiuAOIEU]") ~= nil then a = "an" end
	local s = "s"
	local ingredient = nil
	if recipepopup == nil then --mouse controls, we have to find the focused ingredient
		recipepopup = slot.recipepopup
		for i, ing in ipairs(recipepopup.ing) do
			if ing.focus then ingredient = ing end
		end
	else --controller controls, we pick it by number (determined by which button was pressed)
		ingredient = recipepopup.ing[ingnum]
	end
	if ((not ingredient) and (string.find(name, "s$") ~= nil))
		or (ingredient and (string.find(ingredient.tooltip:lower(), "s$") ~= nil)) then
		s = ""
	end
	if ingnum and ingredient == nil then return end --controller button for ing that doesn't exist
	--this doesn't support other languages, but... neither does the rest of the mod
	local prototyper = recipepopup.teaser.shown and recipepopup.teaser:GetString():gmatch("Use an? (.*) to")()
	if ingredient == nil then
		if buffered then
			return self:Announce("I have "..a.." "..name.." pre-built and ready to place.")
		elseif knows and can_build then
			return self:Announce("I'll make "..a.." "..name..".")
		elseif not knows then
			prototyper = prototyper and SHOWPROTOTYPER and " I would need a "..prototyper.." for it." or ""
			return self:Announce("Can someone make me "..a.." "..name.."?"..prototyper)
		else
			return self:Announce("We need more "..name..s..".")
		end
	else
		local num = 0
		local ingname = ingredient.ing.texture:sub(1,-5)
		local amount_needed = 1
		for k,v in pairs(slot.recipe.ingredients) do
			if ingname == v.type then amount_needed = v.amount end
		end
		local has, num_found = slot.owner.replica.inventory:Has(ingname, RoundBiasedUp(amount_needed * slot.owner.replica.builder:IngredientMod()))
		for k,v in pairs(slot.recipe.character_ingredients) do
			if ingname == v.type then
				amount_needed = v.amount
				has, num_found = slot.owner.replica.builder:HasCharacterIngredient(v)
				s = "" --health and sanity are already plural
			end
		end
		num = amount_needed - num_found
		local can_make = math.floor(num_found / amount_needed)*slot.recipe.numtogive
		if num == 1 then s = "" end
		if num > 0 then
			prototyper = prototyper and SHOWPROTOTYPER and " and a "..prototyper or ""
			return self:Announce("I need "..num.." more "..ingredient.tooltip:lower()..s..prototyper.." to make "..a.." "..name..".")
		else
			prototyper = prototyper and SHOWPROTOTYPER and ", but I need a "..prototyper or ""
			local recipe_s = can_make > 1 and "s" or ""
			return self:Announce("I have enough "..ingredient.tooltip:lower()..s.." to make "..can_make.." "..name..recipe_s..prototyper..".") 
		end
	end
end

function StatusAnnouncer:AnnounceSkin(recipepopup)
	local skin_name = recipepopup.skins_spinner.GetItem()
	local item_name = recipepopup.recipe.name
	if skin_name ~= item_name then --don't announce default skins
		return self:Announce("I have the "..GetName(skin_name)
				.." skin for the "..GetName(item_name)..".")
	end
end

function StatusAnnouncer:AnnounceTemperature(pronoun)
	local temp = ThePlayer:GetTemperature()
	local pronoun = pronoun or "I'm"
	local message = " at a comfortable temperature."
	local TUNING = TUNING
	if temp >= TUNING.OVERHEAT_TEMP then
		message = " overheating!"
	elseif temp >= TUNING.OVERHEAT_TEMP - 5 then
		message = " almost overheating!"
	elseif temp >= TUNING.OVERHEAT_TEMP - 15 then
		message = " a little bit hot."
	elseif temp <= 0 then
		message = " freezing!"
	elseif temp <= 5 then
		message = " almost freezing!"
	elseif temp <= 15 then
		message = " a little bit cold."
	end
	message = pronoun .. message
	if EXPLICIT then
		return self:Announce(string.format("(%d\176) %s", temp, message))
	else
		return self:Announce(message)
	end
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
function StatusAnnouncer:RegisterCommonStats(HUD, prefab, hunger, sanity, health, moisture, beaverness)
	local stat_categorynames = {"EMPTY", "LOW", "MID", "HIGH", "FULL"}
	local default_thresholds = {	.15,	.35,	.55,	.75		 }
	
	local has_beavermode = type(HUD.controls.status.beaverness) == "table"
	local switch_fn = has_beavermode
		and function(ThePlayer) return ThePlayer.isbeavermode:value() and "WEREBEAVER" or "HUMAN" end
		or nil 
	
	if hunger ~= false then
		self:RegisterStat(
			"Hunger",
			HUD.controls.status.stomach,
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
	if sanity ~= false then
		self:RegisterStat(
			"Sanity",
			HUD.controls.status.brain,
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
	if health ~= false then
		self:RegisterStat(
			"Health",
			HUD.controls.status.heart,
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
	if beaverness ~= false and has_beavermode then
		self:RegisterStat(
			"Log Meter",
			HUD.controls.status.beaverness,
			CONTROL_ROTATE_LEFT, -- Left Bumper
			{ .25, .5, .7, .9 },
			stat_categorynames,
			function(ThePlayer)
				return	ThePlayer.player_classified.currentbeaverness:value(),
						100 -- looks like the only way is to hardcode this; not networked
			end,
			switch_fn
		)
	end
	if moisture ~= false then
		self:RegisterStat(
			"Wetness",
			HUD.controls.status.moisturemeter,
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

function StatusAnnouncer:OnHUDMouseButton(HUD)
	for stat_name,data in pairs(self.stats) do
		if data.widget.focus then
			return self:Announce(self:ChooseStatMessage(stat_name))
		end
	end
	if HUD.controls.status.temperature and HUD.controls.status.temperature.focus then
		return self:AnnounceTemperature(HUD.controls.status._beavermode and "The beast is" or nil)
	end
end

function StatusAnnouncer:OnHUDControl(HUD, control)
	if HUD:IsControllerCraftingOpen() then
		local cc = HUD.controls.crafttabs.controllercrafting
		if control == CONTROL_MENU_MISC_2 then --Y
			return self:AnnounceRecipe(cc.oldslot, cc.recipepopup)
		elseif control == CONTROL_INVENTORY_USEONSCENE then --d-pad left
			return self:AnnounceRecipe(cc.oldslot, cc.recipepopup, 1)
		elseif control == CONTROL_INVENTORY_EXAMINE then --d-pad up
			return self:AnnounceRecipe(cc.oldslot, cc.recipepopup, 2)
		elseif control == CONTROL_INVENTORY_USEONSELF then --d-pad right
			return self:AnnounceRecipe(cc.oldslot, cc.recipepopup, 3)
		elseif control == CONTROL_INVENTORY_DROP and cc.recipepopup.skins_spinner then --d-pad down
			return self:AnnounceSkin(cc.recipepopup)
		end
	elseif HUD:IsControllerInventoryOpen()
	or (HUD.controls.status._beavermode and HUD._statuscontrollerbuttonhintsshown) then
		local stat = self.button_to_stat[control]
		if stat and self.stats[stat].widget.shown then
			return self:Announce(self:ChooseStatMessage(stat))
		end
		if OVERRIDEB and HUD.controls.status.temperature and control == CONTROL_CANCEL then
			return self:AnnounceTemperature(HUD.controls.status._beavermode and "The beast is" or nil)
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
	local messages = self.stats[stat].switch_fn
						and self.char_messages[self.stats[stat].switch_fn(ThePlayer)]
						or self.char_messages
	--nice-looking version
	-- local category = get_category(self.stats[stat].thresholds, percent)
	-- local category_name = self.stats[stat].category_names[category]
	-- local message = messages[stat:upper()][category_name]
	--dirty but efficient version (just substituting in the variables)
	local message = messages[stat:upper()][self.stats[stat].category_names[get_category(self.stats[stat].thresholds, percent)]]
	if EXPLICIT then
		return string.format("(%s: %d/%d) %s", stat, cur, max, message)
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
end

function StatusAnnouncer:SetLocalParameter(parameter, value)
	if setters[parameter] then setters[parameter](value) end
end

return StatusAnnouncer