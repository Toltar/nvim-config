local lualine = require 'lualine'

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'ayu_mirage',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
}

vim.opt.showmode = false
