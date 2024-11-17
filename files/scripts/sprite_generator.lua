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

--- Blend colors
--- @private
--- @param color1 integer  -- Source color
--- @param color2 integer  -- Destination color
--- @return integer  -- Resulting blended color
function sprite_generator:blend_colors(color1, color2)
	-- Extract RGBA components
	local s_r, s_g, s_b, s_a = self:color_abgr_split(color1)
	local d_r, d_g, d_b, d_a = self:color_abgr_split(color2)

	-- Normalize alpha values
	local src_alpha = s_a / 255
	local dst_alpha = d_a / 255

	-- Compute final alpha and avoid division by zero
	local out_alpha = src_alpha + dst_alpha * (1 - src_alpha)
	if out_alpha == 0 then
		return self:color_abgr_merge(0, 0, 0, 0)
	end

	-- Blend RGB components
	local r = (s_r * src_alpha + d_r * dst_alpha * (1 - src_alpha)) / out_alpha
	local g = (s_g * src_alpha + d_g * dst_alpha * (1 - src_alpha)) / out_alpha
	local b = (s_b * src_alpha + d_b * dst_alpha * (1 - src_alpha)) / out_alpha

	-- Convert blended alpha back to 0-255 range
	local final_alpha = out_alpha * 255

	-- Merge and return the resulting color
	return self:color_abgr_merge(r, g, b, final_alpha)
end

--- Combine two icons
--- @param icon1 string
--- @param level integer
--- @return string path
function sprite_generator:add_level_glow(icon1, level)
	local path1 = icon1:match("^.+/(.+)%.(.+)$")

	local path = string.format("mods/spell_synthesis/vfs/spell_icons/%s_%d.png", path1, level)
	if not ModImageDoesExist(path) then
		local image_id = ModImageMakeEditable(path, 16, 16)
		self:copy_from_icon(image_id, icon1)
		self:copy_from_icon(image_id, self.levels[level])
	end
	return path
end

--- Combine two icons
--- @param icon1 string
--- @param icon2 string
--- @return string path
function sprite_generator:add_overlay_to_icon(icon1, icon2)
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
