return {
  {
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-jdtls',
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
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      local servers = {
        angularls = {},
        astro = {},
        bashls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        rust_analyzer = {},
        ts_ls = {},
        zls = {},
        jdtls = {
          settings = {
            java = {
              configuration = {
                runtimes = {
                  {
                    name = "CurrentJDK",
                    path = "~/.sdkman/candidates/java/current/java",
                    default = true
                  }
                }
              }
            }
          }
        },
        gopls = {},
        cssls = {},
        css_variables = {},
        ansiblels = {},
        sqlls = {},
        docker_compose_language_service = {},
        dockerls = {},
        jsonls = {},
        elixirls = {
          cmd = { 'elixir-ls' },
        },
        tailwindcss = {
          init_options = {
            userLanguages = {
              elixir = 'html-eex',
              eelixir = 'html-eex',
              heex = 'html-eex',
            },
          },
        },
      }
      local ensure_installed = {}
      for k, _ in pairs(servers) do
        table.insert(ensure_installed, k)
      end

      require('mason').setup()

      require 'mason-lspconfig'.setup {
        ensure_installed = ensure_installed,
        automatic_installation = true,
        automatic_enable = {
          exclude = {
            'jdtls'
          }
        },
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            vim.lsp.config(server_name, server)
          end,
        },
      }
    end,
  },
}
