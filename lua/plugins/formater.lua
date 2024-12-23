return {
  {
    'stevearc/conform.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      local utils = require '../utils/utils'
      local ensure_installed = {
        'stylua',
        'prettierd',
        'gofumpt',
        'goimports',
        'sql-formatter',
        'fixjson',
        'autoflake', -- for python
        'black', -- for python
      }
      local installed = {}
      for dir in io.popen([[ls -pa ~/.local/share/nvim/mason/packages]]):lines() do
        if dir ~= './' or dir ~= '../' then
          table.insert(installed, dir:sub(1, -2))
        end
      end

      for _, value in ipairs(ensure_installed) do
        if not utils.table_has_value(installed, value) then
          local command = string.format('MasonInstall %s', value)
          vim.cmd(command)
        end
      end

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
