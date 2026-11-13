---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/configuring/core/binds/ for more

return function(programs)
    local mainMod = "SUPER" -- Sets "Windows" key as main modifier

    -- Example binds, see https://wiki.hypr.land/configuring/core/binds/ for more
    hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(programs.terminal))
    local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
    -- closeWindowBind:set_enabled(false)
    hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
    hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
    hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
    local templateMenuBind = hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(programs.menu))
    hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
    hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

    -- Move focus with mainMod + arrow keys
    hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
    hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
    hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
    hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

    -- Switch workspaces with mainMod + [0-9]
    -- Move active window to a workspace with mainMod + SHIFT + [0-9]
    for i = 1, 10 do
        local key = i % 10 -- 10 maps to key 0
        hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
        hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
    end

    -- Example special workspace (scratchpad)
    hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
    hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

    -- Scroll through existing workspaces with mainMod + scroll
    hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

    -- Move/resize windows with mainMod + LMB/RMB and dragging
    hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
    hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    -- Laptop multimedia keys for volume and LCD brightness
    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
    hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
    hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

    -- Requires playerctl
    hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
    hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

    -- Personal configuration
    -- Replace the template's menu bind without leaving a duplicate shortcut.
    templateMenuBind:set_enabled(false)

    -- Rofi launcher on Super+Space (the template uses Super+R).
    hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(programs.menu .. " -show drun -show-icons"))
    hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

    -- Swap windows with Super+Shift+Arrow.
    for _, direction in ipairs({ "left", "right", "up", "down" }) do
        local short_direction = ({ left = "l", right = "r", up = "u", down = "d" })[direction]
        hl.bind(mainMod .. " + SHIFT + " .. direction, hl.dsp.window.swap({ direction = short_direction }))
    end

    -- Group controls. The original config also assigns Super+Arrows to these
    -- actions, alongside the focus bindings above.
    hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
    hl.bind("ALT + Tab", hl.dsp.group.next())
    for _, direction in ipairs({ "left", "right", "up", "down" }) do
        local short_direction = ({ left = "l", right = "r", up = "u", down = "d" })[direction]
        hl.bind(mainMod .. " + " .. direction, hl.dsp.window.move({ into_group = short_direction }))
    end

    -- Screenshot shortcuts.
    hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("hyprshot -m output -m $(hyprctl activeworkspace -j | jq -r '.monitor') --clipboard-only"))
    hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
    hl.bind("ALT + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))

    -- Waybar controls and theme picker.
    hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("pkill -x waybar || waybar"))
    hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("$HOME/.config/themes/switch-theme.sh"))
end
