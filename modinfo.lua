--The name of the mod displayed in the 'mods' screen.
name = "Status Announcements"

--A description of the mod.
description = "Alt-click parts of the HUD to announce their status (\"I'm wounded!\", \"I have 2 twigs.\", \"We need more drying racks.\"). ALT+SHIFT click to announce items."

--Who wrote this awesome mod?
author = "rezecib"

--A version number so you can ask people if they are running an old version of your mod.
version = "2.2.1"

--This lets other players know if your mod is out of date. This typically needs to be updated every time there's a new game update.
api_version = 10

dst_compatible = true

--This lets clients know if they need to get the mod from the Steam Workshop to join the game
all_clients_require_mod = false

--This determines whether it causes a server to be marked as modded (and shows in the mod list)
client_only_mod = true

--This lets people search for servers with this mod by these tags
server_filter_tags = {}

icon_atlas = "statusannouncements.xml"
icon = "statusannouncements.tex"

forumthread = "http://forums.kleientertainment.com/files/file/923-dst-status-announcements"

--[[
Credits:
    Silentdarkness1 for coming up with most of the character-specific quotes,
	Acemurdock and OSMRhodey for helping out with the Woodie quotes,
	and SuperPsiPower (and friends) for helping out with the Webber quotes.
]]

configuration_options =
{
	{
		name = "WHISPER",
		label = "Whisper by default",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = false,
	},
	{
		name = "EXPLICIT",
		label = "Show current/max",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
		hover = "When announcing stats, show the numbers for your current and max stat.",
	},
	{
		name = "SHOWPROTOTYPER",
		label = "Announce Prototyper",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
		hover = "When announcing a crafting recipe, whether to announce that you need a science machine or another prototyper.",
	},
	{
		name = "SHOWDURABILITY",
		label = "Announce Durability",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
		hover = "Whether to announce the durability of an item when announcing that you have it.",
	},
	{
		name = "OVERRIDEB",
		label = "Controller Cancel",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
		hover = "When controller inventory is open, allow the B/cancel button\nto be used to announce temperature.",
	},
	{
		name = "WILSON",
		label = "Custom Wilson Quotes",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
	},
	{
		name = "WILLOW",
		label = "Custom Willow Quotes",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
	},
	{
		name = "WX78",
		label = "Custom WX-78 Quotes",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
	},
	{
		name = "WICKERBOTTOM",
		label = "Custom Wickerbottom Quotes",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
	},
	{
		name = "WOLFGANG",
		label = "Custom Wolfgang Quotes",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
	},
	{
		name = "WENDY",
		label = "Custom Wendy Quotes",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
	},
	{
		name = "WOODIE",
		label = "Custom Woodie Quotes",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
	},
	{
		name = "WES",
		label = "Custom Wes Quotes",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
	},
	{
		name = "WAXWELL",
		label = "Custom Maxwell Quotes",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
	},
	{
		name = "WEBBER",
		label = "Custom Webber Quotes",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
	},
	{
		name = "WATHGRITHR",
		label = "Custom Wigfrid Quotes",
		options =	{
						{description = "Yes", data = true},
						{description = "No", data = false},
					},
		default = true,
	},
}