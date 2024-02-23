local lsp_zero = require 'lsp-zero'

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps { buffer = bufnr }
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup {}
require('mason-lspconfig').setup {
    ensure_installed = {
        'tsserver',
        'eslint',
        'rust_analyzer',
        'lua_ls',
        'bashls',
        'dockerls',
        'docker_compose_language_service',
        'dprint',
        'gopls',
        'jsonls',
        'marksman',
        'sqlls',
        'zls',
    },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            require('lspconfig').lua_ls.setup {
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = {
                                'vim',
                                'require',
                            },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file('', true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }
        end,
    },
}

---
-- Autocompletion config
---

local cmp = require 'cmp'

cmp.setup {
    mapping = cmp.mapping.preset.insert {
        -- Press the enter key to confirm
        ['<CR>'] = cmp.mapping.confirm { select = false },
        -- Ctrl + Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
    },
}
