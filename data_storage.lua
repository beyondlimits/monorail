-------------------------------------------------------------------------------
-- Pushable block Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file data_storage.lua
--! @brief generic functions used in many different places
--! @copyright Sapier
--! @author Sapier
--! @date 2013-02-04
--!
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- name: pushable_block_get_current_time()
--
--! @brief alias to get current time
--
--! @return current time in seconds
-------------------------------------------------------------------------------
function pushable_block_get_current_time()
	return os.time(os.date('*t'))
	--return minetest.get_time()
end
-------------------------------------------------------------------------------
-- name: pushable_block_global_data_store(value)
--
--! @brief save data and return unique identifier
--
--! @param value to save
--
--! @return unique identifier
-------------------------------------------------------------------------------
pushable_block_global_data_identifier = 0
pushable_block_global_data = {}
pushable_block_global_data.cleanup_index = 0
pushable_block_global_data.last_cleanup = pushable_block_get_current_time()
function pushable_block_global_data_store(value)

	local current_id = pushable_block_global_data_identifier
	
	pushable_block_global_data_identifier = pushable_block_global_data_identifier + 1
	
	pushable_block_global_data[current_id] = {
									value = value,
									added = pushable_block_get_current_time(),
									}
	return current_id
end


-------------------------------------------------------------------------------
-- name: pushable_block_global_data_store(value)
--
--! @brief pop data from global store
--
--! @param id to pop
--
--! @return stored value
-------------------------------------------------------------------------------
function pushable_block_global_data_get(id)

	local dataid = tonumber(id)

	if dataid == nil or 
		pushable_block_global_data[dataid] == nil then
		return nil
	end

	local retval = pushable_block_global_data[dataid].value
	pushable_block_global_data[dataid] = nil
	return retval
end

-------------------------------------------------------------------------------
-- name: pushable_block_global_data_store(value)
--
--! @brief pop data from global store
--
--! @param id to pop
--
--! @return stored value
-------------------------------------------------------------------------------
function pushable_block_global_data_cleanup(id)

	if pushable_block_global_data.last_cleanup + 500 < 
											pushable_block_get_current_time() then

		for i=1,50,1 do
			if pushable_block_global_data[pushable_block_global_data.cleanup_index] ~= nil then
				if pushable_block_global_data[pushable_block_global_data.cleanup_index].added < 
						pushable_block_get_current_time() - 300 then
						
					pushable_block_global_data[pushable_block_global_data.cleanup_index] = nil
				end
				pushable_block_global_data.cleanup_index = pushable_block_global_data.cleanup_index +1
				
				if pushable_block_global_data.cleanup_index > #pushable_block_global_data then
					pushable_block_global_data.cleanup_index = 0
					break
				end
			end
		end
		
		pushable_block_global_data.last_cleanup = pushable_block_get_current_time()
	end
end
