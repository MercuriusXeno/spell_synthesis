local entity = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity)

LoadPixelScene(
	"mods/spell_synthesis/files/entities/fuser/pixelscene/fuser.png",
	"mods/spell_synthesis/files/entities/fuser/pixelscene/fuser_visual.png",
	x - 35,
	y - 19
)
