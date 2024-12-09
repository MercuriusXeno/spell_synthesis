--- @type action[]
-- stylua: ignore
local spells = {
	{ -- Friendly Projectile
		id                     = "SS_FRIENDLY_PROJECTILE",
		name                   = "$ss_action_friendly_projectile",
		description            = "$ss_actiondesc_friendly_projectile",
		sprite                 = "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_fire.png",
		related_extra_entities = { "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_projectile.xml", },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "1,2,3,4,5,6",
		spawn_probability      = "0.2,0.2,0.3,0.6,0.7,0.3",
		spawn_requires_flag    = "card_unlocked_ss_friendly",
		mana                   = 20,
		price                  = 160,
		action                 = function()
			c.fire_rate_wait = c.fire_rate_wait + 10
			c.extra_entities = c.extra_entities ..
				"mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_projectile.xml,data/entities/particles/tinyspark_green.xml,"
			draw_actions(1, true)
		end,
	},
	{ -- Friendly Explosion
		id                     = "SS_FRIENDLY_EXPLOSION",
		name                   = "$ss_action_friendly_explosion",
		description            = "$ss_actiondesc_friendly_explosion",
		sprite                 = "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.png",
		related_extra_entities = { "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.xml", },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "1,2,3,4,5,6",
		spawn_probability      = "0.2,0.2,0.3,0.6,0.7,0.3",
		spawn_requires_flag    = "card_unlocked_ss_friendly",
		mana                   = 15,
		price                  = 160,
		action                 = function()
			c.fire_rate_wait = c.fire_rate_wait + 10
			c.extra_entities = c.extra_entities ..
				"mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.xml,data/entities/particles/tinyspark_green.xml,"
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
			c.extra_entities = c.extra_entities ..
				"mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_projectile.xml,mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.xml,data/entities/particles/tinyspark_green.xml,"
			draw_actions(1, true)
		end,
	},
}

if actions then
	local index = #actions
	for i = 1, #spells do
		actions[index + i] = spells[i]
	end
end
