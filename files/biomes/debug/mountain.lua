RegisterSpawnFunction(0xff24d2d2, "SS_fuser_spawn")

--- Spawn fuser
--- @param x number
--- @param y number
function SS_fuser_spawn(x, y)
	EntityLoad("mods/spell_synthesis/files/entities/fuser/fuser.xml", x, y)
end
