---@diagnostic disable: lowercase-global, missing-global-doc
RegisterSpawnFunction(0xff0abae0, "ss_spawn_fuser")
RegisterSpawnFunction(0xff2e8088, "ss_spawn_saw_puzzle")

function ss_spawn_fuser(x, y)
	EntityLoad("mods/spell_synthesis/files/entities/fuser/fuser_no_base.xml", x, y)
end

function ss_spawn_saw_puzzle(x, y)
	EntityLoad("mods/spell_synthesis/files/entities/saw_puzzle/saw_puzzle_spawner.xml", x, y)
end

local horizontal_scenes = {
	{
		prob = 0.2,
		material_file = "mods/spell_synthesis/files/biomes/snowcave/saw_puzzle/saw_puzzle.png",
		visual_file = "mods/spell_synthesis/files/biomes/snowcave/saw_puzzle/saw_puzzle_visual.png",
		background_file = "",
		is_unique = 0,
	},
	{
		prob = 0.3,
		material_file = "mods/spell_synthesis/files/biomes/snowcave/fuser/fuser.png",
		visual_file = "mods/spell_synthesis/files/biomes/snowcave/fuser/fuser_visual.png",
		background_file = "mods/spell_synthesis/files/biomes/snowcave/fuser/fuser_bg.png",
		is_unique = 0,
	},
}

local horizontal_count = #g_pixel_scene_02
for i = 1, #horizontal_scenes do
	g_pixel_scene_02[horizontal_count + i] = horizontal_scenes[i]
end
