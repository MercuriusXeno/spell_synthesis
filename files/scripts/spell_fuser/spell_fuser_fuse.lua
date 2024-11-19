--- @class ss_fuser_animation_steps
local fuse_steps_frames = {
	up = 180,
	side = 180,
}

-- Precompute steps
fuse_steps_frames.side = fuse_steps_frames.up + fuse_steps_frames.side
fuse_steps_frames.up_step = fuse_steps_frames.up * 8
fuse_steps_frames.side_step = fuse_steps_frames.side * 16

--- @class ss_fuser
--- @field private steps ss_fuser_animation_steps
--- @field private current_fusion? ss_current_fusion
local fuser = {
	steps = fuse_steps_frames,
}

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

--- Does animation for going towards fuser
--- @private
--- @param target_x number
function fuser:fuse_spells_animation_side(target_x)
	local step = self.current_fusion.step / self.steps.side_step
	for i = 1, #self.current_fusion.entities do
		local entity = self.current_fusion.entities[i]
		local x, y = EntityGetTransform(entity)

		-- Linear interpolation for smooth movement
		local new_x = x + step * (target_x - x)
		EntityApplyTransform(entity, new_x, y)
	end
end

--- Does animation for floating spells up
--- @private
--- @param target_y number
function fuser:fuse_spells_animation_up(target_y)
	local step = self.current_fusion.step / self.steps.up_step
	for i = 1, #self.current_fusion.entities do
		local entity = self.current_fusion.entities[i]
		local x, y = EntityGetTransform(entity)

		-- Linear interpolation for smooth movement
		local new_y = y + step * (target_y - y)
		EntityApplyTransform(entity, x, new_y)
	end
end

--- Fuse spells
--- @param target_x number
--- @param target_y number
function fuser:fuse_spells(target_x, target_y)
	if not self:is_spells_still_present() then return end

	self.current_fusion.step = self.current_fusion.step + 1
	if self.current_fusion.step < self.steps.up then
		self:fuse_spells_animation_up(target_y)
	elseif self.current_fusion.step < self.steps.side then
		self:fuse_spells_animation_side(target_x)
	else
		for i = 1, #self.current_fusion.entities do
			local entity = self.current_fusion.entities[i]
			EntityKill(entity)
		end
		CreateItemActionEntity(self.current_fusion.result, target_x, target_y)
		self.current_fusion = nil
		self.fusing = false
	end
end

--- Start fusing
--- @param result string
--- @param entities entity_id[]
function fuser:start_fusing(result, entities)
	self.current_fusion = {
		result = result,
		entities = entities,
		step = 0,
	}
	for i = 1, #entities do
		local entity = entities[i]
		local velocity_component = EntityGetFirstComponent(entity, "VelocityComponent")
		if velocity_component then EntitySetComponentIsEnabled(entity, velocity_component, false) end
	end
	self.fusing = true
end

return fuser
