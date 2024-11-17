---@diagnostic disable: lowercase-global
local fuser = dofile_once("mods/spell_synthesis/files/scripts/spell_fuser/spell_fuser.lua") --- @type ss_fuser

local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

if fuser.fusing then
	fuser:fuse_spells(x + 0.5, y + 9)
	-- If fusing was finished
	if not fuser.fusing then
		local children = EntityGetAllChildren(entity)
		if not children then
			local component = GetUpdatedComponentID()
			EntitySetComponentIsEnabled(entity, component, false)
		else
			EntityKill(children[1])
		end
	end
elseif GameGetFrameNum() % 10 == 0 then
	local recipe, matched_entities = fuser:scan_for_recipe(x, y)
	if recipe then fuser:start_fusing(recipe.result, matched_entities) end
end

--- Gets called on init (lol)
--- @param entity_id entity_id
function init(entity_id) ---@diagnostic disable-line: lowercase-global
	local vsc = EntityGetComponent(entity_id, "VariableStorageComponent")
	if not vsc then return end
	for i = 1, #vsc do
		local component = vsc[i]
		local key = ComponentGetValue2(component, "name")
		if key == "offset_y" then fuser.offset_y = ComponentGetValue2(component, "value_float") end
	end
end

--- Gets called when this component state is changed
--- @param entity_id entity_id
--- @param is_enabled boolean
function enabled_changed(entity_id, is_enabled)
	fuser:fuse_cancel()
end

function death(_, _, _, _)
	print("death!!1")
	fuser:fuse_cancel()
end
