return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    'c',
                    'go',
                    'gomod',
                    'goctl',
                    'gosum',
                    'gotmpl',
                    'gowork',
                    'javascript',
                    'typescript',
                    'rust',
                    'lua',
                    'vim',
                    'vimdoc',
                    'query',
                    'dockerfile',
                    'css',
                    'gitignore',
                    'json',
                    'zig',
                    'yaml',
                    'vue',
                    'angular',
                    'bash',
                    'helm',
                    'terraform',
                    'toml',
                    'python',
                    'sql',
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,
                indent = { enable = true },

                highlight = {
                    enable = true,
                    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
                ignore_install = {},
                modules = {},
            }
        end,
    },
}
