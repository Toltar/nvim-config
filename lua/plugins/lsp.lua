return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'folke/lazydev.nvim',
                ft = 'lua',
                opts = {
                    library = {
                        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                    },
                },
            },
            'williamboman/mason.nvim',
            'saghen/blink.cmp',
        },
        config = function()
            require('mason').setup()
            local utils = require '../utils/utils'
            local ensure_language_server_installed = {
                'lua-language-server',
                'angular-language-server',
                'vue-language-server',
                'ansible-language-server',
                'gopls',
                'zls',
                'typescript-language-server',
                'sqlls',
                'rust-analyzer',
                'eslint-lsp',
                'docker-compose-language-service',
                'dockerfile-language-server',
                'css-lsp',
                'css-variables-language-server',
                'json-lsp',
                'python-lsp-server',
            }
            local installed_language_servers = {}
            for dir in io.popen([[ls -pa ~/.local/share/nvim/mason/packages]]):lines() do
                if dir ~= './' or dir ~= '../' then
                    table.insert(installed_language_servers, dir:sub(1, -2))
                end
            end

            for _, value in ipairs(ensure_language_server_installed) do
                if not utils.table_has_value(installed_language_servers, value) then
                    local command = string.format('MasonInstall %s', value)
                    vim.cmd(command)
                end
            end

            local lspconfig = require 'lspconfig'
            local blinkcmp_capabilities = require('blink.cmp').get_lsp_capabilities()
            local serverConfigs = {
                angularls = {
                    capabilities = blinkcmp_capabilities,
                },
                lua_ls = {
                    capabilities = blinkcmp_capabilities,
                },
                rust_analyzer = {
                    capabilities = blinkcmp_capabilities,
                },
                ts_ls = {
                    capabilities = blinkcmp_capabilities,
                },
                zls = {
                    capabilities = blinkcmp_capabilities,
                },
                gopls = {
                    capabilities = blinkcmp_capabilities,
                },
                cssls = {
                    capabilities = blinkcmp_capabilities,
                },
                css_variables = {
                    capabilities = blinkcmp_capabilities,
                },
                vuels = {
                    capabilities = blinkcmp_capabilities,
                },
                eslint = {
                    capabilities = blinkcmp_capabilities,
                    on_attach = function(_, bufnr)
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = bufnr,
                            command = 'EslintFixAll',
                        })
                    end,
                },
                ansiblels = {
                    capabilities = blinkcmp_capabilities,
                },
                sqlls = {
                    capabilities = blinkcmp_capabilities,
                },
                docker_compose_language_service = {
                    capabilities = blinkcmp_capabilities,
                },
                dockerls = {
                    capabilities = blinkcmp_capabilities,
                },
                jsonls = {
                    capabilities = blinkcmp_capabilities,
                },
            }
            -- Setup blink.cmp
            for server, config in pairs(serverConfigs) do
                lspconfig[server].setup(config)
            end
        end,
    },
}
