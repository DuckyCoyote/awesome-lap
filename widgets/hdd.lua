local vc = require('vicious')
local wibox = require('wibox')
local gfs = require("gears.filesystem")
local icon = gfs.get_configuration_dir() .. '/icons/crayon/storage.png'

-- Crear el widget de fecha
local hdd_text = wibox.widget.textbox()
vc.register(hdd_text, vc.widgets.fs, '<span color="#70c2ff">  </span>/${/ avail_gb} Gb')

local hdd = hdd_text

return hdd
