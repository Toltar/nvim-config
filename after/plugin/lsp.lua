local lsp_zero = require('lsp-zero')
local navic = require('nvim-navic')
local lspconfig = require('lspconfig')

local attatch_navic = function(client, bufnr)
    if client.server._capabilities.documentFormattingProvider then
        navic.attach(client, bufnr)
    end
end

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)


-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({});
require('mason-lspconfig').setup({
	ensure_installed = {
		'tsserver',
		'eslint',
		'rust_analyzer'
	},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = (function()
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							version = 'LuaJIT'
						},
						diagnostics = {
							globals = {
								'vim',
								'require'
							},
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true)
						},
						telemetry = {
							enable = false
						},
					},
				},
                on_attach = function(client, bufnr)
                    attatch_navic(client, bufnr)
                end
			})
		end),
        tsserver = (function() 
            lspconfig.tsserver.setup({
                on_attach = (function(client, bufnr)
                    attach_navic(client, bufnr)
                end)
            })
        end)
	},
});
