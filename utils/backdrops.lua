local wezterm = require "wezterm"

local Utils = require "utils"

local GLOB_PATTERN = "*.{jpg,jpeg,png,gif,bmp,ico,tiff,pnm,dds,tga}"

local fs = Utils.fn.fs
local color = Utils.fn.color
local Config = {}

Config.color_schemes = color.get_schemes()
Config.color_scheme = color.get_scheme()

local theme = Config.color_schemes[Config.color_scheme]
-- Seeding random numbers before generating for use
-- Known issue with lua math library
-- see: https://stackoverflow.com/questions/20154991/generating-uniform-random-numbers-in-lua
math.randomseed(os.time())
math.random()
math.random()
math.random()

---@class BackDrops
---@field current_idx number index of current image
---@field files string[] background images
---@field focus_color string background color when in focus mode
---@field focus_on boolean focus mode on or off
local BackDrops = {}
BackDrops.__index = BackDrops

--- Initialise backdrop controller
---@private
function BackDrops:init()
  local inital = {
    current_idx = 1,
    files = {},
    focus_color = theme.background,
    focus_on = false,
  }
  local backdrops = setmetatable(inital, self)
  -- G.background = nil
  return backdrops
end

---MUST BE RUN BEFORE ALL OTHER `BackDrops` functions
---Sets the `files` after instantiating `BackDrops`.
---
--- INFO:
---   During the initial load of the config, this function can only invoked in `wezterm.lua`.
---   WezTerm's fs utility `read_dir` (used in this function) works by running on a spawned child process.
---   This throws a coroutine error if the function is invoked in outside of `wezterm.lua` in the -
---   initial load of the Terminal config.
function BackDrops:set_files()
  self.files = wezterm.glob(wezterm.config_dir .. "/backdrops/" .. GLOB_PATTERN)
  return self
end
--   local path = wezterm.config_dir .. fs.path_separator .. "backdrops"
--   print("Reading directory: " .. path)
--   self.files = wezterm.read_dir(path)
--   if not self.files then
--     error("Failed to read directory: " .. path)
--   end
--   G.background = self.files[1]
--   return self
-- end

---Set the focus color for the background
---@param focus_color string background color when in focus mode
function BackDrops:set_focus(focus_color)
  self.focus_color = focus_color
  return self
end

---Override the current window options for background
---@private
---@param window any WezTerm Window see: https://wezfurlong.org/wezterm/config/lua/window/index.html
function BackDrops:_set_opt(window)
  local opts = {
    background = {
      {
        source = { File = wezterm.GLOBAL.background },
        horizontal_align = "Center",
      },
      {
        source = { Color = theme.background },
        height = "120%",
        width = "120%",
        vertical_offset = "-10%",
        horizontal_ofset = "-10%",
        opacity = 0.96,
      },
    },
  }
  window:set_config_overrides(opts)
end

---Override the current window options for background with focus color
---@private
---@param window any WezTerm Window see: https://wezfurlong.org/wezterm/config/lua/window/index.html
function BackDrops:_set_focus_opt(window)
  local opts = {
    background = {
      {
        source = { Color = self.focus_color },
        height = "120%",
        width = "120%",
        vertical_offset = "-10%",
        horizontal_offset = "-10%",
        opacity = 1,
      },
    },
  }
  window:set_config_overrides(opts)
end

---Convert the `files` array to a table of `InputSelector` choices
---see: https://wezfurlong.org/wezterm/config/lua/keyassignment/InputSelector.html
function BackDrops:choices()
  local choices = {}
  for idx, file in ipairs(self.files) do
    local name = file:match("([^" .. PATH_SEP .. "]+)$")
    table.insert(choices, {
      id = tostring(idx),
      label = name,
    })
  end
  return choices
end

---Select a random file and redefine the global `wezterm.GLOBAL.background` variable
---Pass in `Window` object to override the current window options
---@param window any? WezTerm `Window` see: https://wezfurlong.org/wezterm/config/lua/window/index.html
function BackDrops:random(window)
  self.current_idx = math.random(#self.files)
  wezterm.GLOBAL.background = self.files[self.current_idx]

  if window ~= nil then
    self:_set_opt(window)
  end
end

---Cycle the loaded `files` and select the next background
---@param window any WezTerm `Window` see: https://wezfurlong.org/wezterm/config/lua/window/index.html
function BackDrops:cycle_forward(window)
  if self.current_idx == #self.files then
    self.current_idx = 1
  else
    self.current_idx = self.current_idx + 1
  end
  wezterm.GLOBAL.background = self.files[self.current_idx]
  self:_set_opt(window)
end

---Cycle the loaded `files` and select the previous background
---@param window any WezTerm `Window` see: https://wezfurlong.org/wezterm/config/lua/window/index.html
function BackDrops:cycle_back(window)
  if self.current_idx == 1 then
    self.current_idx = #self.files
  else
    self.current_idx = self.current_idx - 1
  end
  wezterm.GLOBAL.background = self.files[self.current_idx]
  self:_set_opt(window)
end

---Set a specific background from the `files` array
---@param window any WezTerm `Window` see: https://wezfurlong.org/wezterm/config/lua/window/index.html
---@param idx number index of the `files` array
function BackDrops:set_img(window, idx)
  if idx > #self.files or idx < 0 then
    wezterm.log_error "Index out of range"
    return
  end

  self.current_idx = idx
  wezterm.GLOBAL.background = self.files[self.current_idx]
  self:_set_opt(window)
end

---Toggle the focus mode
---@param window any WezTerm `Window` see: https://wezfurlong.org/wezterm/config/lua/window/index.html
function BackDrops:toggle_focus(window)
  if self.focus_on then
    self:set_img(window, self.current_idx)
    self.focus_on = false
  else
    self:_set_focus_opt(window)
    self.focus_on = true
  end
end

return BackDrops:init()
