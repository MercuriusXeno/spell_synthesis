local fusions = {
	{
		spells = { "SS_FRIENDLY_PROJECTILE", "SS_FRIENDLY_EXPLOSION" },
		result = { "SS_FRIENDLY_SAFE" },
	},
	{
		spells = { "CHAIN_BOLT", "LIGHTNING" },
		result = { "SS_CHAIN_LIGHTNING_BOLT" },
	},
	{
		spells = { "SS_CHAIN_LIGHTNING_BOLT", "SS_CHAIN_LIGHTNING_BOLT" },
		result = { "SS_CHAIN_LIGHTNING_BOLT_FAST" },
	},
}

local current_count = #SSRecipes
for i = 1, #fusions do
	SSRecipes[current_count + i] = fusions[i]
end
