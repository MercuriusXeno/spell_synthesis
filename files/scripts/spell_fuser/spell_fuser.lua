--- @class ss_fuser_cache
local cache = {
	entity_has_recipe = setmetatable({}, { __mode = "k" }),
	entity_spell_id = setmetatable({}, { __mode = "k" }),
}

--- @class ss_fuser
--- @field private recipes ss_fusion_recipe_computed[]
--- @field private cache ss_fuser_cache
--- @field radius number radius from entity to scan
--- @field fusing boolean if we are fusing the spells
local fuser = {
	recipes = dofile_once("mods/spell_synthesis/files/spells/recipes.lua"),
	cache = cache,
	radius = 30,
	fusing = false,
}

local modules = {
	"mods/spell_synthesis/files/scripts/spell_fuser/spell_fuser_fuse.lua",
	"mods/spell_synthesis/files/scripts/spell_fuser/spell_fuser_scanner.lua",
	"mods/spell_synthesis/files/scripts/spell_fuser/spell_fuser_particles.lua",
}

for _, module_name in ipairs(modules) do
	local module = dofile_once(module_name)
	if not module then error("couldn't load " .. module_name) end
	for k, v in pairs(module) do
		fuser[k] = v
	end
end

--- Function to count occurrences of each spell in a list
--- @private
--- @param spells string[]
--- @return ss_action_count
function fuser.count_spells(spells)
	local counts = {}
	for i = 1, #spells do
		local spell = spells[i]
		counts[spell] = (counts[spell] or 0) + 1
	end
	return counts
end

-- Precompute spell counts for each recipe to optimize the find_recipe method
for i = 1, #fuser.recipes do
	local recipe = fuser.recipes[i]
	recipe.counts = fuser.count_spells(recipe.spells)
end

--- Scan nearby spells and returns new action id and consumed entities if recipe was found
--- @param x number
--- @param y number
--- @return ss_fusion_recipe|nil, entity_id[]  -- returns matched recipe and matching entity IDs
function fuser:scan_for_recipe(x, y)
	local spells, action_cards = self:get_spells(x, y + 30)
	for i = 1, #action_cards do
		self:apply_hint_particle(action_cards[i])
	end
	return self:find_recipe(spells, action_cards)
end

return fuser
