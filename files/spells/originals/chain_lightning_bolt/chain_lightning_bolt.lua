--- @type ss_chain_projectile_helper
local chain_projectile = dofile_once("mods/spell_synthesis/files/spells/helpers/chain_projectile_helper.lua")

local entity_id = GetUpdatedEntityID()
local x, y, rotation = EntityGetTransform(entity_id)
local radius = 50
local default_teleport_radius = 50

local variable_components = EntityGetComponent(entity_id, "VariableStorageComponent") or {}
local prev_entity_id, prev_prev_entity_id = chain_projectile:get_previous_entities(variable_components)

local target = chain_projectile:get_target(x, y, radius, { prev_entity_id, prev_prev_entity_id })
if target then
	prev_prev_entity_id = prev_entity_id
	prev_entity_id = target
	local target_x, target_y = EntityGetFirstHitboxCenter(target)
	if target_x then
		EntitySetTransform(entity_id, target_x, target_y)
		x = target_x
		y = target_y
	end
else
	prev_prev_entity_id = prev_entity_id
	prev_entity_id = 0 ---@diagnostic disable-line: cast-local-type
	local angle = 0 - rotation
	x = x + math.cos(angle) * default_teleport_radius
	y = y - math.sin(angle) * default_teleport_radius
	EntitySetTransform(entity_id, x, y)
end

chain_projectile:set_previous_entities(variable_components, prev_entity_id, prev_prev_entity_id) ---@diagnostic disable-line: param-type-mismatch

local explosion_entity_id = EntityLoad("mods/spell_synthesis/files/spells/originals/chain_lightning_bolt/lightning_explosion.xml", x, y)
GameShootProjectile(entity_id, x, y, x, y, explosion_entity_id)
