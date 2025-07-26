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
	{
		spells = { "MANA_REDUCE", "RECHARGE" },
		result = { "SS_ENERGIZE" },
	},
	{
		spells = { "SS_MANA_REDUCE_2", "SS_RECHARGE_2" },
		result = { "SS_ENERGIZE_2" },
	},
	{
		spells = { "SS_MANA_REDUCE_3", "SS_RECHARGE_3" },
		result = { "SS_ENERGIZE_3" },
	},
	{
		spells = { "SS_LIFETIME_3", "NOLLA" },
		result = { "SS_WISP" },
	},
	{
		spells = { "EXPLOSION_LIGHT", "BLACK_HOLE" },
		result = { "SS_DEMATERIALIZING_BURST" },
	},
	{
		spells = { "HOMING", "HOMING_SHOOTER" },
		result = { "SS_HEELING_HOMING" },
	},
}

local current_count = #SSRecipes
for i = 1, #fusions do
	SSRecipes[current_count + i] = fusions[i]
end
