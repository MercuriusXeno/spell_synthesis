---@diagnostic disable: lowercase-global, missing-global-doc

local old_init = init
function init(x, y, w, h, ...)
	old_init(x, y, w, h, ...)

	local scene_x = x + 20
	local scene_y = y + 413
	local entity_x = scene_x + 65
	local entity_y = scene_y + 22

	LoadPixelScene(
		"mods/spell_synthesis/files/biomes/mountain/anvil_scene_spawn.png",
		"mods/spell_synthesis/files/biomes/mountain/anvil_scene_spawn_visual.png",
		scene_x,
		scene_y,
		"",
		true
	)

	local entity = EntityLoad("mods/spell_synthesis/files/entities/fuser/base/fuser.xml", entity_x, entity_y)
	if ModSettingGet("spell_synthesis.fuser_workshop") then
		local workshop_entity = EntityLoad("mods/spell_synthesis/files/entities/fuser/base/fuser_workshop.xml", entity_x, entity_y)
		EntityAddChild(entity, workshop_entity)
	end
end
