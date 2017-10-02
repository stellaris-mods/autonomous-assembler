# Steam description

[//]: # (start)
Steam description transliterated from `steam.bbcode` by [our release script](https://raw.githubusercontent.com/stellaris-mods/scripts/master/stlrel).

## **Fully autonomous construction ship for players**
It never made much sense to me that you could build robots, but not autonomous construction ships\.
With this mod, you can\.

Autonomous Assemblers is a new ship type that unlocks after a tier 1 Engineering technology\. When the game starts, a random player will be asked if he wants all players to start with the technology automatically\. The player gets 3 questions, all disabled by default:

1. "Free Autonomous Assembler technology", automatically grants everyone (including AIs) the technology required to build the ship at game start
1. "Enable Military Station Complex technology", enables this specific extra rare engineering technology for this game
1. "Free Autonomous Assembler when researched", when anyone researches the technology, they get a free ship along with it\. This also gives you a free ship at the start, if you enable option 1 above\.



The Autonomous Assemblers can be used and commanded as regular construction ships any time you want, except during the actual construction of a station\. If you want to take control of one during construction (they will have the red "lock" icon in the Outliner), you need to go to Special Projects and either send them to a colony, or halt operations\.

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

* Expansion Slot 1: Scans all planetary objects inside our space for Special Resources, and then any colonized system for any orbital research deposits, and finally any high\-yielding (2\+) research deposits inside our borders \- and constructs a Research Station at the location, if needed\.
* Expansion Slot 2: Constructs a Research Station at any orbital deposit that can benefit us\.



**Mineral Expansion Card**

* Expansion Slot 1: Finds any orbital mineral deposit in colonized systems, any high\-yielding deposit inside our borders, or any minable special resource, and creates a Mining Station there if needed\.
* Expansion Slot 2: Constructs a Mining Station at any orbital mineral deposit that can benefit us\.



**Energy Expansion Card**

* Expansion Slot 1: Finds any orbital energy deposit in colonized systems, any high\-yielding deposit inside our borders, or any minable special resource, and creates a Mining Station there if needed\.
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



## Future plans
**Planned Cards**
I want to make expansion cards for Frontier Outposts and Observation Stations\. The mod does easily support 3rd party addons adding in extra expansion cards, please read the code if you want to do that\. Or talk to me (but not on Steam)\.

**Wormhole Card**
Support autonomous construction inside the borders of countries we have the Wormhole treaty with\.

**Random failures**
I want to add some random failures (rarely, of course) to the onboard computer equipment\. The way I'd implement this, if I do, is probably either to disable the ship somewhere and require a science/construction vessel to "repair" it in space, or physically drain a percentage of its hitpoints\.

**Damaged ship**
I want to make a new autonomous behavior where it flies back and repairs itself, if necessary and possible\.

## Known problems
The ships do not try to escape if a hostile fleet enters a system while they are locked during construction\.

Station Marker military stations are currently deployed instantly when an Autonomous Assembler reaches it\.

## Compatibility
It is compatible with existing save games, but you need to research the technology to get access to the ships then\. The initial menu will not be shown\.

This mod is, as far as I know, compatible with every other addon that exists\.

## Replaced files
This mod does not replace any vanilla files\.

## Communicating with me
I do not like Steam, because the barrier to entry for commenting on a workshop page is too low\. I spent effort on my projects, and I don't care to read feedback from people who make little effort to provide it\. Of course, there's no rule without exceptions, and if \- at any time \- I do in fact read the comments, it's always nice to see one\-line "thank you for the mod"\-type comments\.
You may file bug reports on github; all my Stellaris mods are listed there\. The repository is easy enough to find, if you care to look\.

I am also on the NSC Discord server, which is also easy to find\.
Other than that, if you can't be bothered to contact me through those means, I don't care what you have to say\.

That said, since this mod is so new, I might actually read comments here for a week or two\.


[//]: # (stop)
