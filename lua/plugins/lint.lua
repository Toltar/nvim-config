return {
  {
    'mfussenegger/nvim-lint',
    'rshkarin/mason-nvim-lint',
    config = function()
      local lint = require 'lint'
      local ensure_installed = {
        'markdownlint',
        'jsonlint', -- json
        'tflint', -- for terraform
        'yamllint', -- yaml
        'bacon', -- for rust
        'hadolint', -- for dockerfiles
        'pylint', -- for python
      }
      require('mason-nvim-lint').setup {
        ensure_installed = ensure_installed,
        automatic_installation = true,
      }

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
