--- @class ss_chain_projectile_helper
local chain_helper = {}

--- Returns shooter of projectile or projectile entity
--- @param projectile_entity entity_id
--- @return entity_id
function chain_helper:get_shooter_id(projectile_entity)
	local projectile_component = EntityGetFirstComponent(projectile_entity, "ProjectileComponent")
	if not projectile_component then return projectile_entity end
	return ComponentGetValue2(projectile_component, "mWhoShot")
end

--- Reads previous targets from VSC
--- @param variable_components component_id[]
--- @return entity_id, entity_id
function chain_helper:get_previous_entities(variable_components)
	local prev_entity_id = 0
	local prev_prev_entity_id = 0
	for i = 1, #variable_components do
		local variable_component = variable_components[i]
		local name = ComponentGetValue2(variable_component, "name")
		if name == "prev_entity_id" then
			prev_entity_id = ComponentGetValue2(variable_component, name) or 0
		elseif name == "prev_prev_entity_id" then
			prev_prev_entity_id = ComponentGetValue2(variable_component, "value_int") or 0
		end
	end

	return prev_entity_id, prev_prev_entity_id
end

--- Sets previous targets to VSC
--- @param variable_components component_id[]
--- @param prev entity_id
--- @param prev_prev entity_id
function chain_helper:set_previous_entities(variable_components, prev, prev_prev)
	for i = 1, #variable_components do
		local variable_component = variable_components[i]
		local name = ComponentGetValue2(variable_component, "name")
		if name == "prev_entity_id" then
			ComponentSetValue2(variable_component, "value_int", prev)
		elseif name == "prev_prev_entity_id" then
			ComponentSetValue2(variable_component, "value_int", prev_prev)
		end
	end
end

--- Checks if target is not in ignore list
--- @private
--- @param target_id entity_id
--- @param ignore_entities entity_id[]
--- @return boolean
function chain_helper:is_valid_target(target_id, ignore_entities)
	for i = 1, #ignore_entities do
		if target_id == ignore_entities[i] then return false end
	end
	return true
end

--- Get next chain target
--- @param x number
--- @param y number
--- @param radius number
--- @param ignore_entities entity_id[]
--- @return entity_id|nil
function chain_helper:get_target(x, y, radius, ignore_entities)
	local targets = EntityGetInRadiusWithTag(x, y, radius, "homing_target")
	for i = 1, #targets do
		local target = targets[i]
		if self:is_valid_target(target, ignore_entities) then return target end
	end
	return nil
end

return chain_helper
