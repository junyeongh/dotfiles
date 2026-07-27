---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "ghostty"
local fileManager = "nautilus"
-- local menu        = "wofi --show drun"

---------------------
---- KEYBINDINGS ----
---------------------


-- https://docs.noctalia.dev/
-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
-- local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + SHIFT + E",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))

-- Windows management
hl.bind(mainMod .. " + CTRL + SHIFT + C", hl.dsp.window.close())
-- Move focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + TAB", hl.dsp.window.cycle_next())
-- Move active window
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.center())
-- Resize active window
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true, window = "activewindow" }))
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.resize({ x = 0, y = -20, relative = true, window = "activewindow" }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.resize({ x = 0, y = 20, relative = true, window = "activewindow" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true, window = "activewindow" }))
hl.bind(mainMod .. " + ALT + C", function()
  local active_window = hl.get_active_window()
  if active_window == nil or active_window.floating then
    hl.dispatch(hl.dsp.window.float({
      action = "disable",
      window = "activewindow",
    }))
  else
    local active_monitor = hl.get_active_monitor()
    if active_monitor == nil then
      return
    end

    hl.dispatch(hl.dsp.window.float({
      action = "enable",
      window = "activewindow",
    }))
    hl.dispatch(hl.dsp.window.resize({
      x        = (active_monitor.width / active_monitor.scale) * 0.8,
      y        = (active_monitor.height / active_monitor.scale) * 0.8,
      relative = false,
      window   = "activewindow",
    }))
    hl.dispatch(hl.dsp.window.center({
      window = "activewindow",
    }))
  end
end)
-- Window states
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + SHIFT + X", function()
  if hl.get_workspace("special:minimized") then
    hl.dispatch(hl.dsp.window.move({ workspace = hl.get_active_workspace(), window = "tag:minimized" }))
    hl.dispatch(hl.dsp.window.clear_tags({ window = "tag:minimized" }))
  else
    hl.dispatch(hl.dsp.window.tag({ tag = "minimized", window = hl.get_active_window() }))
    hl.dispatch(hl.dsp.window.move({ workspace = "special:minimized", follow = false }))
  end
end)

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })

-- Move between workspaces
hl.bind(mainMod .. " + CTRL + Left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + H", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + Right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.focus({ workspace = "e+1" }))
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  -- Switch workspaces with mainMod + [0-9]
  hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.focus({ workspace = i }))
  -- Move active window to a workspace with mainMod + SHIFT + [0-9]
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- noctalia - Core binds
local ipc = "noctalia-shell msg "
hl.bind(mainMod .. " + Comma", hl.dsp.exec_cmd(ipc .. "settings toggle"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(ipc .. "controlCenter toggle"))

hl.bind(mainMod .. " + Semicolon", hl.dsp.exec_cmd(ipc .. "launcher windows"))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(ipc .. "launcher toggle"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(ipc .. "launcher clipboard"))

hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.exec_cmd(ipc .. "lockScreen lock"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume increase"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume decrease"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume muteOutput"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(ipc .. "volume muteInput"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness increase"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness decrease"), { locked = true, repeating = true })

-- Custom binds
local function toggle_special_or_launch_fire(name)
  return function()
    hl.dispatch(hl.dsp.workspace.toggle_special(name))
    local windows = hl.get_windows({ workspace = "special:" .. name })
    if #windows == 0 then
      hl.dispatch(hl.dsp.exec_cmd(name, { workspace = "special:" .. name }))
    end
  end
end
hl.bind("ALT + X", toggle_special_or_launch_fire("ferdium"))
hl.bind("ALT + H", toggle_special_or_launch_fire("heynote"))
-- hl.bind("ALT + H", hl.dsp.workspace.toggle_special("heynote"))
hl.bind("CTRL + ALT + SPACE", hl.dsp.exec_cmd("1password --quick-access"))
