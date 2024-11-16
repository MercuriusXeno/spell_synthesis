--- @class ss_sprite_generator
local sprite_generator = {
	levels = {
		[2] = "mods/spell_synthesis/files/spells/evolutions/_assets/level_2.png",
		[3] = "mods/spell_synthesis/files/spells/evolutions/_assets/level_3.png",
		[4] = "mods/spell_synthesis/files/spells/evolutions/_assets/level_4.png",
		[5] = "mods/spell_synthesis/files/spells/evolutions/_assets/level_5.png",
	},
}

--- Applying colors from source to destination, should be 16x16
--- @private
--- @param image_id number
--- @param source string
function sprite_generator:copy_from_icon(image_id, source)
	local source_id = ModImageMakeEditable(source, 0, 0)
	for i = 0, 15 do
		for j = 0, 15 do
			local color_source = ModImageGetPixel(source_id, i, j)
			if self:color_has_alpha(color_source) then
				local color = self:blend_colors(color_source, ModImageGetPixel(image_id, i, j))
				ModImageSetPixel(image_id, i, j, color)
			end
		end
	end
end

---Returns true if color's alpha > 0
---@private
---@param abgr_int integer
---@return boolean
function sprite_generator:color_has_alpha(abgr_int)
	local _, _, _, alpha = self:color_abgr_split(abgr_int)
	return alpha > 0
end

---Split abgr
---@private
---@param abgr_int integer
---@return number red, number green, number blue, number alpha
function sprite_generator:color_abgr_split(abgr_int)
	local r = bit.band(abgr_int, 0xFF)
	local g = bit.band(bit.rshift(abgr_int, 8), 0xFF)
	local b = bit.band(bit.rshift(abgr_int, 16), 0xFF)
	local a = bit.band(bit.rshift(abgr_int, 24), 0xFF)

	return r, g, b, a
end

---Merge rgb
---@private
---@param r number
---@param g number
---@param b number
---@param a number
---@return integer color
function sprite_generator:color_abgr_merge(r, g, b, a)
	return bit.bor(bit.band(r, 0xFF), bit.lshift(bit.band(g, 0xFF), 8), bit.lshift(bit.band(b, 0xFF), 16), bit.lshift(bit.band(a, 0xFF), 24))
end

---Blend colors
---@private
---@param color1 integer
---@param color2 integer
---@return integer
function sprite_generator:blend_colors(color1, color2)
	-- Extract RGBA components
	local s_r, s_g, s_b, s_a = self:color_abgr_split(color1)
	local d_r, d_g, d_b, d_a = self:color_abgr_split(color2)

	-- Normalize source alpha and compute inverse alpha once
	local alpha = s_a / 255
	local inv_alpha = 1 - alpha

	-- Blend each component using direct calculations
	local r = alpha * s_r + inv_alpha * d_r
	local g = alpha * s_g + inv_alpha * d_g
	local b = alpha * s_b + inv_alpha * d_b

	-- Merge the final color with full opacity
	return self:color_abgr_merge(r, g, b, 255)
end

--- Combine two icons
--- @param icon1 string
--- @param icon2 string|integer
--- @return string path
function sprite_generator:merge_icons(icon1, icon2)
	icon2 = self.levels[icon2] or icon2

	local path1 = icon1:match("^.+/(.+)%.(.+)$")
	local path2 = icon2:match("^.+/(.+)%.(.+)$")

	local path = string.format("mods/spell_synthesis/vfs/spell_icons/%s_%s.png", path1, path2)
	if not ModImageDoesExist(path) then
		local image_id = ModImageMakeEditable(path, 16, 16)
		self:copy_from_icon(image_id, icon1)
		self:copy_from_icon(image_id, icon2)
	end
	return path
end

return sprite_generator
