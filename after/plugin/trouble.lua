local trouble = require 'trouble'

-- Configuration
trouble.setup {}

-- Keybindings
local set = vim.keymap.set

set('n', '<leader>xx', function()
    trouble.toggle()
end, { noremap = true, silent = true })
set('n', '<leader>xw', function()
    trouble.toggle 'workspace_diagnostics'
end, { noremap = true, silent = true })
set('n', '<leader>xd', function()
    trouble.toggle 'document_diagnostics'
end, { noremap = true, silent = true })
set('n', '<leader>xl', function()
    trouble.toggle 'loclist'
end, { noremap = true, silent = true })
set('n', '<leader>xq', function()
    trouble.toggle 'quickfix'
end, { noremap = true, silent = true })
set('n', 'gR', function()
    trouble.toggle 'lsp_references'
end, { noremap = true, silent = true })
