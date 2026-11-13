-- Hyprland Lua configuration entry point.
-- Sections and load order follow /usr/share/hypr/hyprland.lua.

local home = os.getenv("HOME")
local active_theme = dofile(home .. "/.config/themes/current/hypr/theme.lua")

-- MONITORS
require("modules.monitors")

-- MY PROGRAMS
-- Values are shared with the keybinding module.
local programs = require("modules.my_programs")

-- AUTOSTART
require("modules.autostart")

-- ENVIRONMENT VARIABLES
require("modules.environment_variables")

-- PERMISSIONS
require("modules.permissions")

-- LOOK AND FEEL
require("modules.look_and_feel")(active_theme)

-- ANIMATIONS
require("modules.animations")

-- WORKSPACE RULES
require("modules.workspace_rules")

-- LAYOUTS
require("modules.dwindle")
require("modules.master")
require("modules.scrolling")

-- MISC
require("modules.misc")

-- INPUT
require("modules.input")

-- GESTURES
require("modules.gestures")

-- PER-DEVICE INPUT CONFIG
require("modules.devices")

-- KEYBINDINGS
require("modules.keybindings")(programs)

-- WINDOWS AND WORKSPACES
require("modules.windows_and_workspaces")
