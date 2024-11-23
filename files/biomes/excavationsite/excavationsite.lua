---@diagnostic disable: lowercase-global, missing-global-doc
RegisterSpawnFunction(0xff0abae0, "ss_spawn_fuser")

function ss_spawn_fuser(x, y)
	EntityLoad("mods/spell_synthesis/files/entities/fuser/fuser_no_base.xml", x, y)
end

g_pixel_scene_04[#g_pixel_scene_04 + 1] = {
	prob = 0.3,
	material_file = "mods/spell_synthesis/files/biomes/excavationsite/fuser.png",
	visual_file = "mods/spell_synthesis/files/biomes/excavationsite/fuser_visual.png",
	background_file = "mods/spell_synthesis/files/biomes/excavationsite/fuser_background.png",
	is_unique = 0,
}
