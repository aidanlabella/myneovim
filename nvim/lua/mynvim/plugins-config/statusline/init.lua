local lsp_status = require('lsp-status')
lsp_status.register_progress()

gps = require("nvim-gps")
gps.setup({separator = '  '})

local geten = io.popen("hostname")
local hostname = geten:read("*line.")

-- remove additional hostnames
hostname=hostname:match"([^.]*)(.*)"

geten = io.popen("whoami")
local me = geten:read("*line")
geten:close()

local get_host = function()
    return '  ' .. me .. '@' .. hostname
end

local lualine = require('lualine')
local config = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {[['']], 'mode'},
    lualine_b = {{'diff',
                 symbols = {added = ' ', modified = ' ', removed = ' '},
                },
                'diagnostics'},
    lualine_c = {'branch', "require'lsp-status'.status()"},
    lualine_x = {get_host},
    lualine_y = {'encoding', 'fileformat', 'filetype'},
    lualine_z = {'location', 'progress'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'nvim-tree', 'fugitive'}
}

lualine.setup(config)
