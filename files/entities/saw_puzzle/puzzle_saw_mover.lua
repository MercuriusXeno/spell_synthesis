local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local direction = GetValueInteger("direction", 1)
local saw_y = y + 5

local time_past_since_start = GetValueInteger("time_past_since_start", 0)
SetValueInteger("time_past_since_start", time_past_since_start + 1)
if time_past_since_start < 13 then return end

local function move_saw(saw)
	local saw_x = EntityGetTransform(saw) -- Get the current position of the saw

	-- Calculate new x-position based on the direction
	local new_x = saw_x + 0.05 * (x - saw_x) * direction

	-- Apply the new position to the saw
	EntityApplyTransform(saw, new_x, saw_y)
	EntityLoad("mods/spell_synthesis/files/entities/saw_puzzle/disc_fake_explosion.xml", new_x, saw_y)

	-- Calculate the distance from the center
	local distance = math.abs(x - new_x)

	-- Update direction based on distance thresholds
	if direction == 1 and distance < 5 then
		SetValueInteger("direction", -1)
	elseif direction == -1 and distance > 15 then
		SetValueInteger("direction", 1)
	end
end

-- Get all saws within a radius of 15
local saws = EntityGetInRadiusWithTag(x, y, 30, "disc_bullet_big")

for i = 1, #saws do
	local saw = saws[i]
	if EntityGetName(saw) == "saw_puzzle_saw" then move_saw(saw) end
end

if time_past_since_start < 60 then return end

for i = 1, #saws do
	local saw = saws[i]
	local projectile_component = EntityGetFirstComponent(saw, "ProjectileComponent")
	if projectile_component then
		ComponentSetValue2(projectile_component, "lifetime", 3)
	else
		EntityKill(saw)
	end
end

GamePlaySound("mods/spell_synthesis/files/audio/bank/spell_synthesis.bank", "puzzles/solved", x, y)
CreateItemActionEntity("DISC_BULLET_BIG", x - 26, y - 21)
CreateItemActionEntity("DISC_BULLET_BIG", x + 26, y - 21)
CreateItemActionEntity("SS_FRIENDLY_PROJECTILE", x, y - 5)
AddFlagPersistent("card_unlocked_ss_friendly")

EntityKill(entity_id)
