local oil = require 'oil'

oil.setup {
  default_file_explorer = true,
  keymaps = {
    ['<C-o>'] = 'actions.preview',
  },
  experimental_watch_for_changes = true,
  view_options = {
    show_hidden = true,
  },
}

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
