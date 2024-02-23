vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', ':Ex<CR>')

-- Easy split windows and quit windows splits with leader key instead of Ctrl as a pereference
vim.keymap.set('n', '<leader>wn', vim.cmd.split)
vim.keymap.set('n', '<leader>wv', vim.cmd.vsplit)
vim.keymap.set('n', '<leader>wq', vim.cmd.close)
vim.keymap.set('n', '<leader>wl', '<C-w>l')
vim.keymap.set('n', '<leader>wk', '<C-w>k')
vim.keymap.set('n', '<leader>wj', '<C-w>j')
vim.keymap.set('n', '<leader>wh', '<C-w>h')

-- Paste without loosing past buffer
vim.keymap.set('n', '<leader>p', '"_dP')

-- Bash script keymaps -------------------------------------
-- Add execute permission to file with leader + x
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })
