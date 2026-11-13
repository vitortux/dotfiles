-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/configuring/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

-- Section structure and base settings are based on:
-- https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.lua
-- Personal settings are labelled in their corresponding modules.

local home = os.getenv("HOME")
local active_theme = dofile(home .. "/.config/themes/current/hypr/theme.lua")

------------------
---- MONITORS ----
------------------
require("modules.monitors")

---------------------
---- MY PROGRAMS ----
---------------------
local programs = require("modules.my_programs")

-------------------
---- AUTOSTART ----
-------------------
require("modules.autostart")

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
require("modules.environment_variables")

-----------------------
----- PERMISSIONS -----
-----------------------
require("modules.permissions")

-----------------------
---- LOOK AND FEEL ----
-----------------------
require("modules.look_and_feel")(active_theme.overrides)

----------------
----  MISC  ----
----------------
require("modules.misc")

----------------
---- LAYERS ----
----------------
require("modules.layers")

---------------
---- INPUT ----
---------------
require("modules.input")

---------------------
---- KEYBINDINGS ----
---------------------
require("modules.keybindings")(programs)

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
require("modules.windows_and_workspaces")
