# Status-Announcements
A mod for [Don't Starve Together](http://store.steampowered.com/app/322330/) that lets you alt+click various parts of the HUD to announce in chat things related to them. Controllers can announce stuff too, and the buttons for announcing show up on the HUD elements you would alt+click when in Inventory or Crafting mode. You can also find this mod on the [Steam Workshop](http://steamcommunity.com/sharedfiles/filedetails/?id=343753877).

Things you can announce:

- Current hunger/health/sanity/wetness/log/temperature status. Alt+clicking your health badge will announce "I'm in perfect health!" if your health is full, or "I'm mortally wounded!" if it's very low. Sanity and hunger have different announcements specific to them ("AAAH! Stay back, beasts of darkness!"). Announcing temperature requires Combined Status.
- Craftable items in the craft tabs. If you know how to build it and you have the supplies, it will announce that you'll make one. If you don't know how to build it, it will ask if someone can make you one (e.g. you have a Wickerbottom and no science machine yet, and you want her to make you a backpack). If you know how to make one, but don't have the supplies for it, it will say "We need more [craftable]s". You can also announce skins for items you have.
- Ingredients for crafted items. Let's say night is falling and you have two twigs and one grass. Alt+clicking the grass in the torch recipe will announce "I need 1 more cut grass for a torch.".
- Items in your inventory and backpack. Since alt+click already does something for these, you'll have to hold down shift as well. This will announce that you have the item, and how many: "I have 10 dragonpies."
- Items in chests or other containers. This works the same way as inventory ones, but will announce something like "We have 8 dragonpies here in this icebox".
- By default, these are all whispered-- only displayed over your head-- but holding control in addition to the other modifiers will enter it into global chat. For controllers, hold Menu Misc 3, which by default is left-stick-click.


Character mods can add their own quotes if they want. You don't need to worry about mod load order, just add the quotes to `GLOBAL.STRINGS._STATUS_ANNOUNCEMENTS`. Make sure that you check if the table exists, and if not, make an empty one before adding your strings, like so:

`if not GLOBAL.STRINGS._STATUS_ANNOUNCEMENTS then GLOBAL.STRINGS._STATUS_ANNOUNCEMENTS = {} end`

See [announcestrings.lua](https://github.com/rezecib/Status-Announcements/blob/master/announcestrings.lua) for the format of the announcement strings. You can also look at one of these mods for examples of mod announcement strings:
- [Daniel, the Spectromancer](http://steamcommunity.com/sharedfiles/filedetails/?id=705076359) (this one also shows how to add announcements for a custom character stat)
- [Elec Man](http://steamcommunity.com/sharedfiles/filedetails/?id=645436044)