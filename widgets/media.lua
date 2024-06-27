local wibox = require('wibox')
local gfs = require("gears.filesystem")
local icon = gfs.get_configuration_dir() .. '/icons/spotify.png'
local awful = require('awful')
local gears = require('gears')
local media = require("widgets/media_player/.main")

local spotify_widget = wibox.widget({
  {
    image = icon,
    widget = wibox.widget.imagebox
  },
  layout = wibox.container.place
})

spotify_widget:connect_signal("button::press", function()
	media.visible = not media.visible
end)

return spotify_widget
