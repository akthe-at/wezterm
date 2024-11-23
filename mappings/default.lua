---@module "mappings.default"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable-next-line: undefined-field
local act = require("wezterm").action
local key = require("utils.fn").key
local backdrops = require "utils.backdrops"
local sessionizer = require "sessionizer"
local wezterm = require "wezterm"
local workspace_switcher =
  wezterm.plugin.require "https://github.com/MLFlexer/smart_workspace_switcher.wezterm"
workspace_switcher.workspace_formatter = function(label)
  return wezterm.format {
    { Attribute = { Italic = true } },
    { Foreground = { Color = "green" } },
    { Background = { Color = "black" } },
    { Text = "󱂬: " .. label },
  }
end
-- local resurrect = wezterm.plugin.require "https://github.com/MLFlexer/resurrect.wezterm"
-- resurrect.save_state_dir = "C:\\Users\\aktheat\\.config\\wezterm\\state\\"
-- resurrect.periodic_save {
--   interval_seconds = 600,
--   save_tabs = true,
--   save_windows = true,
--   save_workspaces = true,
-- }
--
-- resurrect.set_max_nlines(5000)

local Config = {}

Config.disable_default_key_bindings = true
Config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

local mappings = {
  -- Tabs
  { "<M-[>", act.ActivateTabRelative(1), "" },
  { "<M-}>", act.ActivateTabRelative(-1), "" },
  { "<C-M-[>", act.MoveTabRelative(1), "" },
  { "<C-M-]>", act.MoveTabRelative(-1), "" },
  { "<leader>F4", act.ShowLauncherArgs { flags = "FUZZY|TABS" }, "" },
  { "<C-S-t>", act.SpawnTab "CurrentPaneDomain", "" },
  {
    "<leader>r",
    act.PromptInputLine {
      description = "Enter new name for Tab",
      ---@diagnostic disable-next-line: undefined-field
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
    "Rename Tab",
  },
  { "<leader>W", act.CloseCurrentTab { confirm = true }, "" },
  {
    "<C-S-u>",
    act.CharSelect {
      copy_on_select = true,
      copy_to = "ClipboardAndPrimarySelection",
    },
    "",
  },
  -- Panes
  { "<leader>z", act.TogglePaneZoomState, "Zoom Pane" },
  { "<leader>[", act.PaneSelect { mode = "SwapWithActiveKeepFocus" }, "Swap Panes" },
  { "<leader>w", act.CloseCurrentPane { confirm = true }, "close tab" },
  { "<PageUp>", act.ScrollByPage(-1), "" },
  { "<PageDown>", act.ScrollByPage(1), "" },
  ---quick split and nav
  { "<leader>\\", act.SplitHorizontal { domain = "CurrentPaneDomain" }, "vsplit" },
  { "<leader>-", act.SplitVertical { domain = "CurrentPaneDomain" }, "hsplit" },
  { "<leader>h", act.ActivatePaneDirection "Left", "move left" },
  { "<leader>j", act.ActivatePaneDirection "Down", "move down" },
  { "<leader>k", act.ActivatePaneDirection "Up", "move up" },
  { "<leader>l", act.ActivatePaneDirection "Right", "move right" },
  -- Attach/Detach Domains
  { "<leader>a", act.AttachDomain "SSHMUX:localhost", "Attach to WSL/SSH Domain" },
  {
    "<leader>d",
    act.DetachDomain { DomainName = "SSHMUX:localhost" },
    "Detach from the WSL/SSH Domain",
  },
  --- Modes
  { "<leader>c", act.ActivateCopyMode, "copy mode" },
  -- { "<leader>s", act.Search "CurrentSelectionOrEmptyString", "search mode" },
  --- Workspaces
  { "<leader>F5", act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" }, "" },
  -- Navigate Workspace
  { "<leader>n", act.SwitchWorkspaceRelative(1), "" },
  { "<leader>p", act.SwitchWorkspaceRelative(-1), "" },
  { "<leader>q", workspace_switcher.switch_workspace(), "switch workspace" },
  {
    "<leader>Q",
    workspace_switcher.switch_to_prev_workspace(),
    "switch to prev workspace",
  },
  -- Wezterm Resurrect
  -- {
  --   "<leader>S",
  --   ---@diagnostic disable-next-line: undefined-field
  --   wezterm.action_callback(function(_, _)
  --     local state = resurrect.workspace_state.get_workspace_state()
  --     resurrect.save_state(state)
  --     resurrect.window_state.save_window_action()
  --   end),
  --   "Save Workspace State - Resurrect",
  -- },
  -- {
  --   "<leader>O",
  --   ---@diagnostic disable-next-line: undefined-field
  --   wezterm.action_callback(function(win, pane)
  --     resurrect.fuzzy_load(win, pane, function(id, label) -- luacheck: ignore 212
  --       local type = string.match(id, "^([^/]+)") -- match before '/'
  --       id = string.match(id, "([^/]+)$") -- match after '/'
  --       id = string.match(id, "(.+)%..+$") -- remove file extension
  --
  --       local opts = {
  --         window = win:mux_window(),
  --         relative = true,
  --         restore_text = true,
  --         on_pane_restore = resurrect.tab_state.default_on_pane_restore,
  --       }
  --
  --       if type == "workspace" then
  --         local state = resurrect.load_state(id, "workspace")
  --         resurrect.workspace_state.restore_workspace(state, opts)
  --       elseif type == "window" then
  --         local state = resurrect.load_state(id, "window")
  --         -- opts.tab = win:active_tab()
  --         resurrect.window_state.restore_window(pane:window(), state, opts)
  --       elseif type == "tab" then
  --         local state = resurrect.load_state(id, "tab")
  --         resurrect.tab_state.restore_tab(pane:tab(), state, opts)
  --       end
  --     end)
  --   end),
  -- },
  -- {
  --   "<leader>T",
  --   resurrect.tab_state.save_tab_action(),
  --   "Save Tab State - Resurrect",
  -- },
  -- {
  --   "<leader>I",
  --   ---@diagnostic disable-next-line: undefined-field
  --   wezterm.action_callback(function(win, pane)
  --     resurrect.save_state(resurrect.workspace_state.get_workspace_state())
  --     resurrect.window_state.save_window_action()
  --   end),
  --   "Save All? State - Resurrect",
  -- },
  -- {
  --   "<leader>P",
  --   ---@diagnostic disable-next-line: undefined-field
  --   wezterm.action_callback(function(win, pane)
  --     resurrect.fuzzy_load(win, pane, function(id, label)
  --       local type = string.match(id, "^([^/]+)") -- match before '/'
  --       id = string.match(id, "([^/]+)$") -- match after '/'
  --       id = string.match(id, "(.+)%..+$") -- remove file extention
  --       local opts = {
  --         relative = true,
  --         restore_text = true,
  --         on_pane_restore = resurrect.tab_state.default_on_pane_restore,
  --       }
  --       if type == "workspace" then
  --         local state = resurrect.load_state(id, "workspace")
  --         resurrect.workspace_state.restore_workspace(state, opts)
  --       elseif type == "window" then
  --         local state = resurrect.load_state(id, "window")
  --         resurrect.window_state.restore_window(pane:window(), state, opts)
  --       elseif type == "tab" then
  --         local state = resurrect.load_state(id, "tab")
  --         resurrect.tab_state.restore_tab(pane:tab(), state, opts)
  --       end
  --     end)
  --   end),
  -- },
  -- {
  --   "<leader>D",
  --   ---@diagnostic disable-next-line: undefined-field
  --   wezterm.action_callback(function(win, pane)
  --     resurrect.fuzzy_load(win, pane, function(id)
  --       resurrect.delete_state(id)
  --     end, {
  --       title = "Delete State",
  --       description = "Select session to delete and press Enter = accept, Esc = cancel, / = filter",
  --       fuzzy_description = "Search session to delete: ",
  --       is_fuzzy = true,
  --     })
  --   end),
  -- },
  --Rename Workspace
  {
    "<leader>R",
    act.PromptInputLine {
      description = "Enter new name for workspace",
      ---@diagnostic disable-next-line: undefined-field
      action = wezterm.action_callback(function(_, _, line)
        if line then
          ---@diagnostic disable-next-line: undefined-field
          wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
        end
      end),
    },
    "Rename Workspace",
  },
  ---@diagnostic disable-next-line: undefined-field
  { "<leader>m", wezterm.action_callback(sessionizer.start), "" },
  -- -Custom Backdrops---
  {
    "<leader>b",
    ---@diagnostic disable-next-line: undefined-field
    wezterm.action_callback(function(window, _)
      backdrops:toggle_focus(window)
    end),
  },
  {
    "<M-/>",
    ---@diagnostic disable-next-line: undefined-field
    wezterm.action_callback(function(window, _)
      backdrops:random(window)
    end),
    "",
  },
  {
    "<leader>/",
    act.InputSelector {
      title = "Select Background",
      choices = backdrops:choices(),
      fuzzy = true,
      fuzzy_description = "Select Background: ",
      ---@diagnostic disable-next-line: undefined-field
      action = wezterm.action_callback(function(window, _, idx)
        ---@diagnostic disable-next-line: param-type-mismatch
        backdrops:set_img(window, tonumber(idx))
      end),
    },
    "",
  },
  { "<F12>", act.ShowDebugOverlay, "" },
  { "<M-\\>", act.ToggleFullScreen, "" },
  { "<C-S-Insert>", act.PasteFrom "PrimarySelection", "" },
  { "<C-Insert>", act.CopyTo "PrimarySelection", "" },
  { "<C-S-Space>", act.QuickSelect, "quick select" },
  { "<C-S-c>", act.CopyTo "Clipboard", "" },
  { "<C-S-v>", act.PasteFrom "Clipboard", "" },
  { "<C-S-f>", act.Search "CurrentSelectionOrEmptyString", "" },
  { "<leader>K", act.ClearScrollback "ScrollbackOnly", "" },
  { "<C-S-n>", act.SpawnWindow, "" },
  { "<C-S-p>", act.ActivateCommandPalette, "" },
  { "<C-S-r>", act.ReloadConfiguration, "" },
  --- open picker
  { "<leader>t", act.ActivateKeyTable { name = "pick_mode" }, "pick mode" },
  -- Open Wezterm Config Directly
  {
    "<leader>,",
    ---@diagnostic disable-next-line: undefined-field
    wezterm.action.SpawnCommandInNewTab {
      cwd = os.getenv "WEZTERM_CONFIG_DIR",
      args = {
        "nvim",
      },
    },
  },
}

for i = 1, 9 do
  mappings[#mappings + 1] =
    { "<leader>" .. i, act.ActivateTab(i - 1), "activate tab " .. i }
end

Config.keys = {}
for _, map_tbl in pairs(mappings) do
  key.map(map_tbl[1], map_tbl[2], Config.keys)
end

return Config
