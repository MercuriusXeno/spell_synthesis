local entity_id = EntityGetRootEntity(GetUpdatedEntityID())

local projectile_component = EntityGetFirstComponent(entity_id, "ProjectileComponent")
if projectile_component then ComponentSetValue2(projectile_component, "friendly_fire", false) end

local area_damage_components = EntityGetComponentIncludingDisabled(entity_id, "AreaDamageComponent")
if area_damage_components then
	for i = 1, #area_damage_components do
		print(area_damage_components[i])
		ComponentSetValue2(area_damage_components[i], "entities_with_tag", "enemy,nest,homing_target")
	end
end
