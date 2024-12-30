return {
  {
    'neovim/nvim-lspconfig',
    'williamboman/mason-lspconfig.nvim',
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
        'gdtoolkit',
      }
      require('mason-lspconfig').setup {
        ensure_installed = ensure_language_server_installed,
      }

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
      -- setup all language servers
      for server, config in pairs(serverConfigs) do
        lspconfig[server].setup(config)
      end

      -- Can't add 'gdscript' to the servers because it is not listed in Mason. So :MasonInstall gdscript will not work. So here is the work around.
      local gdscript_config = {
        capabilities = blinkcmp_capabilities,
        settings = {},
      }
      if vim.fn.has 'win32' == 1 then
        gdscript_config['cmd'] = { 'ncat', 'localhost', os.getenv 'GDScript_Port' or '6005' }
      end
      lspconfig.gdscript.setup(gdscript_config)

      -- setup keymaps on lsp attachment
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP Actions',
        callback = function(event)
          local opts = { buffer = event.buf }
          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })
    end,
  },
}
