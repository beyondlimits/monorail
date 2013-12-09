-------------------------------------------------------------------------------
-- name: transport_cart_onpunch_handler(self,hitter)
--
--! @brief move cart due to punch
--! @param self the cart itself
--! @param hitter person hitting cart
--
-------------------------------------------------------------------------------
function transport_cart_onpunch_handler(self,hitter)
	local own_pos = self.object:getpos()
	local hitterpos = hitter:getpos()
	
	local distance = pushable_block_calc_distance(own_pos,hitterpos)
	local playername = hitter:get_player_name()
	
	if (distance <= 1.5) then
		monorail_cart.punch_move(self,own_pos,hitterpos)
	end
	
	return true
end

-------------------------------------------------------------------------------
-- name: transport_cart_button_handler(player, formname, fields)
--
--! @brief handle form button click events
--! @param player player issuing click
--! @param formname name of form
--! @param fields fields set in form
--
--! return true/false if this form is handled by this handler or not
-------------------------------------------------------------------------------
function transport_cart_button_handler(player, formname, fields)
	if formname == "pushable_block_rightclick:main" then
		for k,v in pairs(fields) do
			local parts = string.split(k,"_")
			
			if parts[1] == "pbrightclick" then
				local tansport_cart_store_id = parts[2]
				local todo = parts[3]
				
				local cart = pushable_block_global_data_get(tansport_cart_store_id)
				
				if cart ~= nil then
					local playername = player:get_player_name()
					local distance = pushable_block_calc_distance(cart.object:getpos(),player:getpos())
					
					if distance > 4 then
						minetest.chat_send_player(playername, "Too far away from transport cart")
						return true
					end
					
					if todo == "take" and
						cart.inventory:is_empty("main") then
						--print("Info: "..detect_slider_type(self.object:getpos()).. " :",self.moving_up)
						player:get_inventory():add_item("main", "pushable_block:transport_cart")
						cart.object:remove()
					end
					
					if todo == "inventory" then						
						minetest.show_formspec(playername,"transport_cart_formspec",
							"size[8,9;]"..
							"label[0,0;Transport cart content:]" ..
							"list[detached:" .. cart.inventoryname .. ";main;2,1;4,3;]"..
							"list[current_player;main;0,5;8,4;]")
					end
				end
			end
		end
		return true
	end
	return false
end

minetest.register_on_player_receive_fields(transport_cart_button_handler)

minetest.register_entity(":pushable_block:transport_cart_ent", {
	physical = true,
	collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
	visual = "mesh",
	textures        = { "pushable_block_transport_cart_mesh.png" },
	mesh= "pushable_block_transport_cart.b3d",
	visual_size     = {x=1,y=1,z=1},
	groups = { immortal=1, },
	on_step  = monorail_cart.onstep_handler,
	on_punch = transport_cart_onpunch_handler,
	
	on_activate = function(self,staticdata)
		self.object:setacceleration({x=0,y=SLIDERS_GRAVITY,z=0})
		self.last_speed = self.object:getvelocity()
		self.object:set_armor_groups(self.groups)
		
		self.inventoryname = string.gsub(tostring(entity),"table: ","")
		
		self.inventory = minetest.create_detached_inventory(self.inventoryname, nil)
		
		self.inventory:set_size("main",12)
		
		local restored = minetest.deserialize(staticdata)
		
		if restored ~= nil then
			if restored.stacks ~= nil then
				for i=1,#restored.stacks,1 do
					self.inventory:set_stack("main",i,restored.stacks[i])
				end
			end
			
			if restored.lastpos ~= nil then
				self.last_known_good_pos = restored.lastpos
				self.object:moveto(self.last_known_good_pos)
				--print(tostring(self) .. " restoring position: " .. dump(restored.lastpos))
			end
			
			if restored.velocity ~= nil then
				self.last_speed = restored.velocity
				self.object:setvelocity(self.last_speed)
				--print(tostring(self) .. " restoring velocity: " .. dump(restored.velocity))
			end
		end
	end,
	
	on_rightclick = function(self,clicker)
	
		--get rightclick storage id
		local storage_id = pushable_block_global_data_store(self)
		local y_pos = 0.25
		local buttons = ""
		
		local playername = clicker:get_player_name()
		
		buttons = buttons .. "button_exit[0," .. y_pos .. ";2.5,0.5;" ..
					"pbrightclick_" .. storage_id .. "_inventory;Content]"
					
		y_pos = y_pos + 0.75
		
		buttons = buttons .. "button_exit[0," .. y_pos .. ";2.5,0.5;" ..
					"pbrightclick_" .. storage_id .. "_take;Take]"
					
		y_pos = y_pos + 0.75
		
		local y_size = y_pos
		
		local formspec = "size[2.5," .. y_size .. "]" ..
				buttons
		
		if playername ~= nil then
			--TODO start form close timer
			minetest.show_formspec(playername,"pushable_block_rightclick:main",formspec)
		end
		return true
	end,
	
	get_staticdata = function(self)
	
		if self.soundhandle_moving ~= nil then
			minetest.sound_stop(self.soundhandle_moving)
			self.soundhandle_moving = nil
		end
		
		local stacks = {}
		local list = self.inventory:get_list("main")
		
		for i=1,#list,1 do
			table.insert(stacks,list[i]:to_string())
		end
		
		local tostore = {}
		
		tostore.lastpos = self.last_known_good_pos
		tostore.velocity = self.object:getvelocity()
		tostore.stacks = stacks

		return minetest.serialize(tostore)
	end,
	
	set_animation = function(self,animation)
	
	end,
		
	moving_up = false,

	 })