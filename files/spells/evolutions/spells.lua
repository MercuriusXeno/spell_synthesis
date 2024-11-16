local sprite_generator = dofile_once("mods/spell_synthesis/files/scripts/sprite_generator.lua") --- @type ss_sprite_generator

---@type action[]
local spells = {
	{
		id = "SS_LIGHT_BULLET_2",
		name = "$action_light_bullet",
		description = "$actiondesc_light_bullet",
		sprite = sprite_generator:merge_icons("data/ui_gfx/gun_actions/light_bullet.png", 2),
		-- related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/SS_LIGHT_BULLET_2/SS_LIGHT_BULLET_2.xml" },
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "10",
		spawn_probability = "0",
		mana = 7.5,
		--max_uses = -1,
		action = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/light_bullet/SS_LIGHT_BULLET_2.xml")
			c.fire_rate_wait = c.fire_rate_wait + 4
			c.screenshake = c.screenshake + 0.5
			c.spread_degrees = c.spread_degrees - 1.0
			c.damage_critical_chance = c.damage_critical_chance + 7
		end,
	},
	{
		id = "SS_LIGHT_BULLET_3",
		name = "$action_light_bullet",
		description = "$actiondesc_light_bullet",
		sprite = sprite_generator:merge_icons("data/ui_gfx/gun_actions/light_bullet.png", 3),
		-- related_projectiles = { "mods/spell_synthesis/files/spells/evolutions/SS_LIGHT_BULLET_2/SS_LIGHT_BULLET_2.xml" },
		type = ACTION_TYPE_PROJECTILE,
		spawn_level = "10",
		spawn_probability = "0",
		mana = 11,
		--max_uses = -1,
		action = function()
			add_projectile("mods/spell_synthesis/files/spells/evolutions/light_bullet/SS_LIGHT_BULLET_3.xml")
			c.fire_rate_wait = c.fire_rate_wait + 6
			c.screenshake = c.screenshake + 0.5
			c.spread_degrees = c.spread_degrees - 1.0
			c.damage_critical_chance = c.damage_critical_chance + 10
		end,
	},
}

if actions then
	local index = #actions
	for i = 1, #spells do
		actions[index + i] = spells[i]
	end
end
