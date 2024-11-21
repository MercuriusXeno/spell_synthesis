--- @class ss_fuser
--- @field private current_fusion? ss_current_fusion
local fuser = {}

--- Cancels fusion
function fuser:fuse_cancel()
	self.fusing = false
	if not self.current_fusion then return end
	for i = 1, #self.current_fusion.entities do
		local entity = self.current_fusion.entities[i]
		local item_action_component = EntityGetFirstComponent(entity, "ItemActionComponent")
		if item_action_component then
			local velocity_component = EntityGetFirstComponentIncludingDisabled(entity, "VelocityComponent")
			if velocity_component then EntitySetComponentIsEnabled(entity, velocity_component, true) end
		end
	end
	self.current_fusion = nil
end

--- Checks if spells are still in world
--- @private
--- @return boolean
function fuser:is_spells_still_present()
	if not self.current_fusion then
		self.fusing = false
		return false
	end

	for i = 1, #self.current_fusion.entities do
		local entity = self.current_fusion.entities[i]
		local item_action_component = EntityGetFirstComponent(entity, "ItemActionComponent")
		if not item_action_component then
			self:fuse_cancel()
			return false
		end
		self:apply_fusion_particle(entity)
	end

	return true
end

--- Consumes spells and creates a result
--- @private
--- @param target_x number
--- @param target_y number
function fuser:finish_fusing(target_x, target_y)
	for i = 1, #self.current_fusion.entities do
		local entity = self.current_fusion.entities[i]
		EntityKill(entity)
	end
	CreateItemActionEntity(self.current_fusion.result, target_x, target_y)
	self.current_fusion = nil
	self.fusing = false
end

--- Fuse spells
--- @param target_x number
--- @param target_y number
function fuser:fuse_spells(target_x, target_y)
	if not self:is_spells_still_present() then return end

	self.current_fusion.step = self.current_fusion.step + 1
	if self.current_fusion.animating then
		self:fuse_spells_animate(target_x, target_y)
	else
		self:finish_fusing(target_x, target_y)
	end
end

--- Returns current step of fusion
--- @return number
function fuser:get_current_step()
	return self.current_fusion.step
end

--- Start fusing
--- @param result string
--- @param entities entity_id[]
function fuser:start_fusing(result, entities)
	self.current_fusion = {
		result = result,
		entities = entities,
		step = 0,
		animating = true,
	}
	for i = 1, #entities do
		local entity = entities[i]
		local velocity_component = EntityGetFirstComponent(entity, "VelocityComponent")
		if velocity_component then EntitySetComponentIsEnabled(entity, velocity_component, false) end
	end
	self.fusing = true
end

return fuser
