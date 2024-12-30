return {
  {
    'stevearc/conform.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'zapling/mason-conform.nvim',
    },
    config = function()
      require('conform').setup {
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
