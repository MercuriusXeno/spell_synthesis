local eid = GetUpdatedEntityID()
local life_comps = EntityGetComponent(eid, "LifetimeComponent") or {}
for _, comp in ipairs(life_comps) do
    ComponentSetValue2(comp, "lifetime", -1)
end

local proj_comps = EntityGetComponent(eid, "ProjectileComponent") or {}
for _, comp in ipairs(proj_comps) do
    ComponentSetValue2(comp, "lifetime", -1)
end