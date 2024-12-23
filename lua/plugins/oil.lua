return {
  {
    'stevearc/oil.nvim',
    dependencies = { { 'echasnovski/mini.icons' } },
    lazy = false,
    config = function()
      local oil = require 'oil'
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
      oil.setup {
        default_file_explorer = true,
        columns = {
          'icon',
        },
        view_options = {
          show_hidden = true,
        },
        use_default_keymaps = false,
        keymaps = {
          ['<CR>'] = 'actions.select',
          ['g?'] = 'actions.show_help',
          ['<C-t>'] = 'actions.select_tab',
          ['<C-o>'] = 'actions.preview',
          ['-'] = 'actions.parent',
          ['<C-s>'] = 'actions.select_split',
          ['<C-a>'] = 'actions.select_vsplit',
        },
      }
    end,
  },
}
