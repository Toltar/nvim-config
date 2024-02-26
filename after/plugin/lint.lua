local lint = require 'lint'

lint.linters_by_ft = {
    javascript = { 'eslint_d' },
    typescript = { 'eslint_d' },
    markdown = { 'markdownlint' },
    json = { 'jsonlint' },
    terraform = { 'tflint' },
    bash = { 'spellcheck' },
    yaml = { 'yamllint', 'actionlint' },
}

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    group = lint_augroup,
    callback = function()
        lint.try_lint()
    end,
})

vim.keymap.set('n', '<leader>ll', function()
    lint.try_lint()
end, { desc = 'Trigger linting for the current file' })
