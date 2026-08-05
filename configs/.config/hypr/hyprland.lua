require("configs")

-------------------
---- AUTOSTART ----
-------------------

-- https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia-shell")

  hl.timer(function()
    hl.exec_cmd("kime --no-daemon")
    hl.exec_cmd("dropbox start")
    hl.exec_cmd("1password --silent")
    hl.exec_cmd("solaar --window hide")
    hl.exec_cmd("kanata")
    hl.exec_cmd("xembedsniproxy", { workspace = "special:xembedsniproxy" })
  end, { timeout = 250, type = "oneshot" })

  hl.timer(function()
    hl.exec_cmd("bottles-cli run -b Kakaotalk -p KakaoTalk")
    hl.exec_cmd("ferdium", { workspace = "special:ferdium" })
    hl.exec_cmd("heynote", { workspace = "special:heynote" })
  end, { timeout = 500, type = "oneshot" })
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
-- Please note permission changes here require a Hyprland restart
-- and are not applied on-the-fly for security reasons

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
