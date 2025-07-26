local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local homing_radius = 160
-- get existing homing component
local comp = EntityGetFirstComponent( entity_id, "HomingComponent", "homing_projectile" )
if ( comp ~= nil ) then
    local target = ComponentGetValue2( comp, "predefined_target" )
    if EntityGetIsAlive(target) then
        return
    end
end

local targets = EntityGetInRadiusWithTag(x, y, homing_radius, "enemy")

-- Remove existing HomingComponent if any
local homing_components = EntityGetComponent(entity_id, "HomingComponent") or {}
for _, oldComp in ipairs(homing_components) do
    EntityRemoveComponent(entity_id, oldComp)
end

-- Filter out invalid targets
local homing_comp = nil
if targets ~= nil then
  for i = 1, #targets do
    if EntityGetIsAlive(targets[i]) then
        homing_comp = {
            _tags = "homing_projectile",
            predefined_target = targets[i],
            detect_distance = 160,
            target_tag = "enemy",
            homing_velocity_multiplier = .90,
            homing_targeting_coeff = 150,  -- tweak for curve sharpness
        }
        break
    end
  end
end

-- If no enemy target found, fallback to player
if homing_comp == nil then
    homing_comp = {
            _tags = "homing_projectile",
            detect_distance = math.huge,
            target_who_shot = true,
            homing_velocity_multiplier = .95,
            homing_targeting_coeff = 170,  -- tweak for curve sharpness
        }
end

-- Add new homing component
EntityAddComponent2(entity_id, "HomingComponent", homing_comp)
