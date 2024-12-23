return {
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require 'lint'
      local utils = require '../utils/utils'
      local ensure_installed = {
        'eslint_d', -- typescript and js
        'markdownlint',
        'jsonlint', -- json
        'tflint', -- for terraform
        'yamllint', -- yaml
        'bacon', -- for rust
        'hadolint', -- for dockerfiles
        'pylint', -- for python
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
