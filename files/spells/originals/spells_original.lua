---@type action[]
-- stylua: ignore
local spells = {
	{ -- Friendly Projectile
		id                     = "SS_FRIENDLY_PROJECTILE",
		name                   = "$ss_action_friendly_projectile",
		description            = "$ss_actiondesc_friendly_projectile",
		sprite                 = "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_fire.png",
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "1,2,3,4,5,6",
		spawn_probability      = "0.2,0.2,0.3,0.6,0.7,0.3",
		spawn_requires_flag    = "card_unlocked_ss_friendly",
		mana                   = 20,
		price                  = 160,
		action                 = function()
			c.fire_rate_wait = c.fire_rate_wait + 10
			c.extra_entities = c.extra_entities	.. "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_projectile.xml,data/entities/particles/tinyspark_green.xml,"
			draw_actions(1, true)
		end,
	},
	{ -- Friendly Explosion
		id                     = "SS_FRIENDLY_EXPLOSION",
		name                   = "$ss_action_friendly_explosion",
		description            = "$ss_actiondesc_friendly_explosion",
		sprite                 = "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.png",
		related_extra_entities = { "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "1,2,3,4,5,6",
		spawn_probability      = "0.2,0.2,0.3,0.6,0.7,0.3",
		spawn_requires_flag    = "card_unlocked_ss_friendly",
		mana                   = 15,
		price                  = 160,
		action                 = function()
			c.fire_rate_wait = c.fire_rate_wait + 10
			c.extra_entities = c.extra_entities .. "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.xml,data/entities/particles/tinyspark_green.xml,"
			draw_actions(1, true)
		end,
	},
	{ -- Friendly Safe
		id                     = "SS_FRIENDLY_SAFE",
		name                   = "$ss_action_friendly_safe",
		description            = "$ss_actiondesc_friendly_safe",
		sprite                 = "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_safe.png",
		related_extra_entities = {
			"mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_projectile.xml",
			"mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.xml",
		},
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "4,5,6",
		spawn_probability      = "0.2,0.2,0.3",
		spawn_requires_flag    = "action_ss_action_friendly_safe",
		mana                   = 40,
		price                  = 320,
		action                 = function()
			c.fire_rate_wait = c.fire_rate_wait + 15
			c.extra_entities = c.extra_entities .. "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_projectile.xml,mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.xml,data/entities/particles/tinyspark_green.xml,"
			draw_actions(1, true)
		end,
	},
	{ -- Chain Lightning Bolt
		id                     = "SS_CHAIN_LIGHTNING_BOLT",
		name                   = "$ss_action_chain_lightning_bolt",
		description            = "$ss_actiondesc_chain_lightning_bolt",
		sprite                 = "mods/spell_synthesis/files/spells/originals/chain_lightning_bolt/chain_lightning_bolt.png",
		related_projectiles    = { "mods/spell_synthesis/files/spells/originals/chain_lightning_bolt/chain_lightning_bolt.xml" },
		type                   = ACTION_TYPE_PROJECTILE,
		spawn_level            = "10",
		spawn_probability      = "0",
		mana                   = 150,
		custom_xml_file        = "data/entities/misc/custom_cards/electric_charge.xml",
		action                 = function()
			add_projectile("mods/spell_synthesis/files/spells/originals/chain_lightning_bolt/chain_lightning_bolt.xml")
			c.spread_degrees = c.spread_degrees + 14.0
			c.fire_rate_wait = c.fire_rate_wait + 95
			shot_effects.recoil_knockback = 180.0
		end,
	},
	{ -- Lightning-Fast Chain Bolt
		id                     = "SS_CHAIN_LIGHTNING_BOLT_FAST",
		name                   = "$ss_action_lightning_fast_bolt",
		description            = "$ss_actiondesc_lightning_fast_bolt",
		sprite                 = "mods/spell_synthesis/files/spells/originals/chain_lightning_bolt/chain_lightning_bolt_fast.png",
		related_projectiles    = { "mods/spell_synthesis/files/spells/originals/chain_lightning_bolt/chain_lightning_bolt_fast.xml" },
		type                   = ACTION_TYPE_PROJECTILE,
		spawn_level            = "10",
		spawn_probability      = "0",
		mana                   = 250,
		custom_xml_file        = "data/entities/misc/custom_cards/electric_charge.xml",
		action                 = function()
			add_projectile("mods/spell_synthesis/files/spells/originals/chain_lightning_bolt/chain_lightning_bolt_fast.xml")
			c.spread_degrees = c.spread_degrees + 30.0
			c.fire_rate_wait = c.fire_rate_wait + 150
			current_reload_time = current_reload_time + 50
			shot_effects.recoil_knockback = 180.0
		end,
	},
}

if actions then
	local index = #actions
	for i = 1, #spells do
		actions[index + i] = spells[i]
	end
end
