local entity = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity)

local search_dist_y = 400

if not DoesWorldExistAt(pos_x, pos_y - search_dist_y, pos_x, pos_y) then return end

local ray_hit, ray_x, ray_y = RaytracePlatforms(pos_x, pos_y, pos_x, pos_y + search_dist_y)
if ray_hit then
	EntitySetTransform(entity, ray_x, ray_y - 23)
	LoadPixelScene(
		"mods/spell_synthesis/files/entities/fuser/pixelscene/fuser.png",
		"mods/spell_synthesis/files/entities/fuser/pixelscene/fuser_visual.png",
		ray_x - 35,
		ray_y - 42
	)
	EntityRemoveComponent(entity, GetUpdatedComponentID())
else
	EntityKill(entity)
end
