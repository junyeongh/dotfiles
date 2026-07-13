--------------------------------
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

-- Custom window rules for specific applications
hl.window_rule({
    name = "floating apps at right",
    match = { class = "^(Heynote)$" },

    float = true,
    size = { "monitor_w / 3", "monitor_h * 0.8" },
    move = { "monitor_w * 2 / 3", "monitor_h * 0.1" }
})
hl.window_rule({
    name = "floating apps at center",
    match = { class = "^(1password|Ferdium|obsidian|Spotify)$" },

    float = true,
    center = true,
    size = { "monitor_w * 0.75", "monitor_h * 0.75" }
})
