local sprite_generator = dofile_once("mods/spell_synthesis/files/scripts/sprite_generator.lua") --- @type ss_sprite_generator

--- @type action[]
-- stylua: ignore
local spells = {
	{ -- Spark Bolt
		id                  = "SS_LIGHT_BULLET_2",
		name                = "$ss_action_light_bullet_2",
		description         = "$ss_actiondesc_light_bullet_2",
		sprite              = "mods/spell_synthesis/files/spells/evolutions/light_bullet/light_bullet_2.png",
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/light_bullet/SS_LIGHT_BULLET_2.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		mana                = 8,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/light_bullet/SS_LIGHT_BULLET_2.xml")
			c.fire_rate_wait = c.fire_rate_wait + 4
			c.screenshake = c.screenshake + 0.4
			c.spread_degrees = c.spread_degrees - 2.0
			c.damage_critical_chance = c.damage_critical_chance + 7
		end,
	},
	{
		id                  = "SS_LIGHT_BULLET_3",
		name                = "$ss_action_light_bullet_2",
		description         = "$ss_actiondesc_light_bullet_3",
		sprite              = "mods/spell_synthesis/files/spells/evolutions/light_bullet/light_bullet_3.png",
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/light_bullet/SS_LIGHT_BULLET_3.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		mana                = 12,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/light_bullet/SS_LIGHT_BULLET_3.xml")
			c.fire_rate_wait = c.fire_rate_wait + 6
			c.screenshake = c.screenshake + 0.3
			c.spread_degrees = c.spread_degrees - 3.0
			c.damage_critical_chance = c.damage_critical_chance + 10
		end,
	},
	{ -- Digger
		id                  = "SS_DIGGER_2",
		name                = "$ss_action_digger_2",
		description         = "$ss_actiondesc_digger_2",
		sprite              = "mods/spell_synthesis/files/spells/evolutions/digger/digger_2.png",
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/digger/ss_digger_2.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		mana                = 0,
		sound_loop_tag      = "sound_digger",
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/digger/ss_digger_2.xml")
			c.fire_rate_wait = c.fire_rate_wait + 1
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10
		end,
	},
	{
		id                  = "SS_DIGGER_3",
		name                = "$ss_action_digger_3",
		description         = "$ss_actiondesc_digger_3",
		sprite              = "mods/spell_synthesis/files/spells/evolutions/digger/digger_3.png",
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/digger/ss_digger_3.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		mana                = 2,
		sound_loop_tag      = "sound_digger",
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/digger/ss_digger_3.xml")
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10
		end,
	},
	{ -- Bouncy burst
		id                  = "SS_RUBBER_BALL_2",
		name                = "$ss_action_rubber_ball_2",
		description         = "$ss_actiondesc_rubber_ball_2",
		sprite              = "mods/spell_synthesis/files/spells/evolutions/rubber_ball/rubber_ball_2.png",
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/rubber_ball/rubber_ball_2.xml", 2, },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 120,
		mana                = 10,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/rubber_ball/rubber_ball_2.xml")
			add_projectile("mods/spell_synthesis/files/spells/evolutions/rubber_ball/rubber_ball_2.xml")
			c.fire_rate_wait = c.fire_rate_wait - 2
			c.spread_degrees = c.spread_degrees + 7.0
		end,
	},
	{
		id                  = "SS_RUBBER_BALL_3",
		name                = "$ss_action_rubber_ball_3",
		description         = "$ss_actiondesc_rubber_ball_3",
		sprite              = "mods/spell_synthesis/files/spells/evolutions/rubber_ball/rubber_ball_3.png",
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/rubber_ball/rubber_ball_3.xml", 3, },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 240,
		mana                = 20,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/rubber_ball/rubber_ball_3.xml")
			add_projectile("mods/spell_synthesis/files/spells/evolutions/rubber_ball/rubber_ball_3.xml")
			add_projectile("mods/spell_synthesis/files/spells/evolutions/rubber_ball/rubber_ball_3.xml")
			c.fire_rate_wait = c.fire_rate_wait - 2
			c.spread_degrees = c.spread_degrees + 14.0
		end,
	},
	{ -- Energy Sphere
		id                  = "SS_BOUNCY_ORB_2",
		name                = "$ss_action_bouncy_orb_2",
		description         = "$ss_actiondesc_bouncy_orb_2",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/bouncy_orb.png", 2),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/bouncy_orb/bouncy_orb_2.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 240,
		mana                = 30,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/bouncy_orb/bouncy_orb_2.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
			shot_effects.recoil_knockback = 20.0
		end,
	},
	{
		id                  = "SS_BOUNCY_ORB_3",
		name                = "$ss_action_bouncy_orb_3",
		description         = "$ss_actiondesc_bouncy_orb_3",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/bouncy_orb.png", 3),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/bouncy_orb/bouncy_orb_3.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 500,
		mana                = 40,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/bouncy_orb/bouncy_orb_3.xml")
			c.fire_rate_wait = c.fire_rate_wait + 30
			shot_effects.recoil_knockback = 20.0
		end,
	},
	{ -- Magic arrow
		id                  = "SS_BULLET_2",
		name                = "$action_bullet",
		description         = "$actiondesc_bullet",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/bullet.png", 2),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/bullet/bullet_2.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 150,
		mana                = 30,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/bullet/bullet_2.xml")
			c.fire_rate_wait = c.fire_rate_wait + 6
			c.screenshake = c.screenshake + 2
			c.spread_degrees = c.spread_degrees + 2.0
			c.damage_critical_chance = c.damage_critical_chance + 5
		end,
	},
	{
		id                  = "SS_BULLET_3",
		name                = "$action_bullet",
		description         = "$actiondesc_bullet",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/bullet.png", 3),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/bullet/bullet_3.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 150,
		mana                = 40,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/bullet/bullet_3.xml")
			c.fire_rate_wait = c.fire_rate_wait + 9
			c.screenshake = c.screenshake + 2
			c.spread_degrees = c.spread_degrees + 1.0
			c.damage_critical_chance = c.damage_critical_chance + 7
		end,
	},
	{ -- Magic bolt
		id                  = "SS_HEAVY_BULLET_2",
		name                = "$action_heavy_bullet",
		description         = "$actiondesc_heavy_bullet",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/heavy_bullet.png", 2),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/heavy_bullet/bullet_heavy_2.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 200,
		mana                = 45,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/heavy_bullet/bullet_heavy_2.xml")
			c.fire_rate_wait = c.fire_rate_wait + 10
			c.screenshake = c.screenshake + 2.5
			c.spread_degrees = c.spread_degrees + 5.0
			c.damage_critical_chance = c.damage_critical_chance + 5
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 25.0
		end,
	},
	{
		id                  = "SS_HEAVY_BULLET_3",
		name                = "$action_heavy_bullet",
		description         = "$actiondesc_heavy_bullet",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/heavy_bullet.png", 3),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/heavy_bullet/bullet_heavy_3.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 200,
		mana                = 60,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/heavy_bullet/bullet_heavy_3.xml")
			c.fire_rate_wait = c.fire_rate_wait + 20
			c.screenshake = c.screenshake + 2.5
			c.spread_degrees = c.spread_degrees + 5.0
			c.damage_critical_chance = c.damage_critical_chance + 7
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
		end,
	},
	{ -- Energy orb
		id                  = "SS_SLOW_BULLET_2",
		name                = "$action_slow_bullet",
		description         = "$actiondesc_slow_bullet",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/slow_bullet.png", 2),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/slow_bullet/bullet_slow_2.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 160,
		mana                = 40,
		custom_xml_file     = "data/entities/misc/custom_cards/bullet_slow.xml",
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/slow_bullet/bullet_slow_2.xml")
			c.fire_rate_wait = c.fire_rate_wait + 10
			c.screenshake = c.screenshake + 2
			c.spread_degrees = c.spread_degrees + 3.6
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 20.0
		end,
	},
	{
		id                  = "SS_SLOW_BULLET_3",
		name                = "$action_slow_bullet",
		description         = "$actiondesc_slow_bullet",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/slow_bullet.png", 3),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/slow_bullet/bullet_slow_3.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 160,
		mana                = 55,
		custom_xml_file     = "data/entities/misc/custom_cards/bullet_slow.xml",
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/slow_bullet/bullet_slow_3.xml")
			c.fire_rate_wait = c.fire_rate_wait + 20
			c.screenshake = c.screenshake + 2
			c.spread_degrees = c.spread_degrees + 3.6
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 15.0
		end,
	},
	{ -- Bubble spark
		id                  = "SS_BUBBLESHOT_2",
		name                = "$action_bubbleshot",
		description         = "$actiondesc_bubbleshot",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/bubbleshot.png", 2),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/bubbleshot/bubbleshot_2.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 100,
		mana                = 10,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/bubbleshot/bubbleshot_2.xml")
			c.fire_rate_wait = c.fire_rate_wait - 8
			c.dampening = 0.2
		end,
	},
	{
		id                  = "SS_BUBBLESHOT_3",
		name                = "$action_bubbleshot",
		description         = "$actiondesc_bubbleshot",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/bubbleshot.png", 3),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/bubbleshot/bubbleshot_3.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 100,
		mana                = 20,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/bubbleshot/bubbleshot_3.xml")
			c.fire_rate_wait = c.fire_rate_wait - 15
			c.dampening = 0.4
			current_reload_time = current_reload_time - 10
		end,
	},
	{ -- Arrow
		id                  = "SS_ARROW_2",
		name                = "$action_arrow",
		description         = "$actiondesc_arrow",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/arrow.png", 2),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/arrow/arrow_2.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 140,
		mana                = 20,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/arrow/arrow_2.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
			c.spread_degrees = c.spread_degrees - 25
			shot_effects.recoil_knockback = 10.0
		end,
	},
	{
		id                  = "SS_ARROW_3",
		name                = "$action_arrow",
		description         = "$actiondesc_arrow",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/arrow.png", 3),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/arrow/arrow_3.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 140,
		mana                = 25,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/arrow/arrow_3.xml")
			c.fire_rate_wait = c.fire_rate_wait + 20
			c.spread_degrees = c.spread_degrees - 30
		end,
	},
	{ -- Triplicate bolt
		id                  = "SS_BUCKSHOT_2",
		name                = "$action_buckshot",
		description         = "$actiondesc_buckshot",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/buckshot.png", 2),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/buckshot/buckshot_2.xml", 4, },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 160,
		mana                = 30,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/buckshot/buckshot_2.xml")
			add_projectile("mods/spell_synthesis/files/spells/evolutions/buckshot/buckshot_2.xml")
			add_projectile("mods/spell_synthesis/files/spells/evolutions/buckshot/buckshot_2.xml")
			add_projectile("mods/spell_synthesis/files/spells/evolutions/buckshot/buckshot_2.xml")
			c.fire_rate_wait = c.fire_rate_wait + 10
			c.spread_degrees = c.spread_degrees + 18.0
		end,
	},
	{
		id                  = "SS_BUCKSHOT_3",
		name                = "$action_buckshot",
		description         = "$actiondesc_buckshot",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/buckshot.png", 3),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/buckshot/buckshot_3.xml", 5, },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 160,
		mana                = 40,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/buckshot/buckshot_3.xml")
			add_projectile("mods/spell_synthesis/files/spells/evolutions/buckshot/buckshot_3.xml")
			add_projectile("mods/spell_synthesis/files/spells/evolutions/buckshot/buckshot_3.xml")
			add_projectile("mods/spell_synthesis/files/spells/evolutions/buckshot/buckshot_3.xml")
			add_projectile("mods/spell_synthesis/files/spells/evolutions/buckshot/buckshot_3.xml")
			c.fire_rate_wait = c.fire_rate_wait + 12
			c.spread_degrees = c.spread_degrees + 22.0
		end,
	},
	{ -- Healing bolt
		id                  = "SS_HEAL_BULLET_2",
		name                = "$action_heal_bullet",
		description         = "$actiondesc_heal_bullet",
		sprite              = "mods/spell_synthesis/files/spells/evolutions/heal_bullet/heal_bullet_2.png",
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/heal_bullet/heal_bullet_2.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 60,
		mana                = 30,
		max_uses            = 30,
		never_unlimited     = true,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/heal_bullet/heal_bullet_2.xml")
		end,
	},
	{
		id                  = "SS_HEAL_BULLET_3",
		name                = "$action_heal_bullet",
		description         = "$actiondesc_heal_bullet",
		sprite              = "mods/spell_synthesis/files/spells/evolutions/heal_bullet/heal_bullet_3.png",
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/heal_bullet/heal_bullet_3.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 60,
		mana                = 40,
		max_uses            = 40,
		never_unlimited     = true,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/heal_bullet/heal_bullet_3.xml")
		end,
	},
	{ -- Bomb
		id                  = "SS_BOMB_2",
		name                = "$action_bomb",
		description         = "$actiondesc_bomb",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/bomb.png", 2),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/bomb/bomb_2.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 200,
		mana                = 40,
		max_uses            = 6,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/bomb/bomb_2.xml")
			c.fire_rate_wait = c.fire_rate_wait + 100
		end,
	},
	{
		id                  = "SS_BOMB_3",
		name                = "$action_bomb",
		description         = "$actiondesc_bomb",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/bomb.png", 3),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/bomb/bomb_3.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 200,
		mana                = 70,
		max_uses            = 10,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/bomb/bomb_3.xml")
			c.fire_rate_wait = c.fire_rate_wait + 100
		end,
	},
	{ -- Dynamite
		id                  = "SS_DYNAMITE_2",
		name                = "$action_dynamite",
		description         = "$actiondesc_dynamite",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/dynamite.png", 2),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/dynamite/dynamite_2.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 160,
		mana                = 70,
		max_uses            = 24,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/dynamite/dynamite_2.xml")
			c.fire_rate_wait = c.fire_rate_wait + 50
			c.spread_degrees = c.spread_degrees + 6.0
		end,
	},
	{
		id                  = "SS_DYNAMITE_3",
		name                = "$action_dynamite",
		description         = "$actiondesc_dynamite",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/dynamite.png", 3),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/dynamite/dynamite_3.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 160,
		mana                = 80,
		max_uses            = 40,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/dynamite/dynamite_3.xml")
			c.fire_rate_wait = c.fire_rate_wait + 50
			c.spread_degrees = c.spread_degrees + 6.0
		end,
	},
	{ -- Disc projectile
		id                  = "SS_DISC_BULLET_2",
		name                = "$action_disc_bullet",
		description         = "$actiondesc_disc_bullet",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/disc_bullet.png", 2),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/disc_bullet/disc_bullet_2.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 120,
		mana                = 25,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/disc_bullet/disc_bullet_2.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
			c.spread_degrees = c.spread_degrees + 2.0
			shot_effects.recoil_knockback = 10.0
		end,
	},
	{
		id                  = "SS_DISC_BULLET_3",
		name                = "$action_disc_bullet",
		description         = "$actiondesc_disc_bullet",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/disc_bullet.png", 3),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/disc_bullet/disc_bullet_3.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 120,
		mana                = 40,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/disc_bullet/disc_bullet_3.xml")
			c.fire_rate_wait = c.fire_rate_wait + 30
		end,
	},
	{ -- Pollen
		id                  = "SS_POLLEN_2",
		name                = "$action_pollen",
		description         = "$actiondesc_pollen",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/pollen.png", 2),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/pollen/pollen_2.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 110,
		mana                = 15,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/pollen/pollen_2.xml")
			c.fire_rate_wait = c.fire_rate_wait + 4
			c.spread_degrees = c.spread_degrees + 20
		end,
	},
	{
		id                  = "SS_POLLEN_3",
		name                = "$action_pollen",
		description         = "$actiondesc_pollen",
		sprite              = sprite_generator:add_level_glow("data/ui_gfx/gun_actions/pollen.png", 3),
		related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/pollen/pollen_3.xml", },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "10",
		spawn_probability   = "0",
		price               = 110,
		mana                = 20,
		action              = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/pollen/pollen_3.xml")
			c.fire_rate_wait = c.fire_rate_wait + 6
			c.spread_degrees = c.spread_degrees + 20
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
