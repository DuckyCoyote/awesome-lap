local dpi = require('beautiful.xresources').apply_dpi
local wibox = require('wibox')
local awful = require('awful')
local gears = require('gears')
local gfs = require("gears.filesystem")
local current_config = gfs.get_configuration_dir()

-- Widgets
local date = require('widgets/.clock')
local mem = require('widgets/.mem')
local wifi = require('widgets/.wifi')
local weather = require('widgets/.weather')
local hdd = require('widgets/.hdd')
local cpu = require('widgets/.cpu')
local weather_widget = require("awesome-wm-widgets.weather-widget.weather")
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")
local dashboard = require('widgets/.dashboard')
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local fs_widget = require('awesome-wm-widgets.fs-widget.fs-widget')
local bat = require('widgets.battery')
local temp = require('widgets.temp')
local taglist = require('layout/bar/.taglist')
local bluetooth = require("gobo.awesome.bluetooth")
local media_widget = require("widgets.media")
local power = require("widgets.power")

local vm_widget = require("widgets/.vmware")

-- Functions
local add_margin = require('layout/.add-margin')
local baritems = require('layout/bar/.baritems')

awful.screen.connect_for_each_screen(function(s)
	-- Each scre en has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6", "7" }, s, awful.layout.layouts[1])

	baritems(s)

	s.mytaglist = taglist(s)

	function rounded_shape(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 15)
	end

	function widget_shape(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 10)
	end

	local info_widgets = wibox.container.background(
		wibox.container.margin(wibox.widget {
			wifi,
			add_margin(bluetooth.new(), 2),
			date,
			bat,
			spacing = 10,
			layout = wibox.layout.fixed.horizontal
		}, 10, 10, 0, 0), '#242424', widget_shape)

	local cpu_border = wibox.container.background(
		wibox.container.margin(wibox.widget {
			cpu,
			spacing = 10,
			layout = wibox.layout.fixed.horizontal
		}, 10, 10, 0, 0), '#242424', widget_shape)

	local hdd_border = wibox.container.background(
		wibox.container.margin(wibox.widget {
			hdd,
			spacing = 10,
			layout = wibox.layout.fixed.horizontal
		}, 10, 10, 0, 0), '#242424', widget_shape)

	local mem_border = wibox.container.background(
		wibox.container.margin(wibox.widget {
			mem,
			spacing = 10,
			layout = wibox.layout.fixed.horizontal
		}, 10, 10, 0, 0), '#242424', widget_shape)

	local temp_border = wibox.container.background(
		wibox.container.margin(wibox.widget {
			temp,
			spacing = 10,
			layout = wibox.layout.fixed.horizontal
		}, 10, 10, 0, 0), '#242424', widget_shape)
	
	local vm_border = wibox.container.background(
		wibox.container.margin(wibox.widget {
			vm_widget,
			spacing = 10,
			layout = wibox.layout.fixed.horizontal
		}, 10, 10, 0, 0), '#242424', widget_shape
	)

	local power_spoti = wibox.container.background (
		wibox.container.margin (wibox.widget {
		add_margin(media_widget, 3),
		add_margin(power, 3),
		spacing = 3,
		layout = wibox.layout.fixed.horizontal
	}, 10, 10, 0, 0), '#242424', widget_shape )

	local left_widgets = wibox.widget {
		add_margin(cpu_border, 7),
		add_margin(hdd_border, 7),
		add_margin(mem_border, 7),
		layout = wibox.layout.align.horizontal
	}

	local last_widgets = wibox.container.background(
		wibox.container.margin(wibox.widget {
			weather_widget({
				api_key = 'a277c8fb7aef84fe2e1cbc8f8782f832',
				coordinates = { 19.6997, -99.1475 },
				font_name = 'Carter One',
				icons = 'VitalyGorbachev',
				icons_extension = '.svg',
				show_hourly_forecast = true,
				show_daily_forecast = true
			}),
			spacing = 10,
			layout = wibox.layout.fixed.horizontal
		}, 10, 10, 0, 0), '#242424', widget_shape)

	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		height = dpi(38),
		-- margins = { top = dpi(8), left = dpi(8), right = dpi(8), bottom = 0}
		-- width = dpi(1890)
		--	border_width = 7
		-- shape = roundedw wshape
	})

	s.mywibox:setup {
		{
			{       -- Left Items
				wibox.container.margin(dashboard, 15, 15, 9, 9),
				left_widgets,
				add_margin(temp_border, 7),
				-- add_margin(s.mytasklist, 10),
				add_margin(spotify_widget({
					font = 'Cascadia Code 11',
					play_icon = gfs.get_configuration_dir() .. '/icons/play.png',
					pause_icon = gfs.get_configuration_dir() ..
							'/icons/pause-button.png'
				}), 10),
				add_margin(s.mypromptbox, 3),
				layout = wibox.layout.fixed.horizontal
			},
			nil,
			{       -- Right Items
				add_margin(vm_border, 7),
				-- add_margin(last_widgets, 8),
				add_margin(info_widgets, 7),
				add_margin(power_spoti, 7),
				add_margin(volume_widget, 7),
				add_margin(s.mylayoutbox, 10),
				layout = wibox.layout.fixed.horizontal
			},
			layout = wibox.layout.align.horizontal
		},
		{     -- Middle Items
			add_margin(s.mytaglist, 3),
			valign = "center",
			halign = "center",
			layout = wibox.container.place
		},
		layout = wibox.layout.stack,
		expand = "none"
	}
end)
