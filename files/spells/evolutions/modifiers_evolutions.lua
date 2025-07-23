local sprite_generator = dofile_once("mods/spell_synthesis/files/scripts/sprite_generator.lua") --- @type ss_sprite_generator

--- @type action[]
-- stylua: ignore
local spells = {
	{ -- reduced spread
        id          = "SS_REDUCED_SPREAD_2",
        name 		= "Reduced Spread 2",
        description = "Further reduces spread pattern",
        sprite 		= "mods/spell_synthesis/files/spells/evolutions/spread_reduce/reduced_spread_2.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "10",
        spawn_probability                 = "0",
        price = 100,
        mana = 2,
        action 		= function()
            c.spread_degrees    = c.spread_degrees - 120
            draw_actions( 1, true )
        end,
	},
	{
        id          = "SS_REDUCED_SPREAD_3",
        name 		= "Reduced Spread 3",
        description = "Greatly reduces spread pattern",
        sprite 		= "mods/spell_synthesis/files/spells/evolutions/spread_reduce/reduced_spread_3.png",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "10",
        spawn_probability                 = "0",
        price = 100,
        mana = 3,
        action 		= function()
            c.spread_degrees    = c.spread_degrees - 240
            draw_actions( 1, true )
        end,
	},
	{
        id          = "SS_REDUCED_SPREAD_4",
        name 		= "Reduced Spread 4",
        description = "Negate all but extreme spread",
        sprite 		= sprite_generator:add_level_glow("mods/spell_synthesis/files/spells/evolutions/spread_reduce/reduced_spread_3.png",2),
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "10",
        spawn_probability                 = "0",
        price = 100,
        mana = 4,
        action 		= function()
            c.spread_degrees    = c.spread_degrees - 480
            draw_actions( 1, true )
        end,
	},
	{
        id          = "SS_REDUCED_SPREAD_5",
        name 		= "Reduced Spread 5",
        description = "Negate even the most extreme spread",
        sprite 		= sprite_generator:add_level_glow("mods/spell_synthesis/files/spells/evolutions/spread_reduce/reduced_spread_3.png",3),
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        type 		= ACTION_TYPE_MODIFIER,
        spawn_level                       = "10",
        spawn_probability                 = "0",
        price = 100,
        mana = 5,
        action 		= function()
            c.spread_degrees    = c.spread_degrees - 960
            draw_actions( 1, true )
        end,
	},
	{ -- recharge
		id          = "SS_RECHARGE_2",
		name 		= "RECHARGE II",
		description = "Further reduces the time between spellcasts",
		sprite 		= "mods/spell_synthesis/files/spells/evolutions/recharge/recharge_2.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "10",
		spawn_probability                 = "0",
		price = 200,
		mana = 20,
		action 		= function()
			c.fire_rate_wait    = c.fire_rate_wait - 25
			current_reload_time = current_reload_time - 50
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SS_RECHARGE_3",
		name 		= "RECHARGE III",
		description = "Greatly reduces the time between spellcases",
		sprite 		= "mods/spell_synthesis/files/spells/evolutions/recharge/recharge_3.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "10", -- SPREAD_REDUCE
		spawn_probability                 = "0", -- SPREAD_REDUCE
		price = 200,
		mana = 40,
		action 		= function()
			c.fire_rate_wait    = c.fire_rate_wait - 60
			current_reload_time = current_reload_time - 120
			draw_actions( 1, true )
		end,
	},
	{ -- mana reduce
		id          = "SS_MANA_REDUCE_2",
		name 		= "MANA II",
		description = "Generously increases mana when cast",
		sprite 		= "mods/spell_synthesis/files/spells/evolutions/mana_reduce/mana_reduce_2.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "10",
		spawn_probability                 = "0",
		price = 250,
		mana = -80,
		custom_xml_file = "data/entities/misc/custom_cards/mana_reduce.xml",
		action 		= function()
			c.fire_rate_wait = c.fire_rate_wait + 20
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SS_MANA_REDUCE_3",
		name 		= "MANA III",
		description = "Massively increases mana when cast",
		sprite 		= "mods/spell_synthesis/files/spells/evolutions/mana_reduce/mana_reduce_3.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "10",
		spawn_probability                 = "0",
		price = 250,
		mana = -240,
		custom_xml_file = "data/entities/misc/custom_cards/mana_reduce.xml",
		action 		= function()
			c.fire_rate_wait = c.fire_rate_wait + 30
			draw_actions( 1, true )
		end,
	},
	{ -- lifetime
		id          = "SS_LIFETIME_2",
		name 		= "LIFETIME II",
		description = "$actiondesc_lifetime",
		sprite 		= sprite_generator:add_level_glow("data/ui_gfx/gun_actions/lifetime.png",2),
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "10",
		spawn_probability                 = "0",
		price = 250,
		mana = 75,
		custom_xml_file = "data/entities/misc/custom_cards/lifetime.xml",
		action 		= function()
			c.lifetime_add 		= c.lifetime_add + 150
			c.fire_rate_wait = c.fire_rate_wait + 25
			draw_actions( 1, true )
		end,
	},
	{
		id          = "SS_LIFETIME_3",
		name 		= "LIFETIME III",
		description = "$actiondesc_lifetime",
		sprite 		= sprite_generator:add_level_glow("data/ui_gfx/gun_actions/lifetime.png",3),
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "10",
		spawn_probability                 = "0",
		price = 250,
		mana = 150,
		custom_xml_file = "data/entities/misc/custom_cards/lifetime.xml",
		action 		= function()
			c.lifetime_add 		= c.lifetime_add + 300
			c.fire_rate_wait = c.fire_rate_wait + 40
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
