dofile_once("mods/spell_synthesis/files/biomes/append.lua")
dofile_once("mods/spell_synthesis/files/spells/append.lua")

--- Blahblah
function OnPlayerSpawned()
	LoadPixelScene(
		"mods/spell_synthesis/files/biomes/debug/debug_scene.png",
		"mods/spell_synthesis/files/biomes/debug/debug_scene_visual.png",
		200,
		-110,
		"mods/spell_synthesis/files/biomes/debug/debug_scene_bg.png",
		false,
		false,
		{},
		0,
		false
	)
end
