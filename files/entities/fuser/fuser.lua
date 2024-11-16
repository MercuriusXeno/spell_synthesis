local fuser = dofile_once("mods/spell_synthesis/files/scripts/spell_fuser/spell_fuser.lua") --- @type ss_fuser

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

if fuser.fusing then
	fuser:fuse_spells(x, y)
elseif GameGetFrameNum() % 10 == 0 then
	local recipe, matched_entities = fuser:scan_for_recipe(x, y)
	if recipe then fuser:start_fusing(recipe.result, matched_entities) end
end
