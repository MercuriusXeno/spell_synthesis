local entity = GetUpdatedEntityID()

if ModSettingGet("spell_synthesis.fuser_workshop") then
	local pos_x, pos_y = EntityGetTransform(entity)
	local workshop_entity = EntityLoad("mods/spell_synthesis/files/entities/fuser/base/fuser_workshop.xml", pos_x, pos_y)
	EntityAddChild(entity, workshop_entity)
end

EntityRemoveComponent(entity, GetUpdatedComponentID())
