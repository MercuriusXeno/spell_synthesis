--- @class ss_fusion_recipe
--- @field spells string[]
--- @field result string

--- @type ss_fusion_recipe[]
local recipes = {
	{
		spells = { "LIGHT_BULLET", "LIGHT_BULLET" },
		result = "SS_LIGHT_BULLET_2",
	},
	{
		spells = { "SS_LIGHT_BULLET_2", "SS_LIGHT_BULLET_2" },
		result = "SS_LIGHT_BULLET_3",
	},
}

return recipes
