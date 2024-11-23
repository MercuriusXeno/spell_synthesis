---@diagnostic disable: lowercase-global, missing-global-doc
RegisterSpawnFunction(0xff2e8088, "ss_spawn_saw_puzzle")

function ss_spawn_saw_puzzle(x, y)
	EntityLoad("mods/spell_synthesis/files/entities/saw_puzzle/saw_puzzle_spawner.xml", x, y)
end

g_pixel_scene_02[#g_pixel_scene_02 + 1] = {
	prob = 0.2,
	material_file = "mods/spell_synthesis/files/biomes/snowcave/saw_puzzle/saw_puzzle.png",
	visual_file = "mods/spell_synthesis/files/biomes/snowcave/saw_puzzle/saw_puzzle_visual.png",
	background_file = "",
	is_unique = 0,
}
