return {
  {
    'mfussenegger/nvim-lint',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'rshkarin/mason-nvim-lint',
    },
    config = function()
      local lint = require 'lint'
      local ensure_installed = {
        'markdownlint',
        'jsonlint', -- json
        'tflint',   -- for terraform
        'yamllint', -- yaml
        'hadolint', -- for dockerfiles
        'pylint',   -- for python
        'eslint_d',
      }
      require('mason-nvim-lint').setup {
        ensure_installed = ensure_installed,
        automatic_installation = true,
      }

      lint.linters_by_ft = {
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        markdown = { 'markdownlint' },
        json = { 'jsonlint' },
        terraform = { 'tflint' },
        yaml = { 'yamllint' },
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
