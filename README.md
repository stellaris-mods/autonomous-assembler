# Autonomous Assembler

<!-- TOC -->

- [Found a problem?](#found-a-problem)
- [Known error.log entries](#known-errorlog-entries)
- [How to add 3rd party spaceport modules/expansion cards/etc](#how-to-add-3rd-party-spaceport-modulesexpansion-cardsetc)
	- [Overriding scripted_effects/triggers (objects)](#overriding-scripted_effectstriggers-objects)
	- [A note about global flags](#a-note-about-global-flags)
	- ["Debugging"](#debugging)
	- [Adding a new Expansion Card](#adding-a-new-expansion-card)
	- [Adding support for your own Spaceport Module](#adding-support-for-your-own-spaceport-module)
	- [Adding support for your spaceport extension mod](#adding-support-for-your-spaceport-extension-mod)
- [3rd Party Ship Sets](#3rd-party-ship-sets)
- [Future plans](#future-plans)
- [Steam description](#steam-description)
	- [**Fully autonomous construction ship for players**](#fully-autonomous-construction-ship-for-players)
	- [Expansion Cards](#expansion-cards)
	- [Station Marker](#station-marker)
	- [Ship Combat Statistics](#ship-combat-statistics)
	- [Special Projects](#special-projects)
	- [Known problems](#known-problems)
	- [Compatibility](#compatibility)
	- [Replaced files](#replaced-files)
	- [Changelog](#changelog)
	- [Communicating with me](#communicating-with-me)

<!-- /TOC -->

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

## How to add 3rd party spaceport modules/expansion cards/etc

Regardless of what you're doing, please read the whole README, and not just the one you're specifically interested in.

All the instructions here should be mostly valid for the git version of the addon. For the live version, you will have to find README.mds git history and read it there.

### Overriding scripted_effects/triggers (objects)
(overwrite, override, overload, whatever)

There are two really simple rules for this:
*  If your mod loads _before_ the mod that contains the object you want to override: Your objects need to be in a file with the **same** name as the file that contains the objects you want to override. In this case, all objects present in the original file need to be present in your copy, or you will most likely cause some problems
*  Alternativey, if your mod loads _after_ the mod that contains the objects you want to override: Your objects need to be in a file with a **different** name, _and_ the filename must be something that will load **after** the original filename, in natural sort order. In this case your file should only contain the objects you actually want to override

In both cases, your objects need to have the same name as the ones you are overriding, obviously.

### A note about global flags
The `gf_alphamodplus` and `has_renegade_spaceports` global flags can be used to check for whether or not these addons are were active `on_game_start`. You should know, if you're adding support for a new spaceport module for example, that if a user ever had one of these addons present in their game, the flags remain until manually removed.

You should also know that, as of right now, neither of these addons will set the flags if enabled _after_ the `on_game_start` action has triggered. Which means that if a player installs one of those addons _after_ initial game start, the flags will **not** be set.

This is rarely going to cause a problem, but you should be aware of it.

Autonomous Assembler doesn't actually check these flags currently, but rather invokes scripted effects that they override when enabled. This means that AA works regardless of the global flag state.

Flags can be removed from the ingame console with for example `effect remove_global_flag = gf_alphamodplus`.

### "Debugging"
Many of my addons log a lot of output to `game.log` if the global flag `debug` is set. You can set this from the ingame console like `effect set_global_flag = debug`.

For Autonomous Assembler, specifically, most of its operations have their construction time divided by 10 if this flag is set.

### Adding a new Expansion Card
1. Add a new `utility_component_template` that uses `component_set = "ass_expansion_slot_1/2"`.
1. Override, or talk to me about invoking your effect from, `ass_init_stage1_3rd_p1` or `ass_init_stage1_3rd_p2` depending on the slot. In all stage1 effects, ROOT is always the ship. This effect will be invoked `on_monthly_pulse` if an assembler is idle.
1. In your stage1 mission effect, see if there's a valid operation the ship can perform for your card, and if there is not, then simply do nothing. The rest of the steps below assume you found a valid mission target.
1. Set `AssConstructionTime` on the fleet to however long it takes to perform the operation once the ship arrives at its target - or don't, if you handle this yourself.
1. Set `AssOperationCost*` depending on what it costs to build whatever you're building.
1. Invoke `ass_relation_flag_planet/fleet/system = yes` so that the Assembler knows where it wants to go. These effects need to be invoked in the scope of the target relation (and ROOT still needs to be the ship). This also sets the `ass_target` flag on the target, which prevents other assemblers from picking it.
1. Invoke either `ass_stage2_planet_move`, `ass_stage2_fleet_move`, `ass_stage2_system_move`, in the scope of the target - or implement your own movement method (you will probably never need to do that). All these effects set the fleet flag `autonomous_operation`.
1. When the assembler reaches the target, `ass_init_stage3_3rd` will be invoked. Verify that the trigger conditions you used to set up the mission are still valid, and if not, you want to `ass_stage4_abort_operation`. You don't need to overwrite `ass_init_stage3_3rd` unless your operation is very untraditional. All the operations included in the addon use this effect. It chains to `ass_stage3_build` if the operation can be afforded by the country, or aborts if standard conditions are not valid, or sets the "wait for cash" flag and waits.
1. In your override of `ass_stage3_build_3rd`, you should start building. Typically, this is done by simply invoking `ass_stage3_start_construction`.
1. If you want to build immediately, simply do so. Alternatively, if you set `AssConstructionTime`, the ship counts it down and then invokes `ass_stage4_complete_3rd`.
1. In your mission complete effect, ROOT and THIS is the ship. You need to do the following: (1) remove the relation flag, either directly on the target by removing the planet/star/fleet ass_target flag and zeroing the AssUUID variable, and then removing the `ass_relation_fleet/planet/star` flag from the assembler, or you can simply invoke `ass_relation_remove_any = yes` which is a bit more costly. And (2) actually instantly perform whatever operation the card you're adding performs, and then (3) invoke `ass_stage4_operation_complete = yes`, which in turn invokes `ass_3rd_op_complete` that you can override.

The way you set the operation cost for a mission is to set the variables `AssOperationCost` (minerals), `AssOperationCostEnergy`, and/or `AssOperationCostInfluence` in stage 1. These obviously have to be set on the assemblers fleet scope.

### Adding support for your own Spaceport Module
You can do it without talking to me, but then you will need to override the whole `ass_3rd_party.txt` file, and handle it whenever I update the mod. Alternatively, talk to me and we will make the mods cooperate. Regardless, read the rest. And also, please read this whole readme.

1. For each of your modules, copy 1x of the `ass_stage1_sm_*` effects from `common/scripted_effects/ass_op_sm_vanilla.txt` and change things like the module reference and costs accordingly.
1. The cost variables available are `AssOperationCost` (minerals), `AssOperationCostEnergy`, and `AssOperationCostInfluence`. Also, `AssConstructionTime` should be the build time of your module.
1. The module-specific flag (i.e. `ass_op_sm_battleship_assembly_yards`), can be named anything you want that doesn't conflict with other addons. You will need to remove this flag yourself later, when the operation completes or aborts.
1. Optionally, if you don't want to use `random_owned_planet` to find the "best" target planet, you can use any code you want to select the planet to build on, based on any conditions you want. Most other operations/expansion cards in the mod use `closest_system`, for example.
1. Make sure your `ass_stage1_sm_*` effects are invoked from `ass_stage1_sm_3rd_pre` or `ass_stage1_sm_3rd_post`, somehow. Either override `ass_3rd_party.txt` or talk to me.
1. If your addon adds new spaceport slots _and_ modules, make sure you hook into `ass_stage4_sm_3rd_build_pre`. If your addon _only_ adds modules, make sure you hook into `ass_stage4_sm_3rd_build_post`.
1. In your `ass_stage4_sm_3rd_build_*` effect, you should have a `switch` that triggers on the ships slot flag (just as a small aside, the reason we use a flag and not a 1-19 number variable is because you can't `switch` on a variable, which means that we would have to use a huge if-else-if statement instead, which looks horrible), and place your module manually like this, per slot:
   ```
   ass_op_sm_slot_1 = { # This number should ...
      remove_ship_flag = "ass_op_sm_build"
      event_target:ass_target = { set_spaceport_module = { module = "my_module" slot = 1 } } # ... match this one (duh).
   }
   ```
1. It's important that you remove the `ass_op_sm_build` flag _only_ if you actually handle the construction. Your build effect can handle `ass_op_sm_slot_1-19`, or even more, if you want. It will produce a (harmless, though annoying) error.log entry for any slot that doesn't exist.
1. Autonomous Assembler supports slots 1-19 if the correct 3rd party spaceport extending addons are installed. If you prefer not to get the (again harmless, but annoying) errors for those extra slots in your addon, there are three alternatives: (1) disable your autonomous assembler integration when the global flags `gf_alphamodplus` or `has_renegade_spaceports` are _not_ set (this only prevents the errors during play, not at startup), or (2) put support for building your spaceport modules in slots 7-19 in a 3rd party compatibility addon ("My Addon: AUTOASS+Extended Spaceport Compatibility Mod"), or finally (3) successfully beg the authors of the spaceport extension addons to add AUTOASS support for your module (I don't recommend this last option).
1. Make sure you hook into `ass_stage4_sm_3rd_remove_data` somehow to remove any module-specific ship/fleet-flags or nonstandard variables you set on the assembler ship/fleet/target. Except for the per-module build flag, which is important that you remove, this is mostly to de-clutter the `debugtooltip`.

Remember that for your per-module `ass_stage1_sm_*` effects, you need to copy the `ass_valid_spaceport_module_planet` trigger out of this mod and into yours with a **different name**. You should _not_ use `ass_valid_spaceport_module_planet = yes` anywhere in your addon. Well, you can, technically, just remember that it will produce (harmless) error log output if AUTOASS is not installed/enabled.

Here's a complete example of an addon that adds support for a new spaceport module to Autonomous Assembler. This is all placed in a new file in `common/scripted_effects`. All the effects in the code below can be named anything you want - you don't have to use the convoluted `am_spaceports_ass_stage1_sm_pre` name, for example. You can call it `mymod_prebuild_module` or `myAddonSpModPre` or whatever you want that doesn't conflict easily with other addons.
```
#######################
# OUR OWN EFFECTS
#

# THIS is the blueprint planet
# ROOT is the autonomous assembler ship
ass_maybe_build_alpha_orbital_labs = {
	if = {
		limit = {
			# All these "maybe-build" effects are invoked in a row
			ROOT = { NOT = { has_ship_flag = "ass_op_spaceport_modules" } }
			has_spaceport_module = alpha_orbital_labs
		}
		owner = {
			# Or you could use closest_system to find the nearest planet that needs the module
			# or whatever other effects/system/conditions you want
			# Note that if no planet exists that match these conditions, we do nothing.
			random_owned_planet = {
				limit = {
					# --- Snip this into a scripted trigger for ease
					NOT = { has_planet_flag = "ass_target" }
					has_spaceport = yes
					has_spaceport_construction = no
					has_free_spaceport_module_slot = yes
					is_occupied_flag = no
					has_ground_combat = no
					controller = { is_same_value = ROOT.owner }
					# ---
					NOT = { has_spaceport_module = alpha_orbital_labs }
					can_build_spaceport_module = alpha_orbital_labs
				}
				ROOT = {
					# Set mineral cost and construction time
					fleet = { set_variable = { which = "AssOperationCost" value = 500 } }
					#fleet = { set_variable = { which = "AssOperationCostEnergy" value = 500 } }
					#fleet = { set_variable = { which = "AssOperationCostInfluence" value = 500 } }
					fleet = { set_variable = { which = "AssConstructionTime" value = 180 } }

					# You control this flag entirely, and can name it anything you want
					set_ship_flag = "ass_op_sm_alpha_orbital_labs"

					# Always set this flag, it instructs the ship to perform this operation
					set_ship_flag = "ass_op_spaceport_modules"
				}
				log = "[root.GetName]: Constructing alpha_orbital_labs at [this.GetName]."

				# Always save the planet as ass_target
				save_event_target_as = ass_target
			}
		}
	}
}

ass_build_alpha_orbital_labs = {
	switch = {
		trigger = has_ship_flag
		ass_op_sm_slot_1 = {
			# Always remove this flag if you "handle" the build, and never remove it if you don't handle it
			# If this stage of the operation is reached and no effects remove this flag, the planet
			# gets marked with planet flag ass_error for 2 years, which should prevent any other operation.
			# The operation costs will also be refunded to the player.
			# Also, the "fake" spaceport placeholder module is also removed, so the only "damage" to the
			# player is the time lost on constructing something that didn't work.
			# Anyway, if all mods add their support for AUTOASS correctly, this problem "should never happen" :-P
			remove_ship_flag = "ass_op_sm_build"
			event_target:ass_target = {
				# It puts our modules in the slots!
				set_spaceport_module = {
					module = "alpha_orbital_labs"
					slot = 1
				}
			}
		}
		ass_op_sm_slot_2 = { remove_ship_flag = "ass_op_sm_build" event_target:ass_target = { set_spaceport_module = { module = "alpha_orbital_labs" slot = 2 } } }
		ass_op_sm_slot_3 = { remove_ship_flag = "ass_op_sm_build" event_target:ass_target = { set_spaceport_module = { module = "alpha_orbital_labs" slot = 3 } } }
		ass_op_sm_slot_4 = { remove_ship_flag = "ass_op_sm_build" event_target:ass_target = { set_spaceport_module = { module = "alpha_orbital_labs" slot = 4 } } }
		ass_op_sm_slot_5 = { remove_ship_flag = "ass_op_sm_build" event_target:ass_target = { set_spaceport_module = { module = "alpha_orbital_labs" slot = 5 } } }
		ass_op_sm_slot_6 = { remove_ship_flag = "ass_op_sm_build" event_target:ass_target = { set_spaceport_module = { module = "alpha_orbital_labs" slot = 6 } } }
		# You can add as many flags down as you want, but if no addon adds any more levels,
		# you get error.log output (that is otherwise harmless) per slot.
		ass_op_sm_slot_7 = { remove_ship_flag = "ass_op_sm_build" event_target:ass_target = { set_spaceport_module = { module = "alpha_orbital_labs" slot = 7 } } }
		...
		ass_op_sm_slot_19 = { remove_ship_flag = "ass_op_sm_build" event_target:ass_target = { set_spaceport_module = { module = "alpha_orbital_labs" slot = 19 } } }
	}
}

#######################
# TALK TO FOLK ABOUT AUTOASS INVOKING THESE FOR ME
# Alternatively, override his effects in common/scripted_effects/ass_3rd_party.txt
# that would invoke them, and make sure you update your addon whenever needed.
#

# This effect is invoked before vanilla modules are checked
am_spaceports_ass_stage1_sm_pre = {
	# Prioritize our alpha_orbital_labs over vanilla modules
	ass_maybe_build_alpha_orbital_labs = yes
}

# This effect is invoked after vanilla modules are checked
am_spaceports_ass_stage1_sm_post = {
	# Add our other modules here
}

# This effect is invoked after the mission is completed OR aborted,
# just to clean up unused ship/fleet/etc flags and variables
# (decluttering the debugtooltip mostly)
am_spaceports_ass_stage4_sm_remove_data = {
	remove_ship_flag = "ass_op_sm_alpha_orbital_labs"
}

# This effect is invoked after the vanilla construction effects,
# which means that this is where you will need to actually pop the
# module into place.
am_spaceports_ass_stage4_sm_complete = {
	switch = {
		trigger = has_ship_flag
		ass_op_sm_alpha_orbital_labs = { ass_build_alpha_orbital_labs = yes }
	}
}
```

### Adding support for your spaceport extension mod

If you add more slots to the vanilla spaceport, and you want to add support for those slots, you need a few things:
1. You need to add an `ass_stage1_sm_set_slot` scripted effect that looks like the one in this addon, only extended to as many slots as you add
1. Tell me about it, or override the required files and wait for people to cry because things break
1. Implement an `ass_stage4_complete_build_*` effect for your mod, where handle (at a minimum) the vanilla spaceport modules

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

### **Fully autonomous construction ship for players**
It never made much sense to me that you could build robots, but not autonomous construction ships\.
With this mod, you can\.

Compatible with all addons I can think of, and also explicitly cross\-compatible with Autobuild, by had\.

Autonomous Assemblers is a new ship type that unlocks after a tier 1 technology\. When the game starts, a random player will be asked if he wants all players to start with the technology automatically\. The player gets 3 questions, all disabled by default:

1. "Free Autonomous Assembler technology", automatically grants everyone (including AIs) the technology required to build the ship at game start
1. "Enable Military Station Complex technology", enables this specific extra rare engineering technology for this game
1. "Free Autonomous Assembler when researched", when anyone researches the technology, they get a free ship along with it\. This also gives you a free ship at the start, if you enable option 1 above\.



The Autonomous Assemblers can be used and commanded as regular construction ships any time you want, including while enroute during an autonomous operation \- except during the actual construction of a station, while locked\. If you want to take control during construction (they will have the red "lock" icon in the Outliner), you need to go to Special Projects and either send them to a colony, or halt operations\.
You can build as many as you want, and outfit them with different expansion cards\.

### Expansion Cards
The ship can be equipped with two expansion cards that determine its behavior\. There is no artificial intelligence on the ship, as such \- it's more like an automated lawn mower than\. Each expansion card must be outfitted on the ship before it's launched, but they can be recalled and updated to a new layout later\.

The ship has 2x slots for expansion cards\. It's **very important** that you examine the card descriptions in detail, and understand that they behave differently depending on which slot you insert them into\. And make note of wording; some cards may for example say "any system", and that would include any system even outside your borders\.

**Spaceport Modules Card**
Expansion Slot 2 exclusively: Listens for the Assembly Blueprint subspace signal and reacts to any Spaceport Module blueprints that are broadcast\. If any colonized planets deviate from the blueprint, goes there and assembles as appropriate\.

**Wormhole Card**

* Expansion Slot 1: This expansion card will scan colonized systems for Wormhole stations, and if it does not find one we control, it will direct the ship towards that solar system and construct a Wormhole station\.
* Expansion Slot 2: Calculates distances between solar systems and attempts to find any that are on the edge of our jump range, and moves there to construct Wormhole Stations\.



**Military Card**

* Expansion Slot 1: Locates any Station Markers constructed inside our borders, moves there to set up a network of military stations around it\. Then, finds the closest colonized system without a military station, and builds one there\.
* Expansion Slot 2: Attempts to construct a military station in _every star system within our borders_\.



**Research Card**

* Expansion Slot 1: Scans all planetary objects inside our borders for Special Resources, or any high\-yielding (2\+) research deposits inside our borders \- and constructs a Research Station at the location, if needed\.
* Expansion Slot 2: Constructs a Research Station at any orbital deposit that can benefit us\.



**Mineral Card**

* Expansion Slot 1: Finds any high\-yielding Mineral deposit inside our borders, or any minable special resource, and creates a Mining Station there if needed\.
* Expansion Slot 2: Constructs a Mining Station at any orbital mineral deposit that can benefit us\.



**Energy Card**

* Expansion Slot 1: Finds any high\-yielding Energy deposit inside our borders, or any minable special resource, and creates a Mining Station there if needed\.
* Expansion Slot 2: Constructs a Mining Station at any orbital energy deposit that can benefit us\.



### Station Marker
The Station Marker is a new kind of military station gated behind a new rare technology that is **disabled by default**\. Constructing this marker allows your Autonomous Assemblers outfitted with a Military Expansion Card in slot 1 to build a hexagon\-shaped defense cluster of military stations, just like in the old days of Stellaris\. If you play with NSC, you should enable this option, because NSC has not adjusted the build block radius for vanilla military stations to match vanilla levels\.

Currently, once used, a marker will never be used again\. I plan on making it such that the Autonomous Assemblers attempt to maintain the 6 stations spawned around the marker (given the budget, of course)\.

When you design a station marker, you select a special component to equip it with that instructs any Autonomous Assembler on which kind of military station to construct around it\. This component also adjusts the price of the marker station to include the cost of any military station type that will be built\. The resources are then stored onboard the Station Marker until an Autonomous Assembler begins the construction process\.

If a Station Marker is destroyed before an Autonomous Assembler can complete construction of the 6 military stations around it, the resources are lost\.

### Ship Combat Statistics
The Autonomous Assembler more closely resembles a Corvette than a Construction Ship in terms of combat statistics\. It has exceptional evasion, combat speed, and sublight speed right off the bat, and can be further upgraded with new and improved central processing units\.

### Special Projects
In your empires special projects screen, you will find a new section dedicated to controlling your Autonomous Assemblers, where you can:

* Increase/decrease the reserved resources, which limits how low the assemblers can drain your empires mineral reserves (default: 100, increments of \+/\- 500)
* Halt/continue operations, which permanently halts or continues all autonomous operations (they can still be used as normal construction ships, manually, while halted)
* Set course for colony, which immediately (even if they're currently building something) halts all operations and makes all Autonomous Assemblers head for the nearest colonized planet, and once docked, will stay there for 3 months before re\-starting operations


All the projects are free, they just take time\. Also, they all reset every time you build or lose an assembler, and any time you complete a project\. Nothing I can do about this, unfortunately\.

### Known problems
There are no known problems\.

### Compatibility
Compatible with existing save games, but you need to research the technology to get access to the ships\. The menu only shows in new games\.

This mod is, as far as I know, compatible with all other addons\. Including Autobuild\. That's not a promise, but if the author of the other mod is not an idiot, they should not conflict\.

Anything labelled a "Total Conversion" is not in the category of a "mod" or "addon", in case that has to be explicitly mentioned\. Obviously some TCs could be compatible, or they already are \- I don't know, and I don't care\. Any other mod that wants to add explicit compatibility with Autonomous Assembler is free to do so\.

### Replaced files
This mod does not replace any vanilla files\.

### Changelog
Though Steam provides a way to list changes between uploads, there is no way I can automate this, so now you need to find the release notes on Github\.

### Communicating with me
You may file bug reports on Github\. All my Stellaris mods are listed there\.


[//]: # (stop)
