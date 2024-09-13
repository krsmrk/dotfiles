-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- Table to hold the configuration
local config = {}

-- Use config_builder for clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Configure

config.font =
	wezterm.font_with_fallback {
		{ family = 'Iosevka Skiouros Nerd Font Mono', weight = 'Medium', italic = false },
		-- Icons are way too large with this setting:
		-- { family = 'Iosevka Skiouros', weight = 'Medium', italic = false, },
		-- { family = 'Symbols Nerd Fond Mono', },
	}

-- config.use_cap_height_to_scale_fallback_fonts = true
config.font_size = 14

config.color_scheme = 'nordfox'
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.window_decorations = "TITLE | RESIZE"

-- Return the configuration to wezterm
return config
