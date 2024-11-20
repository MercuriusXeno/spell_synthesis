local entity_id = EntityGetRootEntity(GetUpdatedEntityID())
local projectile_component = EntityGetFirstComponent(entity_id, "ProjectileComponent")
if not projectile_component then return end
ComponentSetValue2(projectile_component, "explosion_dont_damage_shooter", true)
