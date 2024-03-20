--

--
local main = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#ebbcba",
  mauve = "#cba6f7",
  red = "#eb6f92",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f6c177",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#31748f",
  blue = "#9ccfd8",
  lavender = "#c4a7e7",
  text = "#e0def4",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay = "#26233a",
  surface2 = "#585b70",
  surface1 = "#6e6a86",
  surface = "#1f1d2e",
  base = "#191724",
  mantle = "#181825",
  crust = "#11111b",
}

local colorscheme = {
  foreground = main.text,
  background = main.base,
  cursor_bg = main.rosewater,
  cursor_border = main.maroon,
  cursor_fg = main.crust,
  selection_bg = main.surface2,
  selection_fg = main.text,
  ansi = {
    "#0C0C0C", --
    "#C50F1F", --
    "#13A10E", --
    "#C19C00", --
    "#c4a7e7", --
    "#881798", --
    "#3A96DD", --
    "#CCCCCC", --
  },
  brights = {
    "#bac2de", --
    "#E74856", --
    "#16C60C", --
    "#F9F1A5", --
    "#9ccfd8", --
    "#B4009E", --
    "#61D6D6", --
    "#F2F2F2", --
  },
  tab_bar = {
    background = "#000000",
    active_tab = {
      bg_color = main.blue,
      fg_color = main.text,
    },
    inactive_tab = {
      bg_color = main.rosewater,
      fg_color = "#181820",
    },

    inactive_tab_hover = {
      bg_color = main.sky,
      fg_color = "#727169",
      italic = false,
    },
    new_tab = {
      bg_color = "#727169",
      fg_color = "#000000",
    },
    new_tab_hover = {
      bg_color = main.surface2,
      fg_color = "#000000",
      italic = true,
    },
  },
  visual_bell = main.surface0,
  indexed = {
    [16] = main.peach,
    [17] = main.rosewater,
  },
  scrollbar_thumb = main.surface2,
  split = main.overlay0,
  compose_cursor = main.flamingo, -- nightbuild only
  copy_mode_active_highlight_bg = { Color = "#223249" },
  copy_mode_active_highlight_fg = { Color = "#DCD7BA" },
  copy_mode_inactive_highlight_bg = { Color = "#C8C093" },
  copy_mode_inactive_highlight_fg = { Color = "#16161D" },

  quick_select_label_bg = { Color = "#FF5D62" },
  quick_select_label_fg = { Color = "#DCD7BA" },
  quick_select_match_bg = { Color = "#FF9E3B" },
  quick_select_match_fg = { Color = "#DCD7BA" },
}

return colorscheme

