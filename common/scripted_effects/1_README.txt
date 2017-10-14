
# Documentation for how to add support for 3rd party stuff to the Autonomous Assembler.

# 1. Generic info about overriding scripted_effects/triggers
# 2. Adding a new Expansion Card
# 3. Adding your Spaceport Module to the SM operation
# 4. Adding support for your spaceport extension mod (if you add more slots to the spaceport)

# SECTION 1: Overriding scripted_effects/triggers (objects)
# There are two really simple rules for this:
# 1. Your mod loads _before_ the mod that contains the object you want to overwrite
#    Your objects need to be in a file with the SAME name as the objects you want to overwrite.

# 2. Your mod loads _after_ the mod that contains the object you want to overwrite
#    Your objects need to be in a file with a DIFFERENT name than the objects you want to overwrite.

# In both cases, your objects need to have the same name as the ones you are overriding, obviously.


# SECTION 2: Adding a new Expansion Card
# - TODO -

# SECTION 3: Adding your Spaceport Module to the SM operation
# You can do it without talking to me, but then you will need to overwrite ass_3rd_party and handle it whenever I update the mod. Alternatively, talk to me and I will add the effects there for your mod.

# 1. For each of your modules, copy one of the ass_stage1_sm_* effects from ass_op_sm_vanilla.txt and change things accordingly.
# Remember you need to copy the ass_valid_spaceport_module_planet trigger out of this mod and into yours, preferrably with a DIFFERENT NAME _regardless_ of whether or not you load before or after, so that if I want to change that trigger for the mod, you don't fuck me over. Check SDA, where I do this.
# Set AssOperationCost, AssOperationCostEnergy, AssOperationCostInfluence, and AssConstructionTime accordingly to your module.
# The module-specific flag, like ass_op_sm_battleship_assembly_yards, can be named anything you want that doesn't conflict with other addons.
# You will be responsible for constructing the module AND removing this flag later, so you can name it "my_module_assembler_flag" or whatever you want.
# You also don't have to use random_owned_planet to find the "best" target planet, you can use any code you want to select the planet to build on, based on any conditions you want - the thing to remember is that you can't use any _less_ trigger conditions than the ones in ass_op_sm_vanilla effects.

# 2. Make sure your ass_stage1_sm_* effects are invoked from ass_stage1_sm_3rd_pre or ass_stage1_sm_3rd_post, somehow. Either overwrite the file or talk to me.

# 3. If your addon adds new spaceport slots _and_ modules, make sure you hook into ass_stage4_sm_3rd_build_pre. If your addon only adds modules, make sure you hook into ass_stage4_sm_3rd_build_post.
# In your ass_stage4_sm_3rd_build_* effect, you should have a switch that triggers on the ships slot flag, and place your module manually like this, per slot:
# ass_op_sm_slot_1 = {
# 	remove_ship_flag = "ass_op_sm_build"
# 	event_target:ass_target = { set_spaceport_module = { module = "my_module" slot = 1 } }
# }
# It's important that you remove the ass_op_sm_build flag _only_ if you actually handle the build.
# Your build effect can handle ass_op_sm_slot_1-19, if you want. It will produce an error for any slot that doesn't exist.


# SECTION 4: Adding support for your spaceport extension mod

# If you add more slots to the vanilla spaceport, and you want to add support for those slots, you need a few things:
# 1. You need to add a ass_stage1_sm_set_slot effect that looks like the one in this addon, only extended to as many slots as you add.
# 2. Tell me about it, or override the required files.
# 3. Implement a ass_stage4_complete_build_* effect for your mod, where you place the vanilla modules, at a minimum.

