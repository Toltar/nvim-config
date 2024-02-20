local builtin = require('telescope.builtin')

-- Telescope Mappings
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})

-- Git Mappings in Telescope
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})

-- LSP Mappings in Telescope
vim.keymap.set('n', '<leader>lr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, {})
vim.keymap.set('n', '<leader>lh', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols, {})
vim.keymap.set('n', '<leader>lt', builtin.lsp_type_definitions, {})


-- File Browser Mappings in Telescope
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>', { noremap = true })
vim.keymap.set('n', '<leader>fc', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { noremap = true })
