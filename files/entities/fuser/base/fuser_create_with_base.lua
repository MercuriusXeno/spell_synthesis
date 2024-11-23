local entity = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity)

local search_dist_y = 400

if not DoesWorldExistAt(pos_x, pos_y - search_dist_y, pos_x, pos_y) then return end

local ray_hit, ray_x, ray_y = RaytracePlatforms(pos_x, pos_y, pos_x, pos_y + search_dist_y)
if ray_hit then
	local scene_x, scene_y = ray_x - 35, ray_y - 53
	local entity_y = scene_y + 19
	EntitySetTransform(entity, ray_x, entity_y)
	if ModSettingGet("spell_synthesis.fuser_workshop") then
		local workshop_entity = EntityLoad("mods/spell_synthesis/files/entities/fuser/base/fuser_workshop.xml", ray_x, entity_y)
		EntityAddChild(entity, workshop_entity)
	end
	LoadPixelScene(
		"mods/spell_synthesis/files/entities/fuser/pixelscene/fuser.png",
		"mods/spell_synthesis/files/entities/fuser/pixelscene/fuser_visual.png",
		scene_x,
		scene_y
	)
	EntityRemoveComponent(entity, GetUpdatedComponentID())
else
	EntityKill(entity)
end
