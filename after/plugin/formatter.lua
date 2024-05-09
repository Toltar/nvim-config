local conform = require 'conform'
conform.setup {
    formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'dprint' },
        typescript = { 'dprint' },
        rust = { 'rustfmt' },
        go = { 'goimports', 'gofmt' },
        sql = { 'sqlfmt' },
        markdown = { 'markdownlint' },
        ['*.sh'] = { 'shfmt', 'spellcheck' },
        ['*.yml'] = { 'yamlfix', 'yamlfmt' },
        ['*.yaml'] = { 'yamlfix', 'yamlfmt' },
        ['*.json'] = { 'jsonfix' },
        ['*'] = { 'codespell' },
        ['_'] = { 'trim_whitespace' },
    },
    formatters = {
        dprint = {
            condition = function(ctx)
                return vim.fs.find({ 'dprint.json' }, { path = ctx.filename, upward = true })[1]
            end,
        },
        eslint_d = {
            condition = function(ctx)
                return vim.fs.find({
                    'eslint.config.js',
                    '.eslintrc.cjs',
                    '.eslintrc.js',
                    '.eslintrc.yaml',
                    '.eslintrc.json',
                }, { path = ctx.filename, upward = true })[1]
            end,
        },
    },
    format_after_save = {
        lsp_fallback = true,
        timeout_ms = 500,
    },
    notify_on_error = true,
}
