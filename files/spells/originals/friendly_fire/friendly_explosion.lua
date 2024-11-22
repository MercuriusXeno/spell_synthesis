local entity_id = EntityGetRootEntity(GetUpdatedEntityID())
local projectile_component = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projectile_component number]]
ComponentSetValue2(projectile_component, "explosion_dont_damage_shooter", true)
