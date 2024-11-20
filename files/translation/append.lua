local game_translation_file = "data/translations/common.csv"
local append_list = {
	"mods/spell_synthesis/files/translation/spells.csv",
}

local translation = ModTextFileGetContent(game_translation_file)
for i = 1, #append_list do
	translation = translation .. ModTextFileGetContent(append_list[i]) .. "\n"
end
translation = translation:gsub("\r", ""):gsub("\n\n+", "\n")

ModTextFileSetContent(game_translation_file, translation)
