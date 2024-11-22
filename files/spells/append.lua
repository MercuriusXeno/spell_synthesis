local spell_list = {
	"mods/spell_synthesis/files/spells/evolutions/spells_evolutions.lua",
	"mods/spell_synthesis/files/spells/originals/spells_original.lua",
}

for i = 1, #spell_list do
	local spells_file = spell_list[i]
	dofile_once(spells_file) -- going once manually to populate icons
	ModLuaFileAppend("data/scripts/gun/gun_actions.lua", spells_file)
end

local compat_list = {
	copis_things = "mods/spell_synthesis/files/spells/compatibility/copis_things/spells.lua",
}

for mod, append_file in pairs(compat_list) do
	if ModIsEnabled(mod) then ModLuaFileAppend("data/scripts/gun/gun_actions.lua", append_file) end
end
