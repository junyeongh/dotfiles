require("appearances")
require("inputs")
require("keybindings")
require("window_rules")
require("workspace_rules")

------------------
---- MONITORS ----
------------------

-- https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})

-------------------
---- AUTOSTART ----
-------------------

-- https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("kime")
    hl.exec_cmd("dropbox start")
    hl.exec_cmd("1password --silent")
    hl.exec_cmd("solaar --window hidden")
    hl.exec_cmd("kanata")
    hl.exec_cmd("noctalia-shell")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("GTK_IM_MODULE", "kime")
hl.env("QT_IM_MODULE", "kime")
hl.env("XMODIFIERS", "@im=kime")

-----------------------
----- PERMISSIONS -----
-----------------------

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
    ecosystem = {
        no_update_news = true,
    },
})
