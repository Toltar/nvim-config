return {
  {
    'stevearc/conform.nvim',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'zapling/mason-conform.nvim',
    },
    config = function()
      local conform = require 'conform'
      conform.setup {
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        formatters_by_ft = {
          lua = { 'stylua' },
          go = { 'goimports', 'gofumpt' },
          sql = { 'sql-formatter' },
          bash = { 'beutysh' },
          json = { 'fixjson' },
          javascript = { 'prettierd' },
          typescript = { 'prettierd' },
          python = { 'autoflake', 'black' },
        },
        format_on_save = {
          lsp_format = 'fallback',
          timeout_ms = 1000,
        },
        notify_on_error = true,
      }
    end,
  },
}
