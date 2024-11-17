dofile_once("mods/spell_synthesis/files/biomes/append.lua")
dofile_once("mods/spell_synthesis/files/spells/append.lua")

--- Blahblah
function OnPlayerSpawned()
	if GameHasFlagRun("spell_synthesis_init") then return end
	GameAddFlagRun("spell_synthesis_init")
	EntityLoad("mods/spell_synthesis/files/entities/fuser/fuser.xml", 180, -100)
end
