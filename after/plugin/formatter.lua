local conform = require 'conform'
conform.setup {
    formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'dprint', { 'prettierd', 'prettier' } },
        typescript = { 'dprint', { 'prettierd', 'prettier' } },
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
        biome = {
            condition = function(ctx)
                return vim.fs.find({ 'biome.json' }, { path = ctx.filename, updward = true })[1]
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
    format_on_save = {
        lsp_fallback = true,
    },
}
