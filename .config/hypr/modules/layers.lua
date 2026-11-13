----------------
---- LAYERS ----
----------------

-- This option is present in the installed template but is rejected by the
-- installed Hyprland 0.56.2 build as an unknown config key. Keep it documented
-- here and enable it when the running Hyprland version supports it.
--[[
hl.config({
    layers = {
        allow_new_top_layers_over_existing_fullscreen = true, -- Set to false to make newly mapped top layers render below existing covering fullscreen window
    },
})
]]
