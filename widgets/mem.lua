local vc = require('vicious')
local wibox = require('wibox')
local gfs = require("gears.filesystem")
local icon = gfs.get_configuration_dir() .. '/icons/crayon/mem.png'

-- Crear el widget de fecha
local memwidget = wibox.widget.textbox()
vc.cache(vc.widgets.mem)
vc.register(memwidget, vc.widgets.mem, "<span color='#f9ce48'>  </span>$2 MiB", 13)
-- #b3de54
local mem = memwidget

return mem
