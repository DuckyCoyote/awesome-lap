local vc = require('vicious')
local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local gfs = require("gears.filesystem")
local icon = gfs.get_configuration_dir() .. '/icons/crayon/calendar.png'
local color = gfs.get_configuration_dir() .. '/theme/.palette'
local beautiful = require('beautiful')
local calendar_widget = require('awesome-wm-widgets.calendar-widget.calendar')

-- Crear el widget de fecha
local date_text = wibox.widget.textbox()
vc.register(date_text, vc.widgets.date, '   %b %d %I:%M')

local date = date_text

local cw = calendar_widget({
	placement = 'top_right',
	start_sunday = true,
	radius = 3,
	previous_month_button = 1,
	next_month_button = 3,
})

date:connect_signal('button::press',
	function(_, _, _, button)
		if button == 1 then cw.toggle() end
	end
)

return date
