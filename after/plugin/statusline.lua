local lualine = require 'lualine'

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'ayu_mirage',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
            {
                'filename',
                path = 1,
                symbols = {
                    modified = '[+]',
                    readonly = '[RO]',
                    unnamed = '[No Name]',
                    newfile = '[New]',
                },
            },
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
}

vim.opt.showmode = false
