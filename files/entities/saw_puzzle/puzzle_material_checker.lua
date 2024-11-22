---@diagnostic disable: lowercase-global, missing-global-doc

local function disable_saws(pos_x, pos_y)
	local saws = EntityGetInRadiusWithTag(pos_x, pos_y, 15, "disc_bullet_big")
	for i = 1, #saws do
		local saw = saws[i]
		local projectile_component = EntityGetFirstComponent(saw, "ProjectileComponent")
		if projectile_component then
			ComponentSetValue2(projectile_component, "lifetime", 3)
		else
			EntityKill(saw)
		end
	end
end

function material_area_checker_success(pos_x, pos_y)
	local saw_count = 0
	local saws = EntityGetInRadiusWithTag(pos_x, pos_y, 15, "disc_bullet_big")
	for i = 1, #saws do
		local saw = saws[i]
		local sprite_component = EntityGetFirstComponent(saw, "SpriteComponent")
		if sprite_component then
			ComponentSetValue2(sprite_component, "rect_animation", "fireball")
			EntitySetComponentsWithTagEnabled(saw, "activate", true)
			saw_count = saw_count + 1
		end
	end

	if saw_count >= 2 then
		EntityLoad("mods/spell_synthesis/files/entities/saw_puzzle/puzzle_saw_mover.xml", pos_x, pos_y)
	else
		disable_saws(pos_x, pos_y)
	end
end

function material_area_checker_failed(pos_x, pos_y)
	disable_saws(pos_x, pos_y)
end
