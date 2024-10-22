-- Import the wezterm module
local wezterm = require 'wezterm'
-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()

-- Actual config goes here
config.colors = {}

local color_scheme_name = 'Tokyo Night (Gogh)'
local color_scheme = wezterm.color.get_builtin_schemes()[color_scheme_name]
config.color_scheme = color_scheme_name
config.window_background_opacity = 0.99

config.window_frame = {
  font = wezterm.font({ family = 'JetBrains Mono', weight = 'Bold' }),
  font_size = 11,
}
config.scrollback_lines = 10000
config.enable_scroll_bar = true
config.window_padding = {
  right = '2cell',
}
config.colors.scrollbar_thumb = color_scheme.foreground

config.audible_bell = 'Disabled'
config.visual_bell = {
  fade_in_function = 'EaseOut',
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 45,
  fade_out_duration_ms = 35,
}
config.colors.visual_bell = '#804080'

wezterm.on('update-status', function(window)
  -- Grab the utf8 character for the "powerline" left facing
  -- solid arrow.
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  -- Grab the current window's configuration, and from it the
  -- palette (this is the combination of your chosen colour scheme
  -- including any overrides).
  local color_scheme = window:effective_config().resolved_palette
  local bg = color_scheme.background
  local fg = color_scheme.foreground

  local leader = ''
  if window:leader_is_active() then
    leader = 'LEADER '
  end

  window:set_right_status(wezterm.format({
    -- First, we draw the arrow...
    { Background = { Color = 'none' } },
    { Foreground = { Color = bg } },
    { Text = SOLID_LEFT_ARROW },
    -- leader status
    { Background = { Color = bg } },
    { Foreground = { Color = 'orange' } },
    { Text = ' ' .. leader },
    -- Then we draw our text
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = wezterm.hostname() .. ' ' },
  }))
end)

-- triple-left-click selects the entire command output when clicking on any character within that region
config.mouse_bindings = {
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
    mods = 'NONE',
  },
}

config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 5000 }
config.colors.compose_cursor = 'orange'

-- Returns our config to be evaluated. We must always do this at the bottom of this file
return config
