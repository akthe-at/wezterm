-- ~.config/wezterm/sessionizer.lua

local wezterm = require "wezterm"
local act = wezterm.action

local M = {}

local fd =
  "C:/Users/ARK010/AppData/Local/Microsoft/WinGet/Packages/sharkdp.fd_Microsoft.Winget.Source_8wekyb3d8bbwe/fd-v8.7.1-x86_64-pc-windows-msvc/fd.exe"
local rootPath = wezterm.home_dir .. "/Documents"

M.toggle = function(window, pane)
  local projects = {}

  local success, stdout, stderr = wezterm.run_child_process {
    fd,
    "-H",
    "-I",
    "-td",
    "--max-depth=3",
    "^.git$",
    rootPath,
  }

  if not success then
    wezterm.log_error("Failed to run fd: " .. stderr)
    return
  end

  for line in stdout:gmatch "([^\n]*)\n?" do
    local project = line:gsub("\\.git\\$", "")
    local label = project
    local id = project:gsub(".*\\", "")

    --handle git bare repo
    if string.match(project, "%.git\\$") then
      wezterm.log_info("found .git " .. tostring(project))
      local success, stdout, stderr = wezterm.run_child_process {
        fd,
        "-H",
        "-I",
        "-td",
        "--max-depth=3",
        ".",
        project .. "\\worktrees\\",
      }
      if success then
        for wt_line in stdout:gmatch "([^\n]*)\n?" do
          local wt_project = wt_line:gsub("\\", "/")
          local wt_label = wt_project
          local wt_id = wt_project
          table.insert(projects, { label = tostring(wt_label), id = tostring(wt_id) })
        end
      else
        wezterm.log_error("Failed to run fd: " .. stderr)
      end
    end

    table.insert(projects, { label = tostring(label), id = tostring(id) })
  end

  window:perform_action(
    act.InputSelector {
      action = wezterm.action_callback(function(win, _, id, label)
        if not id and not label then
          wezterm.log_info "Cancelled"
        else
          wezterm.log_info("Selected " .. label)
          win:perform_action(
            act.SwitchToWorkspace { name = id, spawn = { cwd = label } },
            pane
          )
        end
      end),
      fuzzy = true,
      title = "Select project",
      choices = projects,
    },
    pane
  )
end

return M

