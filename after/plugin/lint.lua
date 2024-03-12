local lint = require 'lint'

lint.linters_by_ft = {
    javascript = { 'eslint_d', 'eslint', 'biomejs' },
    typescript = { 'eslint_d', 'eslint', 'biomejs' },
    markdown = { 'markdownlint' },
    json = { 'jsonlint' },
    terraform = { 'tflint' },
    bash = { 'spellcheck' },
    yaml = { 'yamllint', 'actionlint', 'ansible-lint' },
}

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    group = lint_augroup,
    callback = function()
        lint.try_lint(nil, { ignore_errors = true })
    end,
})

vim.keymap.set('n', '<leader>ll', function()
    lint.try_lint()
end, { desc = 'Trigger linting for the current file' })
