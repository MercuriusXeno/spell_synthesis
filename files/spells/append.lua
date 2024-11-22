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
	"copis_things",
}

for i=1, #compat_list do
	local mod = compat_list[i]
	if ModIsEnabled(mod) then ModLuaFileAppend("data/scripts/gun/gun_actions.lua", table.concat{"mods/spell_synthesis/files/spells/compatibility/", mod, "/spells.lua"}) end
end