-------------------
---- AUTOSTART ----
-------------------

-- Autostart necessary processes (like notification daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("discord")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
end)
