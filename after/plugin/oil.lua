local oil = require 'oil'
oil.setup {
    default_file_explorer = true,
    keymaps = {
        ['<CR>'] = 'actions.select',
        ['g?'] = 'actions.show_help',
        ['<C-t>'] = 'actions.select_tab',
        ['-'] = 'actions.parent',
        ['<C-o>'] = 'actions.preview',
        ['<C-s>'] = 'actions.select_split',
        ['<C-a>'] = 'actions.select_vsplit',
    },
    use_default_keymaps = false,
    experimental_watch_for_changes = true,
    view_options = {
        show_hidden = true,
    },
}

vim.keymap.set('n', '-', function()
    oil.open()
end, { desc = 'Open parent directory' })
