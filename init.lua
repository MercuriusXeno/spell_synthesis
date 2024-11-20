dofile_once("mods/spell_synthesis/files/biomes/append.lua")
dofile_once("mods/spell_synthesis/files/spells/append.lua")

ModRegisterAudioEventMappings("mods/spell_synthesis/files/audio/GUIDs.txt")
ModRegisterMusicBank("mods/spell_synthesis/files/audio/bank/spell_synthesis.bank")

--- Blahblah
function OnPlayerSpawned()
	if GameHasFlagRun("spell_synthesis_init") then return end
	GameAddFlagRun("spell_synthesis_init")
	EntityLoad("mods/spell_synthesis/files/entities/fuser/fuser_world.xml", 180, -100)
end
