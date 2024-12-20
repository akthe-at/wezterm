---@module "picker.assets.colorschemes.gruvbox"
---@author akthe-at
---@license GNU-GPLv3

---@class PickList
local M = {}

local color = require("utils").fn.color

M.scheme = {
  background = "#252623",
  foreground = "#F1E9D2",
  cursor_bg = "#FFF8F0",
  cursor_fg = "#0F0800",
  cursor_border = "#FFF8F0",
  selection_bg = "#5B5E5A",
  selection_fg = "#F1E9D2",
  scrollbar_thumb = "#1C1E1B",
  split = "#838781",
  ansi = {
    "#1d2021",
    "#ea6962",
    "#a9b665",
    "#d8a657",
    "#7daea3",
    "#d3869b",
    "#89b482",
    "#d4be98",
  },
  brights = {
    "#eddeb5",
    "#ea6962",
    "#a9b665",
    "#d8a657",
    "#7daea3",
    "#d3869b",
    "#89b482",
    "#d4be98",
  },
  indexed = {},
  compose_cursor = "#FF9966",
  copy_mode_active_highlight_bg = { Color = "#5B5E5A" },
  copy_mode_active_highlight_fg = { Color = "#F1E9D2" },
  copy_mode_inactive_highlight_bg = { Color = "#383B35" },
  copy_mode_inactive_highlight_fg = { Color = "#F1E9D2" },
  quick_select_label_bg = { Color = "#E75A7C" },
  quick_select_label_fg = { Color = "#F1E9D2" },
  quick_select_match_bg = { Color = "#DBB651" },
  quick_select_match_fg = { Color = "#F1E9D2" },
  visual_bell = "#383B35",
  tab_bar = {
    background = "#1C1E1B",
    inactive_tab_edge = "#3A3D37",
    active_tab = { bg_color = "#F1E9D2", fg_color = "#111210" },
    inactive_tab = { bg_color = "#3A3D37", fg_color = "#5B5E5A" },
    inactive_tab_hover = { bg_color = "#2F312C", fg_color = "#838781", italic = true },
    new_tab = { bg_color = "#5B5E5A", fg_color = "#F1E9D2" },
    new_tab_hover = { bg_color = "#838781", fg_color = "#F1E9D2", italic = false },
  },
}

function M.get()
  return { id = "gruvbox", label = "Gruvbox Material" }
end

function M.activate(Config, callback_opts)
  local theme = M.scheme
  print("Activating theme:", theme)
  color.set_scheme(Config, theme, callback_opts.id)
end

return M
