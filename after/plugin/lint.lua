local lint = require 'lint'

lint.linters_by_ft = {
    javascript = { 'eslint' },
    typescript = { 'eslint' },
    markdown = { 'markdownlint' },
    json = { 'jsonlint' },
    terraform = { 'tflint' },
    bash = { 'spellcheck' },
    yaml = { 'yamllint' },
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

local lint_progress = function()
    local linters = lint.get_running()
    if #linters == 0 then
        return '0'
    end
    return '0 ' .. table.concat(linters, ', ')
end
