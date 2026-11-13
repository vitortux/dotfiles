local active_border = {
    colors = { "rgba(33ccffee)", "rgba(00ff99ee)" },
    angle = 45,
}

return {
    gaps_out = { top = 20, right = 20, bottom = 20, left = 20 },
    style = {
        border_size = 2,
        active_border = active_border,
        inactive_border = "rgba(595959aa)",
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
}
