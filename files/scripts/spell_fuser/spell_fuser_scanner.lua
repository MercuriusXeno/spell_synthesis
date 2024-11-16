--- @class ss_fuser
local fuser = {}

--- Check if the spells match the recipe counts
--- @private
--- @param spell_count ss_action_count
--- @param recipe_counts ss_action_count
--- @return boolean
function fuser:is_recipe_completed(spell_count, recipe_counts)
	for spell, count in pairs(recipe_counts) do
		if (spell_count[spell] or 0) < count then return false end
	end
	return true
end

--- I need to make it more humane
--- @private
--- @param spells string[]
--- @param spell_entities entity_id[]
--- @param recipe_counts ss_action_count
--- @return entity_id[]
function fuser:return_recipe_entities(spells, spell_entities, recipe_counts)
	local matched_entities = {}
	local temp_counts = {}
	for j = 1, #spells do
		local spell = spells[j]
		if recipe_counts[spell] and (temp_counts[spell] or 0) < recipe_counts[spell] then
			matched_entities[#matched_entities + 1] = spell_entities[j]
			temp_counts[spell] = (temp_counts[spell] or 0) + 1
		end
	end
	return matched_entities
end

--- Function to check if a given spell set matches any recipe
--- @private
--- @param spells string[]
--- @param spell_entities entity_id[]  -- array of entity IDs associated with spells
--- @return ss_fusion_recipe|nil, entity_id[]  -- returns matched recipe and matching entity IDs
function fuser:find_recipe(spells, spell_entities)
	local spell_count = self.count_spells(spells)

	for i = 1, #self.recipes do
		local recipe = self.recipes[i]
		local recipe_counts = recipe.counts

		-- Collect only the required entity IDs for matched spells
		if self:is_recipe_completed(spell_count, recipe_counts) then
			return recipe, self:return_recipe_entities(spells, spell_entities, recipe_counts)
		end
	end

	-- No match found
	return nil, {}
end

--- Checks if spell has any recipe
--- @private
--- @param spell string
--- @return boolean
function fuser:has_recipe(spell)
	for i = 1, #self.recipes do
		local recipe = self.recipes[i]
		local recipe_counts = recipe.counts

		if recipe_counts[spell] and recipe_counts[spell] > 0 then return true end
	end
	return false
end

--- Scans entity properties and inserts to table if valid recipe was found
--- @private
--- @param action_ids string[]
--- @param entity_ids entity_id[]
--- @param action_card_entity any
function fuser:scan_card_entity(action_ids, entity_ids, action_card_entity)
	local item_action_component = EntityGetFirstComponent(action_card_entity, "ItemActionComponent")
	if not item_action_component then return end

	if self.cache.entity_has_recipe[action_card_entity] == true then
		action_ids[#action_ids + 1] = self.cache.entity_spell_id[action_card_entity]
		entity_ids[#entity_ids + 1] = action_card_entity
		return
	elseif self.cache.entity_has_recipe[action_card_entity] == nil then
		local action_id = ComponentGetValue2(item_action_component, "action_id")
		self.cache.entity_has_recipe[action_card_entity] = self:has_recipe(action_id)
		if not self.cache.entity_has_recipe[action_card_entity] then return end

		self.cache.entity_spell_id[action_card_entity] = action_id
		action_ids[#action_ids + 1] = action_id
		entity_ids[#entity_ids + 1] = action_card_entity
	end
end

--- Gather spells and their entity ids
--- @private
--- @param x number
--- @param y number
--- @return string[], entity_id[]
function fuser:get_spells(x, y)
	local action_cards = EntityGetInRadiusWithTag(x, y, self.radius, "card_action")
	local action_ids = {}
	local entity_ids = {}
	for i = 1, #action_cards do
		self:scan_card_entity(action_ids, entity_ids, action_cards[i])
	end
	return action_ids, entity_ids
end

return fuser
