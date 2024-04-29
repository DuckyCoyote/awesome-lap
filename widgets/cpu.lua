local vc = require('vicious')
local wibox = require('wibox')
local gfs = require("gears.filesystem")

local cpu_text = wibox.widget.textbox()

vc.register(cpu_text, vc.widgets.cpu, '<span color="#ff7b70">  </span>$1%')
-- #ff7b70
local cpu = cpu_text
return cpu
