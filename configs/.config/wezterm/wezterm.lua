local wezterm = require("wezterm")

local config = {
    enable_wayland = true,

    -- color_scheme = 'GitHub Dark',
    -- Dimidium - https://github.com/dofuuz/dimidium
    colors = {
        foreground = "#bab7b6",
        background = "#141414",
        cursor_bg = "#37e57b",
        cursor_border = "#37e57b",
        cursor_fg = "#141414",
        selection_bg = "#8db8e5",
        selection_fg = "#141414",

        ansi = {"#000000", "#cf494c", "#60b442", "#db9c11", "#0575d8", "#af5ed2", "#1db6bb", "#bab7b6"},
        brights = {"#817e7e", "#ff643b", "#37e57b", "#fccd1a", "#688dfd", "#ed6fe9", "#32e0fb", "#d3d8d9"}
    },

    font = wezterm.font("FiraCode Nerd Font"),
    initial_cols = 120,
    initial_rows = 36,

    window_decorations = "INTEGRATED_BUTTONS|RESIZE"
}

return config
