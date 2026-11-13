---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
return function(programs)
    local main_mod = "SUPER"

    ---------------------------------------------------------------------------
    -- Base binds: terminal, window controls, navigation, workspaces and media.
    ---------------------------------------------------------------------------
    hl.bind(main_mod .. " + Q", hl.dsp.exec_cmd(programs.terminal))
    hl.bind(main_mod .. " + C", hl.dsp.window.close())
    hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
    hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
    hl.bind(main_mod .. " + P", hl.dsp.window.pseudo())
    hl.bind(main_mod .. " + J", hl.dsp.layout("togglesplit"))

    for _, direction in ipairs({ "left", "right", "up", "down" }) do
        local short_direction = ({ left = "l", right = "r", up = "u", down = "d" })[direction]
        hl.bind(main_mod .. " + " .. direction, hl.dsp.focus({ direction = short_direction }))
    end

    for workspace = 1, 10 do
        local key = tostring(workspace % 10)
        hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
        hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
    end

    hl.bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
    hl.bind(main_mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
    hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

    hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
    hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    local repeating_locked = { locked = true, repeating = true }
    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), repeating_locked)
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), repeating_locked)
    hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), repeating_locked)
    hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), repeating_locked)
    hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), repeating_locked)
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), repeating_locked)

    local locked = { locked = true }
    hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), locked)
    hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), locked)
    hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), locked)
    hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), locked)

    ---------------------------------------------------------------------------
    -- Personal additions and overrides.
    ---------------------------------------------------------------------------

    -- Custom shutdown fallback instead of the template's direct exit action.
    hl.bind(
        main_mod .. " + M",
        hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit")
    )

    -- Rofi launcher on Super+Space (the template uses Super+R).
    hl.bind(main_mod .. " + SPACE", hl.dsp.exec_cmd(programs.menu .. " -show drun -show-icons"))
    hl.bind(main_mod .. " + L", hl.dsp.exec_cmd("hyprlock"))

    -- Swap windows with Super+Shift+Arrow.
    for _, direction in ipairs({ "left", "right", "up", "down" }) do
        local short_direction = ({ left = "l", right = "r", up = "u", down = "d" })[direction]
        hl.bind(main_mod .. " + SHIFT + " .. direction, hl.dsp.window.swap({ direction = short_direction }))
    end

    -- Group controls. The original config also assigns Super+Arrows to these
    -- actions, alongside the focus bindings above.
    hl.bind(main_mod .. " + G", hl.dsp.group.toggle())
    hl.bind("ALT + Tab", hl.dsp.group.next())
    for _, direction in ipairs({ "left", "right", "up", "down" }) do
        local short_direction = ({ left = "l", right = "r", up = "u", down = "d" })[direction]
        hl.bind(main_mod .. " + " .. direction, hl.dsp.window.move({ into_group = short_direction }))
    end

    -- Screenshot shortcuts.
    hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("hyprshot -m output -m $(hyprctl activeworkspace -j | jq -r '.monitor') --clipboard-only"))
    hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
    hl.bind("ALT + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))

    -- Waybar controls and theme picker.
    hl.bind(main_mod .. " + B", hl.dsp.exec_cmd("pkill -x waybar || waybar"))
    hl.bind(main_mod .. " + T", hl.dsp.exec_cmd("$HOME/.config/themes/switch-theme.sh"))
end
