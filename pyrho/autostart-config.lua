-----------------------------------------------------------------------------------------------------------------------
--                                              Autostart app list                                                   --
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
local awful = require("awful")

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local autostart = {}

-- Application list function
--------------------------------------------------------------------------------
function autostart.run()
	-- utils
	awful.spawn.with_shell("compton --config /home/dinesh/.config/compton.conf -b")
	awful.spawn.with_shell("pulseaudio")
	awful.spawn.with_shell("nm-applet")
    awful.spawn.with_shell("owncloud")
    awful.spawn.with_shell("setxkbmap -option ctrl:nocaps")
    -- Enable trackpoint accel
    awful.spawn.with_shell("~/repos/3rdparty/thinkpad-scripts/trackpoint-fast-libinput.sh")

    -- Disable horizontal scrolling
    awful.spawn.with_shell("bash ~/bin/configureTrackpad.sh")
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return autostart
