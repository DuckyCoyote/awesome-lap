local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local gfs = require("gears.filesystem")
local naughty = require("naughty")

local windows = gfs.get_configuration_dir() .. '/icons/icons-os/windows.png';
local debian = gfs.get_configuration_dir() .. '/icons/icons-os/debian.png';
local ubuntu = gfs.get_configuration_dir() .. '/icons/icons-os/ubuntu.png';
local arch = gfs.get_configuration_dir() .. '/icons/icons-os/arch.png';
local fedora = gfs.get_configuration_dir() .. '/icons/icons-os/fedora.png';
local linux = gfs.get_configuration_dir() .. '/icons/icons-os/linux.png';
local chungus = gfs.get_configuration_dir() .. '/icons/icons-os/chungus.png';
local off = gfs.get_configuration_dir() .. '/icons/icons-os/off.png';

local filepath = gfs.get_configuration_dir() .. "/widgets/vm.txt"

local os_name = ''
local ip = '127.025.191.071'
local os_image = linux


local vm_image = wibox.widget {
  image = windows,
  widget = wibox.widget.imagebox
}

local vm_text = wibox.widget {
  text = ip,
  widget = wibox.widget.textbox
}

local vm_widget = wibox.widget ({
  wibox.container.margin( 
    vm_image , 1, 10, 1, 1 ),
  vm_text,
  layout = wibox.layout.align.horizontal
})

local final_widget = vm_widget

local function read_file()
  local file = io.open(filepath, "r")
  if file then
    local content = file:read("*all")
    file:close()

    -- Procesar el contenido
    local lines = {}
    for line in content:gmatch("[^\r\n]+") do 
      table.insert(lines, line)
    end
  
    if #lines > 0 then
      local parts = gears.string.split(lines[1], " ")
      if #parts == 2 then
        os_name = parts[1]
        ip = parts[2]

        -- Actualizar el widget
      
          if os_name == 'arch' then
           os_image = arch
          elseif os_name == 'windows' then
            os_image = windows
          elseif os_name == 'ubuntu' then
            os_image = ubuntu
          elseif os_name == 'fedora' then
            os_image = fedora
          elseif os_name == 'dc' then
            os_image = chungus
          elseif os_name == 'off' then
            os_image = off
          else 
            os_image = linux
          end
        vm_image:set_image(os_image) 
        vm_text:set_text(ip)
        
      end
    end    


  else
    naughty.notify({ preset = naughty.config.presets.critical,
      title = "Error",
      text = "No se pudo abrir el archivo: " .. filepath })
  end

end

read_file()

gears.timer({
  timeout = 1,
  autostart = true,
  callback = function()
    read_file()
  end
})

return final_widget
