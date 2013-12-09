-------------------------------------------------------------------------------
-- name: round_pos(pos)
--
-- action: calculate integer position
--
-- param1: position to be rounded
-- retval: rounded position
-------------------------------------------------------------------------------
function round_pos(pos)

	return { 	x=math.floor(pos.x + 0.5),
			y=math.floor(pos.y + 0.5),
			z=math.floor(pos.z + 0.5)
		 }

end

-------------------------------------------------------------------------------
-- name: printpos(pos)
--
--! @brief convert pos to string of type "(X,Y,Z)"
--! @param position to convert
--
--! @return string with coordinates of pos
-------------------------------------------------------------------------------
function printpos(pos)
    if pos ~= nil then
	   return "("..pos.x..","..pos.y..","..pos.z..")"
	end
	
	return ""
end

-------------------------------------------------------------------------------
-- name: printpos(pos)
--
--! @brief convert pos to string of type "(X,Y,Z)"
--! @param position to convert
--
--! @return string with coordinates of pos
-------------------------------------------------------------------------------
function pushable_block_calc_distance(pos1,pos2)
	return math.sqrt(   math.pow(pos1.x-pos2.x,2) + 
					math.pow(pos1.y-pos2.y,2) +
					math.pow(pos1.z-pos2.z,2))
end

-------------------------------------------------------------------------------
-- name: pushable_block_samepos(pos1,pos2)
--
--! @brief check if two positions are equal
--! @param pos1 first position to check
--! @param pos2 second position to check
--
--! @return true/false
-------------------------------------------------------------------------------
function pushable_block_samepos(pos1,pos2)
	if pos1 == nil then return false end
	if pos2 == nil then return false end
	if pos1.x ~= pos2.x then return false end
	if pos1.y ~= pos2.y then return false end
	if pos1.z ~= pos2.z then return false end
	return true
end

-------------------------------------------------------------------------------
-- name: pushable_block_pos_is_null(pos1)
--
--! @brief check if pos is 0
--! @param position to check
--
--! @return true/false
-------------------------------------------------------------------------------
function pushable_block_pos_is_null(pos1)
	if pos1 == nil then return false end
	if pos1.x ~= 0 then return false end
	if pos1.y ~= 0 then return false end
	if pos1.z ~= 0 then return false end
	return true
end

pb_debug_lvl1 = function() end
pb_debug_lvl2 = function() end
pb_debug_lvl3 = function() end