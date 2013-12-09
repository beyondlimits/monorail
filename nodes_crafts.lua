--------------------------------------------------------------------------------
--
-- Crafts
--
--------------------------------------------------------------------------------
if minetest.is_yes(minetest.setting_get("monorail_carts_mimicry")) then
	minetest.register_craft({
		output = "pushable_block:cart",
		recipe = {
			{"", "", ""},
			{"default:steel_ingot", "", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		},
	})

		minetest.register_craft({
		output = "pushable_block:transport_cart",
		recipe = {
			{"", "", ""},
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		},
	})
else
	minetest.register_craft({
	    output = "pushable_block:cart",
	    recipe = {
	        {"default:steel_ingot",'',"default:steel_ingot"},
	        {"default:steel_ingot","default:mese_crystal","default:steel_ingot"},
	    }
	})

	minetest.register_craft({
	    output = "pushable_block:transport_cart",
	    recipe = {
	        {"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
	        {"default:steel_ingot","default:mese_crystal","default:steel_ingot"},
	    }
	})
end


minetest.register_craft({
    output = 'craft "pushable_block:switch_off" 1',
    recipe = {
        {"default:stick"},
        {"default:steel_ingot"},
    }
})

if not minetest.is_yes(minetest.setting_get("monorail_carts_mimicry")) then
	minetest.register_craft({
	    output = 'node "pushable_block:slider" 10',
	    recipe = {
	        {"default:sand"},
	        {"default:steel_ingot"},
	        {"default:sand"},
	    }
	})
end

if minetest.is_yes(minetest.setting_get("monorail_carts_mimicry")) then
	minetest.register_craft({
		output = "pushable_block:booster 2",
		recipe = {
			{"default:steel_ingot", "default:mese_crystal_fragment", "default:steel_ingot"},
			{"default:steel_ingot", "default:stick", "default:steel_ingot"},
			{"default:steel_ingot", "", "default:steel_ingot"},
		}
	})

	minetest.register_craft({
		output = "pushable_block:booster 2",
		recipe = {
			{"default:steel_ingot", "", "default:steel_ingot"},
			{"default:steel_ingot", "default:stick", "default:steel_ingot"},
			{"default:steel_ingot", "default:mese_crystal_fragment", "default:steel_ingot"},
		}
	})

	--register break reciep only if mesecons is not present
	if minetest.get_modpath("mesecons") == nil then
	minetest.register_craft({
		output = "pushable_block:break 2",
		recipe = {
			{"default:steel_ingot", "default:coal_lump", "default:steel_ingot"},
			{"default:steel_ingot", "default:stick", "default:steel_ingot"},
			{"default:steel_ingot", "", "default:steel_ingot"},
		}
	})

	minetest.register_craft({
		output = "pushable_block:break 2",
		recipe = {
			{"default:steel_ingot", "", "default:steel_ingot"},
			{"default:steel_ingot", "default:stick", "default:steel_ingot"},
			{"default:steel_ingot", "default:coal_lump", "default:steel_ingot"},
		}
	})

	end
else
	minetest.register_craft({
	    output = "pushable_block:booster 10",
	    recipe = {
	        {"default:sand"},
	        {"default:mese_crystal"},
	        {"default:sand"},
	    }
	})

	--register break reciep only if mesecons is not present
	if minetest.get_modpath("mesecons") == nil then
	minetest.register_craft({
	    output = "pushable_block:break 10",
	    recipe = {
	        {"default:sand"},
	        {"default:stone"},
	        {"default:sand"},
	    }
	})
	end
end



minetest.register_craft({
    output = 'node "pushable_block:accelerator_off" 5',
    recipe = {
        {"default:cobble", "default:mese_crystal","default:cobble"},
        {"default:mese_crystal", "default:glass", "default:mese_crystal"},
        {"default:cobble", "default:mese_crystal","default:cobble"},
        }
    })

minetest.register_craft({
        output = 'node "pushable_block:cart_detector_off" 5',
    recipe = {
        {"default:cobble", "default:glass","default:cobble"},
        {"default:glass", "default:mese_crystal", "default:glass"},
        {"default:cobble", "default:glass","default:cobble"},
    }
})
--------------------------------------------------------------------------------
--
-- Craftitems
--
--------------------------------------------------------------------------------

local cart_inventorycube = minetest.inventorycube("pushable_block_cart.png")
local name = "Monorail Cart"
if minetest.is_yes(minetest.setting_get("monorail_carts_mimicry")) then
	cart_inventorycube = minetest.inventorycube("pushable_block_pa_cart_top.png",
												"pushable_block_pa_cart_side.png",
												"pushable_block_pa_cart_side.png")
	name = "Cart"
end

minetest.register_craftitem("pushable_block:cart", {
	description = name,
	image = cart_inventorycube,

	on_place = function(item, placer, pointed_thing)
		if pointed_thing.type == "node" then
			local pos = pointed_thing.above
			local new_object = minetest.env:add_entity(pos,"pushable_block:cart_ent")

			if new_object ~= nil then
				local slidertype = detect_slider_type({x=pos.x,y=pos.y-1,z=pos.z}, nil)

				--print("slidertype: " .. dump(slidertype))

				if slidertype == "x" then
					new_object:setyaw(0)
				end

				if slidertype == "z" then
					new_object:setyaw(0 + math.pi/2)
				end
			end

			item:take_item()
		end
		return item
	end
})

local tcart_inventorycube = minetest.inventorycube("pushable_block_transport_cart.png")
name = "Monorail Transport Cart"
if minetest.is_yes(minetest.setting_get("monorail_carts_mimicry")) then
	tcart_inventorycube = minetest.inventorycube("pushable_block_pa_cart_top.png",
													"pushable_block_pa_cart_side.png",
													"pushable_block_pa_cart_side.png")
	name = "Transport Cart"
end

minetest.register_craftitem("pushable_block:transport_cart", {
	description = name,
	image = tcart_inventorycube,

	on_place = function(item, placer, pointed_thing)
		if pointed_thing.type == "node" then
			local pos = pointed_thing.above
			minetest.env:add_entity(pos,"pushable_block:transport_cart_ent")

			if new_object ~= nil then
				local slidertype = detect_slider_type({x=pos.x,y=pos.y-1,z=pos.z}, nil)

				--print("slidertype: " .. dump(slidertype))

				if slidertype == "x" then
					new_object:setyaw(0)
				end

				if slidertype == "z" then
					new_object:setyaw(0 + math.pi/2)
				end
			end

			item:take_item()
		end
		return item
	end
})

--------------------------------------------------------------------------------
--
-- Nodes
--
--------------------------------------------------------------------------------

local slidertiles = {"pushable_block_monorail.png",
					"pushable_block_monorail_curved.png",
					"pushable_block_monorail_t_junction.png",
					"pushable_block_monorail_crossing.png"}
local inventoryimage = "pushable_block_monorail.png"
local slidername = "Slider"

if minetest.is_yes(minetest.setting_get("monorail_carts_mimicry")) then
	slidertiles = {"default_rail.png", "default_rail_curved.png", "default_rail_t_junction.png", "default_rail_crossing.png"}
	inventoryimage = "default:rail.png"
	slidername = "Rail"
end

minetest.register_node(monorail_basic_slider, {
	description = slidername,
	drawtype = "raillike",
	tiles = slidertiles,
	inventory_image = inventoryimage,
	wield_image = inventoryimage,
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy=2,snappy=1,dig_immediate=2,attached_node=1,rail=1},
	})

slidername = "Slider (Vertical)"

if minetest.is_yes(minetest.setting_get("monorail_carts_mimicry")) then
	slidername = "Rail (Vertical)"
end

minetest.register_node("pushable_block:slider_vertical", {
	description = slidername,
	drawtype = "signlike",
	tiles = { inventoryimage },
	inventory_image = inventoryimage,
	wield_image = inventoryimage,
	paramtype = "light",
	paramtype2 = "wallmounted",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
		},
	groups = {bendy=2,snappy=1,dig_immediate=2,attached_node=1,rail=1},
	})


slidertiles = {"pushable_block_monorail_boost.png",
					"pushable_block_monorail_curved_boost.png",
					"pushable_block_monorail_t_junction_boost.png",
					"pushable_block_monorail_crossing_boost.png"}
inventoryimage = "pushable_block_monorail_boost.png"
slidername = "Booster"

if minetest.is_yes(minetest.setting_get("monorail_carts_mimicry")) then
	slidertiles = {"pushable_block_pa_carts_rail_pwr.png",
					"pushable_block_pa_carts_rail_curved_pwr.png",
					"pushable_block_pa_carts_rail_t_junction_pwr.png",
					"pushable_block_pa_carts_rail_crossing_pwr.png"}
	inventoryimage = "pushable_block_pa_carts_rail_pwr.png"
	slidername = "Powered Rail"

	minetest.register_alias("default:rail","pushable_block:slider")
end

minetest.register_node("pushable_block:booster", {
	description = slidername,
	drawtype = "raillike",
	tiles = slidertiles,
	inventory_image = inventoryimage,
	wield_image = inventoryimage,
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy=2,snappy=1,dig_immediate=2,attached_node=1,rail=1},

	mesecons = { conductor = {
				state = "on",
				offstate = "pushable_block:break",
				} }
})

slidertiles = {"pushable_block_monorail_break.png",
					"pushable_block_monorail_curved_break.png",
					"pushable_block_monorail_t_junction_break.png",
					"pushable_block_monorail_crossing_break.png"}
inventoryimage = "pushable_block_monorail_break.png"
slidername = "Brake"

if minetest.is_yes(minetest.setting_get("monorail_carts_mimicry")) then
	slidertiles = {"pushable_block_pa_carts_rail_brk.png",
					"pushable_block_pa_carts_rail_curved_brk.png",
					"pushable_block_pa_carts_rail_t_junction_brk.png",
					"pushable_block_pa_carts_rail_crossing_brk.png"}
	inventoryimage = "pushable_block_pa_carts_rail_pwr.png"
	slidername = "Brake Rail"

	minetest.register_alias("default:rail","pushable_block:slider")
end

minetest.register_node("pushable_block:break", {
	description = slidername,
	drawtype = "raillike",
	tiles = slidertiles,
	inventory_image = inventoryimage,
	wield_image = inventoryimage,
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy=2,snappy=1,dig_immediate=2,attached_node=1,rail=1},
	mesecons = { conductor = {
				state = "off",
				onstate = "pushable_block:booster",
				} }
})

minetest.register_node("pushable_block:accelerator_off", {
	description = "Mese Monorail Accelerator off",
	tiles ={"pushable_block_accelerator_off.png"},
	is_ground_content = true,
	groups = {cracky=3, mesecon=2},
	drop = 'pushable_block:accelerator_off 1',

	mesecons = { conductor = {
				state = "off",
				onstate = "pushable_block:accelerator_on",
				} }
})

minetest.register_node("pushable_block:accelerator_on", {
	description = "Mese Monorail Accelerator on",
	tiles ={"pushable_block_accelerator_on.png"},
	is_ground_content = true,
	groups = {cracky=3, mesecon=2},
	drop = 'pushable_block:accelerator_off 1',

	mesecons = { conductor = {
				state = "on",
				offstate = "pushable_block:accelerator_off",
				} }

})

minetest.register_node("pushable_block:cart_detector_on", {
	description = "Mese Monorail Cart Detector (On)",
	tiles ={"pushable_block_cart_detector.png"},
	is_ground_content = true,
	groups = {cracky=3, mesecon=2},
	drop = 'pushable_block:cart_detector 1',
	mesecons = { receptor = {
					state = "on"
					} }

})

minetest.register_abm({
	nodenames = { "pushable_block:cart_detector_on" },
	interval = 2,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.env:add_node(pos,{name="pushable_block:cart_detector_off"})
		mesecon:receptor_off(pos, mesecon.rules.default)
		pb_debug_lvl2("disabling mesecon detector at: " .. printpos(pos))
	end
	})

minetest.register_node("pushable_block:cart_detector_off", {
	description = "Mese Monorail Cart Detector (Off)",
	tiles ={"pushable_block_cart_detector.png"},
	is_ground_content = true,
	groups = {cracky=3, mesecon=2},
	drop = 'pushable_block:cart_detector 1',
	mesecons = { receptor = {
					state = "off"
					} }
})
