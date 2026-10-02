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

-- Make xembedsniproxy's XEmbed icon containers (e.g., KakaoTalk tray icon via Bottles) invisible.
-- They can't be moved away: xembedsniproxy repositions them on every tray click, pulling them back.
-- Same matcher as fix-xwayland-drags
hl.window_rule({
  name        = "hide-xembedsniproxy-containers",
  match       = {
    class    = "^$",
    title    = "^$",
    xwayland = true,
  },

  opacity     = "0.0 override",
  border_size = 0,
  no_shadow   = true,
  no_blur     = true,
  no_anim     = true,
})
-- Wine/Proton tray context menus (e.g., KakaoTalk) open at xembedsniproxy's container
-- position instead of the tray icon; move them under the cursor instead.
hl.window_rule({
  name  = "move-proton-tray-menus-to-cursor",
  match = {
    class = "^steam_proton$",
    title = "^$",
    float = true,
  },

  move  = { "cursor_x - (window_w * 0.5)", "cursor_y" },
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
      "com.gabm.satty",
      "com.mitchellh.ghostty",
      "ferdium",
      "md.obsidian.Obsidian",
      "org.gnome.Nautilus",
      "solaar",
      "spotify",
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
