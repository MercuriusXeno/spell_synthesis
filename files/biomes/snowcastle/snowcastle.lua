---@diagnostic disable: lowercase-global, missing-global-doc
RegisterSpawnFunction(0xff0abae0, "ss_spawn_fuser")

function ss_spawn_fuser(x, y)
	EntityLoad("mods/spell_synthesis/files/entities/fuser/fuser_no_base.xml", x, y)
end

g_pixel_scene_02[#g_pixel_scene_02 + 1] = {
	prob = 0.3,
	material_file = "mods/spell_synthesis/files/biomes/snowcastle/fuser/fuser_horizontal.png",
	visual_file = "mods/spell_synthesis/files/biomes/snowcastle/fuser/fuser_horizontal_visual.png",
	background_file = "",
	is_unique = 0,
}

g_pixel_scene_01[#g_pixel_scene_01 + 1] = {
	prob = 0.4,
	material_file = "mods/spell_synthesis/files/biomes/snowcastle/fuser/fuser_vertical.png",
	visual_file = "mods/spell_synthesis/files/biomes/snowcastle/fuser/fuser_vertical_visual.png",
	background_file = "mods/spell_synthesis/files/biomes/snowcastle/fuser/fuser_vertical_bg.png",
	is_unique = 0,
}
