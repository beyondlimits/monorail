minetest.register_node("pushable_block:switch_on", {
	description = "Monorail switch (On)",
    paramtype2 = "facedir",
    tiles = {"pushable_block_switch_on_top.png","pushable_block_switch_on_top.png","pushable_block_switch_on.png"},
    drop = "pushable_block:switch_off",
    groups = {bendy=2, snappy=1, dig_immediate=2},
    on_punch = function(pos, node, puncher)
        node.name = "pushable_block:switch_off"
        minetest.env:set_node(pos, node)
    end,
    
    drawtype = "nodebox",
    paramtype = "light",
    node_box = {
        type = "fixed",
        fixed = {
                    -- shaft
                    {-0.05, -0.5, -0.05, 0.05, 0.0, 0.05},
                    -- head
                    {-0.25, 0.0, -0.05, 0.25, 0.5, 0.05},
                    {-0.05, 0.0, -0.25, 0.05, 0.5, 0.25},
                },
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
        }
    },
    walkable = false,
    
    mesecons = { conductor = {
				state = "on",
				onstate = "pushable_block:switch_off",
				} }
})

minetest.register_node("pushable_block:switch_off", {
	description = "Monorail switch (Off)",
    paramtype2 = "facedir",
    tiles = {"pushable_block_switch_off_top.png","pushable_block_switch_off_top.png","pushable_block_switch_off.png"},
    drop = "pushable_block:switch_off",
    groups = {bendy=2, snappy=1, dig_immediate=2},
    on_punch = function(pos, node, puncher)
        node.name = "pushable_block:switch_on"
        minetest.env:set_node(pos, node)
    end,
    
    drawtype = "nodebox",
    paramtype = "light",
    node_box = {
        type = "fixed",
        fixed = {
                    -- shaft
                    {-0.05, -0.5, -0.05, 0.05, 0.0, 0.05},
                    -- head
                    {-0.25, 0.0, -0.05, 0.25, 0.5, 0.05},
                    {-0.05, 0.0, -0.25, 0.05, 0.5, 0.25},
                },
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
        }
    },
    walkable = false,
    
    mesecons = { conductor = {
				state = "off",
				onstate = "pushable_block:switch_on",
				} }
})