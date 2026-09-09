------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful
hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name           = "suppress-maximize-events",
  match          = { class = ".*" },

  suppress_event = "maximize",
})
hl.window_rule({
  -- Fix some dragging issues with XWayland
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})
-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,
})

-- Build a "^(a|b|c)$" class-match regex from a plain list of class names,
-- escaping literal dots so they aren't treated as regex wildcards.
local function match_regex(classes)
  local escaped = {}
  for i, class in ipairs(classes) do
    escaped[i] = class:gsub("%.", "\\.")
  end
  return "^(" .. table.concat(escaped, "|") .. ")$"
end
-- Custom window rules for specific applications
hl.window_rule({
  name = "floating apps match by class at right",
  match = {
    class = match_regex({
      "Heynote",
      "org.pwmt.zathura"
    }),
    workspace = "w[1-99]s[false]"
  },

  float = true,
  size = { "monitor_w / 3", "monitor_h * 0.8" },
  move = { "monitor_w * 2 / 3", "monitor_h * 0.1" }
})
hl.window_rule({
  name = "floating apps match by initialTitle at right",
  match = {
    initial_title = match_regex({
      "KakaoTalk"
    }),
    workspace = "w[1-99]s[false]"
  },

  float = true,
  -- size = { "monitor_w / 3", "monitor_h * 0.8" },
  move = { "monitor_w * 2 / 3", "monitor_h * 0.1" }
})
hl.window_rule({
  name = "floating apps match by class at center on occupied workspace",
  match = {
    class = match_regex({
      "1password",
      "Ferdium",
      "Spotify",
      "com.mitchellh.ghostty",
      "obsidian",
      "org.gnome.Nautilus",
      "solaar",
      "com.gabm.satty",
    }),
    workspace = "w[1-99]s[false]"
  },

  float = true,
  center = true,
  size = { "monitor_w * 0.80", "monitor_h * 0.80" }
})
hl.window_rule({
  name = "floating apps match by initialTitle at center on occupied workspace",
  match = {
    initial_title = match_regex({
      "kime-candidate"
    }),
    workspace = "w[1-99]s[false]"
  },

  float = true,
  -- size = { "monitor_w / 3", "monitor_h * 0.8" },
  move = { "monitor_w * 2 / 3", "monitor_h * 0.1" }
})
