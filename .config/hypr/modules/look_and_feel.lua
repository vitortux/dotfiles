-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
return function(theme)
    local style = theme.style

    hl.config({
        general = {
            gaps_in = 5,
            gaps_out = theme.gaps_out,
            border_size = style.border_size,
            col = {
                active_border = style.active_border,
                inactive_border = style.inactive_border,
            },
            resize_on_border = false,
            allow_tearing = false,
            layout = "dwindle",
        },
        decoration = {
            rounding = style.rounding,
            rounding_power = style.rounding_power,
            active_opacity = style.active_opacity,
            inactive_opacity = style.inactive_opacity,
            shadow = style.shadow,
            blur = style.blur,
        },
        group = {
            col = {
                border_active = style.active_border,
                border_inactive = style.inactive_border,
            },
            groupbar = {
                enabled = true,
                col = {
                    active = style.active_border,
                    inactive = style.inactive_border,
                },
            },
        },
    })
end
