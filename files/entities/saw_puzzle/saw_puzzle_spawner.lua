local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

EntityLoad("mods/spell_synthesis/files/entities/saw_puzzle/puzzle_material_checker.xml", x, y)
EntityLoad("data/entities/props/furniture_table.xml", x + 4, y + 3)
EntityLoad("mods/spell_synthesis/files/entities/saw_puzzle/puzzle_disc_bullet.xml", x - 13, y + 5)
EntityLoad("mods/spell_synthesis/files/entities/saw_puzzle/puzzle_disc_bullet.xml", x + 13, y + 5)

EntityKill(entity_id)
