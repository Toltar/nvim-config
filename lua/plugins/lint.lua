return {
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require 'lint'
      local utils = require '../utils/utils'
      local ensure_installed = {
        'markdownlint',
        'jsonlint', -- json
        'tflint', -- for terraform
        'yamllint', -- yaml
        'bacon', -- for rust
        'hadolint', -- for dockerfiles
        'pylint', -- for python
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

      lint.linters_by_ft = {
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        markdown = { 'markdownlint' },
        json = { 'jsonlint' },
        terraform = { 'tflint' },
        yaml = { 'yamllint' },
        rust = { 'bacon' },
        docker = { 'hadolint' },
        python = { 'pylint' },
      }
      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
