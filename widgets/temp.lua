local vc = require('vicious')
local wibox = require('wibox')

local function colorize(temp)
  if temp < 40 then
    return '#b3de54'
  elseif temp < 60 then
    return '#A5FF7F'
  elseif temp < 75 then
    return '#BC2F1D'
  else
    return '#FF891B'
  end
end

local cmd_temp = 'cat /sys/devices/virtual/thermal/thermal_zone3/temp'

-- Crear el widget de fecha
local temp_text = wibox.widget.textbox()
vc.register(temp_text, vc.widgets.thermal, "<span color='#b3de54'>󰔏 </span>$1°C", 5,
  { "thermal_zone0", "sys", "temp" })

local temp = temp_text

return temp
