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
local fuser = {
	steps = fuse_steps_frames,
}

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

--- Does fusing animation
--- @private
--- @param target_x number
--- @param target_y number
function fuser:fuse_spells_animate(target_x, target_y)
	if self.current_fusion.step < self.steps.up then
		self:fuse_spells_animation_up(target_y)
	elseif self.current_fusion.step < self.steps.side then
		self:fuse_spells_animation_side(target_x)
	else
		self.current_fusion.animating = false
	end
end

return fuser
