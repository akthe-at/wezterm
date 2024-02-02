---@class WezTerm
local wez = require "wezterm"

local icons = require "utils.icons" ---@class Icons
local fun = require "utils.fun" ---@class Fun

---@class Config
local Config = {}

Config.default_prog = { "pwsh" }

Config.launch_menu = {
  {
    label = icons.Pwsh .. " PowerShell V7",
    args = {
      "pwsh",
      "-NoLogo",
      "-ExecutionPolicy",
      "RemoteSigned",
      "-NoProfileLoadTime",
    },
    cwd = "~",
  },
  { label = icons.Git .. " Git bash", args = { "sh", "-l" }, cwd = "~" },
  { label = "Command Prompt", args = { "cmd.exe" }, cwd = "~" },
}

-- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
Config.wsl_domains = {}

Config.default_cwd = fun.home

-- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
Config.ssh_domains = {}

-- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
Config.unix_domains = {}

return Config

