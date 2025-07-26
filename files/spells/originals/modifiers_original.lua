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
		spawn_requires_flag    = "action_ss_friendly_safe",
		mana                   = 40,
		price                  = 320,
		action                 = function()
			c.fire_rate_wait = c.fire_rate_wait + 15
			c.extra_entities = c.extra_entities ..
				"mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_projectile.xml,mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.xml,data/entities/particles/tinyspark_green.xml,"
			draw_actions(1, true)
		end,
	},
	{ -- recharge + mana reduce
		id          = "SS_ENERGIZE",
		name 		= "ENERGIZE",
		description = "Enhance a wand's speed and mana stability",
		sprite 		= "mods/spell_synthesis/files/spells/originals/energize/energize.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "10",
		spawn_probability                 = "0",
		price = 300,
		mana = -30,
		custom_xml_file = "data/entities/misc/custom_cards/mana_reduce.xml",
		action 		= function()
			c.fire_rate_wait    = c.fire_rate_wait - 10
			current_reload_time = current_reload_time - 20
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SS_ENERGIZE_2",
		name 		= "ENERGIZE II",
		description = "Further enhances a wand's speed and mana stability",
		sprite 		= "mods/spell_synthesis/files/spells/originals/energize/energize_2.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "10",
		spawn_probability                 = "0",
		price = 300,
		mana = -80,
		custom_xml_file = "data/entities/misc/custom_cards/mana_reduce.xml",
		action 		= function()
			c.fire_rate_wait    = c.fire_rate_wait - 25
			current_reload_time = current_reload_time - 50
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SS_ENERGIZE_3",
		name 		= "ENERGIZE III",
		description = "Greatly enhances a wand's speed and mana stability",
		sprite 		= "mods/spell_synthesis/files/spells/originals/energize/energize_3.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "10",
		spawn_probability                 = "0",
		price = 300,
		mana = -240,
		custom_xml_file = "data/entities/misc/custom_cards/mana_reduce.xml",
		action 		= function()
			c.fire_rate_wait    = c.fire_rate_wait - 60
			current_reload_time = current_reload_time - 120
			draw_actions( 1, true )
		end,
	},
	{ -- auto-wisp
		id          = "SS_WISP",
		name 		= "WISP",
		description = "Causes spells to be semi-permanent",
		sprite 		= "mods/spell_synthesis/files/spells/originals/wisp/wisp.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		related_extra_entities = { "mods/spell_synthesis/files/spells/originals/wisp/wisp.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "10",
		spawn_probability                 = "0",
		price = 40,
		mana = 120,
		action 		= function()
			c.extra_entities = c.extra_entities .. ",mods/spell_synthesis/files/spells/originals/wisp/wisp.xml,"
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SS_HEELING_HOMING",
		name 		= "HEELING HOMING",
		description = "Causes spells to return to you between targets",
		sprite 		= "mods/spell_synthesis/files/spells/originals/heeling_homing/heeling_homing.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
		related_extra_entities = { "mods/spell_synthesis/files/spells/originals/heeling_homing/heeling_homing.xml",
			"data/entities/particles/tinyspark_white_small.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "10",
		spawn_probability                 = "0",
		price = 180,
		mana = 90,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/spell_synthesis/files/spells/originals/heeling_homing/heeling_homing.xml,data/entities/particles/tinyspark_white_small.xml,"
			draw_actions( 1, true )
		end,
	},
}

if actions then
	local index = #actions
	for i = 1, #spells do
		local spell = spells[i]
		if not spell.spawn_requires_flag then spell.spawn_requires_flag = string.format("action_%s", spell.id:lower()) end
		actions[index + i] = spell
	end
end
