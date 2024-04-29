local vc = require('vicious')
local wibox = require('wibox')
local gfs = require("gears.filesystem")
local icon = gfs.get_configuration_dir() .. '/icons/wifi.png'

-- Crear el widget de fecha
local wifi_text = wibox.widget.textbox()
vc.register(wifi_text, vc.widgets.wifi, "<span color='#70c2ff'>   ${ssid}</span>", 10, 'wlp2s0')

local wifi = wifi_text

wifi:connect_signal('button::press',
	function()
		os.execute("~/.config/awesome/rofi/rofi-wifi/rofi-wifi-menu.sh")
	end
)

return wifi
