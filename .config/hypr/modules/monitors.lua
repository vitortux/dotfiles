------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/configuring/core/monitors/

-- Base template example (kept inactive because this setup has a personal monitor mode):
--[[
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})
]]

-- Personal configuration
hl.monitor({
    output = "",
    mode = "highrr",
    position = "0x0",
    scale = 1,
})
