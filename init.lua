local version = "0.0.17"

SLIDERS_GRAVITY    = -9.81
MIN_SPEED_JITTER   = 0.05
MAXIMUM_CART_SPEED = 7.5
MESE_ACCEL_VALUE = 7.5

local pushable_block_modpath = minetest.get_modpath("pushable_block")

dofile (pushable_block_modpath .. "/generic_functions.lua")
dofile (pushable_block_modpath .. "/data_storage.lua")
dofile (pushable_block_modpath .. "/nodes_crafts.lua")
dofile (pushable_block_modpath .. "/physics.lua")
dofile (pushable_block_modpath .. "/slider.lua")
dofile (pushable_block_modpath .. "/player_interaction.lua")
dofile (pushable_block_modpath .. "/generic_functions.lua")
dofile (pushable_block_modpath .. "/workarounds.lua")
dofile (pushable_block_modpath .. "/model.lua")
dofile (pushable_block_modpath .. "/cart_generic.lua")
dofile (pushable_block_modpath .. "/transport_cart.lua")
dofile (pushable_block_modpath .. "/cart.lua")
dofile (pushable_block_modpath .. "/switch.lua")

print("pushable block " .. version .. " mod loaded")