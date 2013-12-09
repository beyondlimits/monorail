local nodebox_cart = {
                {-0.5,-0.5,-0.5, 0.5,-0.4,0.5},
                
                {-0.5,-0.5,-0.5, -0.4,0.5,0.5},
                { 0.4,-0.5,-0.5,  0.5,0.5,0.5},
                
                {-0.5,-0.5,-0.5,  0.5,0.5,-0.4},
                {-0.5,-0.5, 0.4,  0.5,0.5, 0.5},
            }
            
minetest.register_node("pushable_block:box_cart", {
    tiles = { "pushable_block_cart.png" },
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = nodebox_cart
        },
        })
        
        
local nodebox_transport_cart = {
                {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
            }
            
minetest.register_node("pushable_block:box_transport_cart", {
    tiles = { "pushable_block_transport_cart.png" },
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = nodebox_transport_cart
        },
    on_punch = function(pos, node, puncher)
        --TODO save inventory
        minetest.env:remove_node(pos)
        local object = minetest.env:add_entity(pos,"pushable_block:transport_cart_ent")
        local entity = object:get_luaentity()
        --TODO store inventory to entity
        transport_cart_onpunch_handler(entity,puncher)
    end,
        })