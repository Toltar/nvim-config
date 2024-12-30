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
      local installed_mason_packages = {}
      if vim.fn.has 'win32' == 1 then
        local mason_path = '%HOMEPATH%\\AppData\\Local\\nvim-data\\mason\\packages'
        installed_mason_packages = utils.scan_directory_for_directories_in_windows(mason_path)
      else
        local mason_path = '~/.local/share/nvim/mason/packages'
        installed_mason_packages = utils.scan_directory_for_directories_in_linux(mason_path)
      end

      for _, value in ipairs(ensure_installed) do
        if not utils.table_has_value(installed_mason_packages, value) then
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
