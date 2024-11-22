local entity_id = EntityGetRootEntity(GetUpdatedEntityID())

local projectile_component = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projectile_component number]]
ComponentSetValue2(projectile_component, "friendly_fire", false)

local area_damage_components = EntityGetComponentIncludingDisabled(entity_id, "AreaDamageComponent") or {}
for i = 1, #area_damage_components do
	print(area_damage_components[i])
	ComponentSetValue2(area_damage_components[i], "entities_with_tag", "enemy,nest,homing_target")
end
