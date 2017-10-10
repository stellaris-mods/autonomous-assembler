# Autonomous Assembler

## Found a problem?

If you find a problem, you might want to:
1. Load up a save 2-3 months (or more) before the problem happens
1. Open the Stellaris ingame console
1. Run the command `effect set_global_flag = debug`
1. Let the game run until the problem occurs
1. Give me a copy of the log files `error.log` and `game.log`, either on [hastebin](https://hastebin.com) or tar/zip them and upload them for me somewhere

After you load a savegame, you need to enter `effect set_global_flag = debug` every time, unless you saved the game after you did that - then it will persist. To remove it again, enter `effect remove_global_flag = debug`.

## Known error.log entries

The mod unfortunately produces a few known error.log lines that I can't avoid easily. If you see any errors besides these, please do file a bug report! Or if you know how I can retain the same functionality and not produce the error.log output (I don't think that's possible, except by moving some of the functionality into a 3rd party "compatibility" mod), please let me know.
```
[14:40:42][component.cpp:497]: Component "ASS_TYPE_XLARGE" has invalid technology "tech_battle_fortress_1".
[14:40:43][effect_impl.cpp:3380]: Could not find ship size specified for create_ship effect!
File: events/ass_controller_marker.txt
Line: 100
[14:40:44][effect_impl.cpp:3380]: Could not find ship size specified for create_ship effect!
File: common/scripted_effects/ass_op_military.txt
[14:40:44][ship_size.cpp:414]: invalid component set "sc_friendly_aura" in ship size autonomous_assembler
[14:40:44][ship_size.cpp:414]: invalid component set "sc_defense_aura" in ship size autonomous_assembler
[14:40:44][ship_size.cpp:414]: invalid component set "station_architecture_components" in ship size ass_military_complex
[14:40:45][trigger_impl.cpp:3155]: is_ship_size trigger at file: common/scripted_triggers/ass_op_military_triggers.txt line: 46 has an invalid ship size.
[14:40:45][effect_impl.cpp:1128]: Error in fire event effect at file: events/addonmenu.txt line: 88, could not find event: TNF.1
[14:40:45][effect_impl.cpp:1128]: Error in fire event effect at file: events/addonmenu.txt line: 94, could not find event: zhowstart.10
[14:40:45][effect_impl.cpp:1128]: Error in fire event effect at file: events/addonmenu.txt line: 124, could not find event: tnfMenu.1
[14:40:45][effect_impl.cpp:1128]: Error in fire event effect at file: events/addonmenu.txt line: 132, could not find event: zhowstart.3
[14:40:45][trigger_impl.cpp:3155]: is_ship_size trigger at file: common/scripted_triggers/ass_op_military_triggers.txt line: 46 has an invalid ship size.
```

Most of them are to remain compatible with New Ship Classes & More, and the rest are for That's Not Fair, A Stellaris Remake, and some other mod that I forgot the name of.

## 3rd Party Ship Sets

If you're the author of a 3rd party graphical culture/shipset, the `autonomous_assembler` and `ass_military_complex` entities are straight up copies of the vanilla `construction` and `terraforming_station` entities. Unfortunately, I can't reuse the existing entity data.

## Future plans
**Planned Cards**
I want to make expansion cards for Frontier Outposts and Observation Stations\. The mod does easily support 3rd party addons adding in extra expansion cards, please read the code if you want to do that\. Or talk to me (but not on Steam)\.

**Random failures**
I want to add some random failures (rarely, of course) to the onboard computer equipment\. The way I'd implement this, if I do, is probably either to disable the ship somewhere and require a science/construction vessel to "repair" it in space, or physically drain a percentage of its hitpoints\.

**Damaged ship**
I want to make a new autonomous behavior where it flies back and repairs itself, if necessary and possible\.

## Steam description

[//]: # (start)
Steam description transliterated from `steam.bbcode` by [our release script](https://raw.githubusercontent.com/stellaris-mods/scripts/master/stlrel).

## **Fully autonomous construction ship for players**
It never made much sense to me that you could build robots, but not autonomous construction ships\.
With this mod, you can\.

Compatible with all addons I can think of, and also explicitly cross\-compatible with Autobuild, by had\.

Autonomous Assemblers is a new ship type that unlocks after a tier 1 technology\. When the game starts, a random player will be asked if he wants all players to start with the technology automatically\. The player gets 3 questions, all disabled by default:

1. "Free Autonomous Assembler technology", automatically grants everyone (including AIs) the technology required to build the ship at game start
1. "Enable Military Station Complex technology", enables this specific extra rare engineering technology for this game
1. "Free Autonomous Assembler when researched", when anyone researches the technology, they get a free ship along with it\. This also gives you a free ship at the start, if you enable option 1 above\.



The Autonomous Assemblers can be used and commanded as regular construction ships any time you want, including while enroute during an autonomous operation \- except during the actual construction of a station, while locked\. If you want to take control during construction (they will have the red "lock" icon in the Outliner), you need to go to Special Projects and either send them to a colony, or halt operations\.
You can build as many as you want, and outfit them with different expansion cards\.

## Autonomous Assembler Expansion Cards
The ship can be equipped with two expansion cards that determine its behavior\. There is no artificial intelligence on the ship, as such \- it's more like an automated lawn mower than\. Each expansion card must be outfitted on the ship before it's launched, but they can be recalled and updated to a new layout later\.

The ship has 2x slots for expansion cards\. It's **very important** that you examine the card descriptions in detail, and understand that they behave differently depending on which slot you insert them into\. And make note of wording; some cards may for example say "any system", and that would include any system even outside your borders\.

**Wormhole Expansion Card**

* Expansion Slot 1: This expansion card will scan colonized systems for Wormhole stations, and if it does not find one we control, it will direct the ship towards that solar system and construct a Wormhole station\.
* Expansion Slot 2: Calculates distances between solar systems and attempts to find any that are on the edge of our jump range, and moves there to construct Wormhole Stations\.



**Military Expansion Card**

* Expansion Slot 1: Locates any Station Markers constructed inside our borders, moves there to set up a network of military stations around it\. Then, finds the closest colonized system without a military station, and builds one there\.
* Expansion Slot 2: Attempts to construct a military station in _every star system within our borders_\.



**Research Expansion Card**

* Expansion Slot 1: Scans all planetary objects inside our borders for Special Resources, or any high\-yielding (2\+) research deposits inside our borders \- and constructs a Research Station at the location, if needed\.
* Expansion Slot 2: Constructs a Research Station at any orbital deposit that can benefit us\.



**Mineral Expansion Card**

* Expansion Slot 1: Finds any high\-yielding Mineral deposit inside our borders, or any minable special resource, and creates a Mining Station there if needed\.
* Expansion Slot 2: Constructs a Mining Station at any orbital mineral deposit that can benefit us\.



**Energy Expansion Card**

* Expansion Slot 1: Finds any high\-yielding Energy deposit inside our borders, or any minable special resource, and creates a Mining Station there if needed\.
* Expansion Slot 2: Constructs a Mining Station at any orbital energy deposit that can benefit us\.



## Station Marker
The Station Marker is a new kind of military station gated behind a new rare technology that is **disabled by default**\. Constructing this marker allows your Autonomous Assemblers outfitted with a Military Expansion Card in slot 1 to build a hexagon\-shaped defense cluster of military stations, just like in the old days of Stellaris\. If you play with NSC, you should enable this option, because NSC has not adjusted the build block radius for vanilla military stations to match vanilla levels\.

Currently, once used, a marker will never be used again\. I plan on making it such that the Autonomous Assemblers attempt to maintain the 6 stations spawned around the marker (given the budget, of course)\.

When you design a station marker, you select a special component to equip it with that instructs any Autonomous Assembler on which kind of military station to construct around it\. This component also adjusts the price of the marker station to include the cost of any military station type that will be built\. The resources are then stored onboard the Station Marker until an Autonomous Assembler begins the construction process\.

If a Station Marker is destroyed before an Autonomous Assembler can complete construction of the 6 military stations around it, the resources are lost\.

## Ship Combat Statistics
The Autonomous Assembler more closely resembles a Corvette than a Construction Ship in terms of combat statistics\. It has exceptional evasion, combat speed, and sublight speed right off the bat, and can be further upgraded with new and improved central processing units\.

## Special Projects
In your empires special projects screen, you will find a new section dedicated to controlling your Autonomous Assemblers, where you can:

* Increase/decrease the reserved resources, which limits how low the assemblers can drain your empires mineral reserves (default: 100, increments of \+/\- 500)
* Halt/continue operations, which permanently halts or continues all autonomous operations (they can still be used as normal construction ships, manually, while halted)
* Set course for colony, which immediately (even if they're currently building something) halts all operations and makes all Autonomous Assemblers head for the nearest colonized planet, and once docked, will stay there for 3 months before re\-starting operations


All the projects are free, they just take time\. Also, they all reset every time you build or lose an assembler, and any time you complete a project\. Nothing I can do about this, unfortunately\.

## Known problems
There are no known problems\.

## Compatibility
Compatible with existing save games, but you need to research the technology to get access to the ships\. The menu only shows in new games\.

This mod is, as far as I know, compatible with all other addons\. Including Autobuild\. That's not a promise, but if the author of the other mod is not an idiot, they should not conflict\.

Anything labelled a "Total Conversion" is not in the category of a "mod" or "addon", in case that has to be explicitly mentioned\. Obviously some TCs could be compatible, or they already are \- I don't know, and I don't care\. Any other mod that wants to add explicit compatibility with Autonomous Assembler is free to do so\.

## Replaced files
This mod does not replace any vanilla files\.

## Changelog
Though Steam provides a way to list changes between uploads, there is no way I can automate this, so now you need to find the release notes on Github\.

## Communicating with me
You may file bug reports on Github\. All my Stellaris mods are listed there\.


[//]: # (stop)
