--- @diagnostic disable: name-style-check
dofile_once("data/scripts/lib/mod_settings.lua")

local mod_id = "spell_synthesis"
local mod_prfx = mod_id .. "."

--- @class settings_translation
--- @field [string] string
local T = {}
--- @class settings_default
local D = {}
local current_language_last_frame = nil

local mod_id_hash = 0
for i = 1, #mod_id do
	local char = mod_id:sub(i, i)
	mod_id_hash = mod_id_hash + char:byte() * i
end

local gui_id = mod_id_hash * 1000
local function id()
	gui_id = gui_id + 1
	return gui_id
end

-- ###########################################
-- ############		Helpers		##############
-- ###########################################

local U = {
	whitebox = "data/debug/whitebox.png",
	empty = "data/debug/empty.png",
	offset = 0,
	max_y = 300,
	min_y = 50,
}
do -- helpers
	--- @param setting_name setting_id
	--- @param value setting_value
	function U.set_setting(setting_name, value)
		ModSettingSet(mod_prfx .. setting_name, value)
		ModSettingSetNextValue(mod_prfx .. setting_name, value, false)
	end

	--- @param setting_name setting_id
	--- @return setting_value?
	function U.get_setting(setting_name)
		return ModSettingGet(mod_prfx .. setting_name)
	end

	--- @param setting_name setting_id
	--- @return setting_value?
	function U.get_setting_next(setting_name)
		return ModSettingGetNextValue(mod_prfx .. setting_name)
	end

	--- @param array mod_settings_global|mod_settings
	--- @param gui? gui
	--- @return number
	function U.calculate_elements_offset(array, gui)
		if not gui then
			gui = GuiCreate()
			GuiStartFrame(gui)
		end
		local max_width = 10
		for _, setting in ipairs(array) do
			if setting.category_id then
				local cat_max_width = U.calculate_elements_offset(setting.settings, gui)
				max_width = math.max(max_width, cat_max_width)
			end
			if setting.ui_name then
				local name_length = GuiGetTextDimensions(gui, setting.ui_name)
				max_width = math.max(max_width, name_length)
			end
		end
		GuiDestroy(gui)
		return max_width + 3
	end

	--- @param all boolean reset all
	function U.set_default(all)
		for setting, value in pairs(D) do
			if U.get_setting(setting) == nil or all then U.set_setting(setting, value) end
		end
	end
end

-- ###########################################
-- ##########		GUI Helpers		##########
-- ###########################################

local G = {}
do -- gui helpers
	function G.button_options(gui)
		GuiOptionsAddForNextWidget(gui, GUI_OPTION.ClickCancelsDoubleClick)
		GuiOptionsAddForNextWidget(gui, GUI_OPTION.ForceFocusable)
		GuiOptionsAddForNextWidget(gui, GUI_OPTION.HandleDoubleClickAsClick)
	end

	--- @param gui gui
	--- @param hovered boolean
	function G.yellow_if_hovered(gui, hovered)
		if hovered then GuiColorSetForNextWidget(gui, 1, 1, 0.7, 1) end
	end

	--- @param gui gui
	--- @param x_pos number
	--- @param text string
	--- @param color? table
	--- @return boolean
	--- @nodiscard
	function G.button(gui, x_pos, text, color)
		GuiOptionsAddForNextWidget(gui, GUI_OPTION.Layout_NextSameLine)
		GuiText(gui, x_pos, 0, "")
		local _, _, _, x, y = GuiGetPreviousWidgetInfo(gui)
		text = "[" .. text .. "]"
		local width, height = GuiGetTextDimensions(gui, text)
		G.button_options(gui)
		GuiImageNinePiece(gui, id(), x, y, width, height, 0)
		local clicked, _, hovered = GuiGetPreviousWidgetInfo(gui)
		if color then
			local r, g, b = unpack(color)
			GuiColorSetForNextWidget(gui, r, g, b, 1)
		end
		G.yellow_if_hovered(gui, hovered)
		GuiText(gui, x_pos, 0, text)
		return clicked
	end

	--- @param setting_name setting_id
	--- @param value setting_value
	--- @param default setting_value
	function G.on_clicks(setting_name, value, default)
		if InputIsMouseButtonJustDown(1) then U.set_setting(setting_name, value) end
		if InputIsMouseButtonJustDown(2) then
			GamePlaySound("ui", "ui/button_click", 0, 0)
			U.set_setting(setting_name, default)
		end
	end

	--- @param gui gui
	--- @param setting_name setting_id
	function G.toggle_checkbox_boolean(gui, setting_name)
		local value = U.get_setting_next(setting_name)
		local text = GameTextGetTranslatedOrNot(value and "$option_on" or "$option_off")
		local _, _, _, prev_x, y, prev_w = GuiGetPreviousWidgetInfo(gui)
		local x = prev_x + prev_w + 1
		local offset_w = GuiGetTextDimensions(gui, text)

		GuiZSetForNextWidget(gui, -1)
		G.button_options(gui)
		GuiImageNinePiece(gui, id(), x, y, offset_w + 12, 10, 10, U.empty, U.empty) -- hover box
		local _, _, hovered = GuiGetPreviousWidgetInfo(gui)
		G.tooltip(gui, setting_name)

		GuiZSetForNextWidget(gui, 1)
		GuiImageNinePiece(gui, id(), x + offset_w + 3, y + 2, 6, 6) -- check box

		G.yellow_if_hovered(gui, hovered)
		GuiText(gui, 0, 0, text)

		if value then
			GuiColorSetForNextWidget(gui, 0, 0.8, 0, 1)
			GuiText(gui, 5, 0, "V")
		else
			GuiColorSetForNextWidget(gui, 0.8, 0, 0, 1)
			GuiText(gui, 5, 0, "X")
		end

		if hovered then G.on_clicks(setting_name, not value, D[setting_name]) end
	end

	--- @param gui gui
	--- @param setting mod_setting_number
	--- @return number, number
	function G.mod_setting_number(gui, setting)
		GuiLayoutBeginHorizontal(gui, 0, 0, true, 0, 0)
		GuiText(gui, mod_setting_group_x_offset, 0, setting.ui_name)
		local _, _, _, x_start, y_start = GuiGetPreviousWidgetInfo(gui)
		local w = GuiGetTextDimensions(gui, setting.ui_name)
		local value = tonumber(U.get_setting_next(setting.id)) or setting.value_default
		local multiplier = setting.value_display_multiplier or 1
		local value_new =
			GuiSlider(gui, id(), U.offset - w + 6, 0, "", value, setting.value_min, setting.value_max, setting.value_default, multiplier, " ", 64)
		GuiColorSetForNextWidget(gui, 0.81, 0.81, 0.81, 1)
		local format = setting.format or ""
		GuiText(gui, 3, 0, tostring(math.floor(value * multiplier)) .. format)
		GuiLayoutEnd(gui)
		local _, _, _, x_end, _, t_w = GuiGetPreviousWidgetInfo(gui)
		GuiImageNinePiece(gui, id(), x_start, y_start, x_end - x_start + t_w, 8, 0, U.empty, U.empty)
		G.tooltip(gui, setting.id, setting.scope)
		return value, value_new
	end

	--- @param gui gui
	--- @param setting_name setting_id
	--- @param scope? mod_setting_scopes
	function G.tooltip(gui, setting_name, scope)
		local description = T[setting_name .. "_d"]
		local value = U.get_setting_next(setting_name)
		local value_now = U.get_setting(setting_name)

		if value ~= value_now then
			if scope == MOD_SETTING_SCOPE_RUNTIME_RESTART then
				if description then
					GuiTooltip(gui, description, "$menu_modsettings_changes_restart")
				else
					GuiTooltip(gui, "$menu_modsettings_changes_restart", "")
				end
				return
			elseif scope == MOD_SETTING_SCOPE_NEW_GAME then
				if description then
					GuiTooltip(gui, description, "$menu_modsettings_changes_worldgen")
				else
					GuiTooltip(gui, "$menu_modsettings_changes_worldgen", "")
				end
				return
			end
		end

		if description then GuiTooltip(gui, description, "") end
	end
end
-- ###########################################
-- ########		Settings GUI		##########
-- ###########################################

local S = {}
do -- Settings GUI
	--- @param setting mod_setting_number
	--- @param gui gui
	function S.mod_setting_number_integer(_, gui, _, _, setting)
		local value, value_new = G.mod_setting_number(gui, setting)
		value_new = math.floor(value_new + 0.5)
		if value ~= value_new then U.set_setting(setting.id, value_new) end
	end

	function S.mod_setting_better_boolean(_, gui, _, _, setting)
		GuiOptionsAddForNextWidget(gui, GUI_OPTION.Layout_NextSameLine)
		GuiText(gui, mod_setting_group_x_offset, 0, string.format("%s:", setting.ui_name))
		G.tooltip(gui, setting.id)
		GuiLayoutBeginHorizontal(gui, U.offset, 0, true, 0, 0)
		GuiText(gui, 7, 0, "")
		G.toggle_checkbox_boolean(gui, setting.id)
		GuiLayoutEnd(gui)
	end

	function S.reset_stuff(_, gui, _, _, setting)
		local fn = U[setting.id]
		if not fn then
			GuiText(gui, mod_setting_group_x_offset, 0, "ERR")
			return
		end
		if G.button(gui, mod_setting_group_x_offset, T.reset, { 1, 0.4, 0.4 }) then fn() end
	end
end

-- ###########################################
-- ########		Translations		##########
-- ###########################################

local translations = {
	["English"] = {
		fuser_workshop = "Enable wand tinkering",
		fuser_workshop_d = "Enable wand tinkering area near spell fuser",
	},
}

local mt = {
	__index = function(t, k)
		local currentLang = GameTextGetTranslatedOrNot("$current_language")
		if currentLang == "русский(Neonomi)" or currentLang == "русский(Сообщество)" then -- compatibility with custom langs
			currentLang = "русский"
		end
		if currentLang == "自然な日本語" then currentLang = "日本語" end
		if not translations[currentLang] then currentLang = "English" end
		return translations[currentLang][k]
	end,
}
setmetatable(T, mt)

-- ###########################################
-- #########		Settings		##########
-- ###########################################

D = {
	fuser_workshop = true,
}

local function build_settings()
	--- @type mod_settings_global
	local settings = {
		{
			id = "fuser_workshop",
			ui_name = T.fuser_workshop,
			value_default = D.fuser_workshop,
			ui_fn = S.mod_setting_better_boolean,
			scope = MOD_SETTING_SCOPE_NEW_GAME,
		},
	}
	U.offset = U.calculate_elements_offset(settings)
	return settings
end

-- ###########################################
-- #############		Meh		##############
-- ###########################################

--- @param init_scope number
function ModSettingsUpdate(init_scope)
	local current_language = GameTextGetTranslatedOrNot("$current_language")
	if current_language ~= current_language_last_frame then mod_settings = build_settings() end
	current_language_last_frame = current_language
	mod_settings_update(mod_id, mod_settings, init_scope)
end

--- @return number
function ModSettingsGuiCount()
	return mod_settings_gui_count(mod_id, mod_settings)
end

--- @param gui gui
--- @param in_main_menu boolean
function ModSettingsGui(gui, in_main_menu)
	GuiIdPushString(gui, mod_prfx)
	gui_id = mod_id_hash * 1000
	mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
	GuiIdPop(gui)
end

--- @type mod_settings_global
mod_settings = build_settings()
