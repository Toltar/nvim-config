local javascriptformatters = require 'formatter.filetypes.javascript'
local luaformatters = require 'formatter.filetypes.lua'
local typescriptformatters = require 'formatter.filetypes.typescript'
local goformatters = require 'formatter.filetypes.go'
local rustformatters = require 'formatter.filetypes.rust'
local yamlformatters = require 'formatter.filetypes.yaml'
local any = require 'formatter.filetypes.any'

require('formatter').setup {
    filetype = {
        javascript = {
            javascriptformatters.prettier,
            javascriptformatters.eslint_d,
        },
        lua = {
            luaformatters.stylua,
        },
        typescript = {
            typescriptformatters.prettier,
            typescriptformatters.eslint_d,
        },
        go = {
            goformatters.gofmt,
            goformatters.goimports,
        },
        rust = {
            rustformatters.rustfmt,
        },
        yaml = {
            yamlformatters.yamlfmt,
        },
        ['*'] = {
            any.remove_trailing_whitespace,
        },
    },
}

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('__formatter__', { clear = true })
autocmd('BufWritePost', {
    group = '__formatter__',
    command = ':FormatWrite',
})

vim.keymap.set('n', '<leader>ff', ':FormatWrite<CR>')
