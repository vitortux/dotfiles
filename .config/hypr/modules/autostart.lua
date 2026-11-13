-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/configuring/core/autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- hl.on("hyprland.start", function ()
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)

-- Personal configuration
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("discord")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
end)
