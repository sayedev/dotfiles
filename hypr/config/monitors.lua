-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Example: output can be found with hyprctl monitors. Edit variables.lua for the monitor outputs instead of here directly
-- hl.monitor({
--     output    = "MONITOR1",
--     mode      = "1920x1080@60",
--     position  = "0x0",
--     scale     = "1",
-- })

hl.monitor({
    output = "DP-2",
    mode = "2560x1440@164.84",
    position = "1920x0",
    scale = 1.0
})
hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@74.97",
    position = "0x360",
    scale = 1
})
