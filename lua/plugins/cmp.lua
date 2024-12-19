-- Available commands:
--   show, hide, cancel, accept, select_and_accept, select_prev, select_next, show_documentation, hide_documentation,
--   scroll_documentation_up, scroll_documentation_down, snippet_forward, snippet_backward, fallback
--
-- "default" keymap
--   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
--   ['<C-e>'] = { 'hide' },
--   ['<C-y>'] = { 'select_and_accept' },
--
--   ['<C-p>'] = { 'select_prev', 'fallback' },
--   ['<C-n>'] = { 'select_next', 'fallback' },
--
--   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
--   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
--
--   ['<Tab>'] = { 'snippet_forward', 'fallback' },
--   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
--
-- "super-tab" keymap
--   you may want to set `completion.trigger.show_in_snippet = false`
--   or use `completion.list.selection = "manual" | "auto_insert"`
--
--   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
--   ['<C-e>'] = { 'hide', 'fallback' },
--
--   ['<Tab>'] = {
--     function(cmp)
--       if cmp.snippet_active() then return cmp.accept()
--       else return cmp.select_and_accept() end
--     end,
--     'snippet_forward',
--     'fallback'
--   },
--   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
--
--   ['<Up>'] = { 'select_prev', 'fallback' },
--   ['<Down>'] = { 'select_next', 'fallback' },
--   ['<C-p>'] = { 'select_prev', 'fallback' },
--   ['<C-n>'] = { 'select_next', 'fallback' },
--
--   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
--   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
--
-- "enter" keymap
--   you may want to set `completion.list.selection = "manual" | "auto_insert"`
--
--   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
--   ['<C-e>'] = { 'hide', 'fallback' },
--   ['<CR>'] = { 'accept', 'fallback' },
--
--   ['<Tab>'] = { 'snippet_forward', 'fallback' },
--   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
--
--   ['<Up>'] = { 'select_prev', 'fallback' },
--   ['<Down>'] = { 'select_next', 'fallback' },
--   ['<C-p>'] = { 'select_prev', 'fallback' },
--   ['<C-n>'] = { 'select_next', 'fallback' },
--
--   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
--   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
return {
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        version = '0.7.6',
        config = function()
            local blink_cmp = require 'blink.cmp'
            blink_cmp.setup {
                enabled = function()
                    return vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
                end,
                keymap = { preset = 'default' },
                appearance = {
                    highlight_ns = vim.api.nvim_create_namespace 'blink_cmp',
                    use_nvim_cmp_as_default = true,
                    nerd_font_variant = 'mono',
                    kind_icons = {
                        Text = '󰉿',
                        Method = '',
                        Function = '󰊕',
                        Constructor = '󰒓',

                        Field = '󰜢',
                        Variable = '󰆦',
                        Property = '󰖷',

                        Class = '',
                        Interface = '',
                        Struct = '',
                        Module = '󰕳',

                        Unit = '󰪚',
                        Value = '󰦨',
                        Enum = '',
                        EnumMember = '',

                        Keyword = '󰻾',
                        Constant = '󰏿',

                        Snippet = '󱄽',
                        Color = '󰏘',
                        File = '󰈔',
                        Reference = '󰬲',
                        Folder = '󰉋',
                        Event = '󱐋',
                        Operator = '󰪚',
                        TypeParameter = '󰬛',
                    },
                },
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },
                signature = { enabled = true },
                completion = {},
                snippets = {},
            }
        end,
    },
}
