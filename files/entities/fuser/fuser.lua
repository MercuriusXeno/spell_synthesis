local fuser = dofile_once("mods/spell_synthesis/files/scripts/spell_fuser/spell_fuser.lua") --- @type ss_fuser

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

if GetValueBool("fusing", false) then
	fuser:fuse_spells(x, y + 9)
	-- If fusing was finished
	if not fuser.fusing then
		SetValueBool("fusing", false)
		local children = EntityGetAllChildren(entity)
		if not children then
			EntityRemoveComponent(entity, GetUpdatedComponentID())
		else
			EntityKill(children[1])
		end
	end
elseif GameGetFrameNum() % 10 == 0 then
	local recipe, matched_entities = fuser:scan_for_recipe(x, y)
	if recipe then
		fuser:start_fusing(recipe.result, matched_entities)
		SetValueBool("fusing", true)
	end
end
