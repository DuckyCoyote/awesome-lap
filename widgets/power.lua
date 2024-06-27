local wibox = require('wibox')
local gfs = require("gears.filesystem")
local icon = gfs.get_configuration_dir() .. '/icons/power.png'
local awful = require('awful')
local gears = require('gears')

function widget_shape(cr, width, height)
	gears.shape.rounded_rect(cr, width, height, 10)
end

local power = wibox.widget({
  {
    image = icon,
    widget = wibox.widget.imagebox
  },
  layout = wibox.container.place
})

local widget_shutdown = wibox.container.margin(
  wibox.container.background(
    wibox.widget {
      markup = '<span color="#c4c4b5" face="feather" size="100pt"></span>',
      widget = wibox.widget.textbox,
    },
    '#171a20',
    widget_shape,
    'center',
    'center'
  ),
  20, 20, 20, 20
)

local widget_reboot = wibox.container.margin(
  wibox.container.background(
    wibox.widget {
      markup = '<span color="#c4c4b5" face="feather" size="100pt"></span>',
      widget = wibox.widget.textbox,
    },
    '#171a20',
    widget_shape,
    'center',
    'center'
  ),
  20, 20, 20, 20
)

local widget_logout = wibox.container.margin(
  wibox.container.background(
    wibox.widget {
      markup = '<span color="#c4c4b5" face="feather" size="100pt"></span>',
      widget = wibox.widget.textbox,
    },
    '#171a20',
    widget_shape,
    'center',
    'center'
  ),
  20, 20, 20, 20
)

local widget_something = wibox.container.margin(
  wibox.container.background(
    wibox.widget {
      markup = '<span color="#c4c4b5" face="feather" size="100pt"></span>',
      widget = wibox.widget.textbox,
    },
    '#171a20',
    widget_shape,
    'center',
    'center'
  ),
  20, 20, 20, 20
)

local widget_another = wibox.container.margin(
  wibox.container.background(
    wibox.widget {
      markup = '<span color="#c4c4b5" face="feather" size="100pt"></span>',
      widget = wibox.widget.textbox,
    },
    '#171a20',
    widget_shape,
    'center',
    'center'
  ),
  20, 20, 20, 20
)

local options = wibox.widget {
  homogeneous   = false,
  spacing       = 20,
  min_cols_size = 10,
  min_rows_size = 10,
  layout        = wibox.layout.fixed.horizontal
}

options:add(widget_shutdown)
options:add(widget_reboot)
options:add(widget_another)
options:add(widget_something)

local power_popup = awful.popup {
  widget = wibox.widget {
    widget = wibox.widget.separator
  },
  ontop = true,
  maximum_width = 1800,
  bg = '#111317',
  visible = false,
  placement = awful.placement.centered,
}

power_popup:setup({
 options,
  layout = wibox.layout.fixed.horizontal,
  widget = wibox.widget.separator
})

power:buttons(gears.table.join(awful.button({}, 1, function()
  if power_popup.visible then
    power_popup.visible = not power_popup.visible
  else
    power_popup:move_next_to(mouse.current_widget_geometry)
  end
end)))

return power
