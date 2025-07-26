--- @type action[]
-- stylua: ignore
local spells = {
	{ -- Chain Lightning Bolt
		id                  = "SS_CHAIN_LIGHTNING_BOLT",
		name                = "$ss_action_chain_lightning_bolt",
		description         = "$ss_actiondesc_chain_lightning_bolt",
		sprite              = "mods/spell_synthesis/files/spells/originals/chain_lightning_bolt/chain_lightning_bolt.png",
		related_projectiles = { "mods/spell_synthesis/files/spells/originals/chain_lightning_bolt/chain_lightning_bolt.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		mana                = 150,
		custom_xml_file     = "data/entities/misc/custom_cards/electric_charge.xml",
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/originals/chain_lightning_bolt/chain_lightning_bolt.xml")
			c.spread_degrees = c.spread_degrees + 14.0
			c.fire_rate_wait = c.fire_rate_wait + 95
			shot_effects.recoil_knockback = 180.0
		end,
	},
	{ -- Lightning-Fast Chain Bolt
		id                  = "SS_CHAIN_LIGHTNING_BOLT_FAST",
		name                = "$ss_action_lightning_fast_bolt",
		description         = "$ss_actiondesc_lightning_fast_bolt",
		sprite              = "mods/spell_synthesis/files/spells/originals/chain_lightning_bolt/chain_lightning_bolt_fast.png",
		related_projectiles = { "mods/spell_synthesis/files/spells/originals/chain_lightning_bolt/chain_lightning_bolt_fast.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		mana                = 250,
		custom_xml_file     = "data/entities/misc/custom_cards/electric_charge.xml",
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/originals/chain_lightning_bolt/chain_lightning_bolt_fast.xml")
			c.spread_degrees = c.spread_degrees + 30.0
			c.fire_rate_wait = c.fire_rate_wait + 150
			current_reload_time = current_reload_time + 50
			shot_effects.recoil_knockback = 180.0
		end,	
	},
	{
		id                  = "SS_DEMATERIALIZING_BURST",
		name                = "DEMATERIALIZING BURST",
		description         = "Collosal anti-material field",
		sprite              = "mods/spell_synthesis/files/spells/originals/dematerializing_burst/dematerializing_burst.png",
		related_projectiles = { "mods/spell_synthesis/files/spells/originals/dematerializing_burst/dematerializing_burst.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		mana                = 60,
		sound_loop_tag      = "sound_digger",
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/originals/dematerializing_burst/dematerializing_burst.xml")
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10
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
