local entity = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity)

local search_dist_y = 400
local fuser_base_req = 15

if not DoesWorldExistAt(pos_x, pos_y - search_dist_y, pos_x, pos_y) then return end

local x_left = pos_x - fuser_base_req
local x_right = pos_x + fuser_base_req

local ray_hit_left, _, ray_y_left = RaytracePlatforms(x_left, pos_y, x_left, pos_y + search_dist_y)
local ray_hit_right, _, ray_y_right = RaytracePlatforms(x_right, pos_y, x_right, pos_y + search_dist_y)
if ray_hit_left and ray_hit_right and ray_y_left == ray_y_right then
	local ray_y = ray_y_left
	local scene_x, scene_y = pos_x - 15, ray_y - 35
	local entity_y = scene_y + 12
	EntitySetTransform(entity, pos_x, entity_y)
	if ModSettingGet("spell_synthesis.fuser_workshop") then
		local workshop_entity = EntityLoad("mods/spell_synthesis/files/entities/fuser/base/fuser_workshop.xml", pos_x, entity_y)
		EntityAddChild(entity, workshop_entity)
	end
	LoadPixelScene(
		"mods/spell_synthesis/files/biomes/robobase/fuser/fuser.png",
		"mods/spell_synthesis/files/biomes/robobase/fuser/fuser_visual.png",
		scene_x,
		scene_y
	)
	EntityRemoveComponent(entity, GetUpdatedComponentID())
else
	EntityKill(entity)
end
