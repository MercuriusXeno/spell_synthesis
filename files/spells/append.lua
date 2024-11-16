local spell_list = {
	"mods/spell_synthesis/files/spells/evolutions/spells.lua",
}

for i = 1, #spell_list do
	local spells_file = spell_list[i]
	dofile_once(spells_file) -- going once manually to populate icons
	ModLuaFileAppend("data/scripts/gun/gun_actions.lua", spells_file)
end
