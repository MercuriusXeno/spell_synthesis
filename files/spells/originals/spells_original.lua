---@type action[]
local spells = {
	{
		id = "SS_FRIENDLY_PROJECTILE",
		name = "$ss_action_friendly_projectile",
		description = "$ss_actiondesc_friendly_projectile",
		sprite = "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_fire.png",
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "10",
		spawn_probability = "0",
		mana = 20,
		action = function()
			c.extra_entities = c.extra_entities
				.. "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_projectile.xml,data/entities/particles/tinyspark_green.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id = "SS_FRIENDLY_EXPLOSION",
		name = "$ss_action_friendly_explosion",
		description = "$ss_actiondesc_friendly_explosion",
		sprite = "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.png",
		related_extra_entities = { "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.xml" },
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "10",
		spawn_probability = "0",
		mana = 15,
		action = function()
			c.explosion_dont_damage_shooter = true
			c.extra_entities = c.extra_entities
				.. "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.xml,data/entities/particles/tinyspark_green.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id = "SS_FRIENDLY_SAFE",
		name = "$ss_action_friendly_safe",
		description = "$ss_actiondesc_friendly_safe",
		sprite = "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_safe.png",
		related_extra_entities = {
			"mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_projectile.xml",
			"mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.xml",
		},
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "10",
		spawn_probability = "0",
		mana = 40,
		action = function()
			c.extra_entities = c.extra_entities
				.. "mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_projectile.xml,mods/spell_synthesis/files/spells/originals/friendly_fire/friendly_explosion.xml,data/entities/particles/tinyspark_green.xml,"
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
