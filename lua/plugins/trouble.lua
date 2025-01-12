return {
  {
    'folke/trouble.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local trouble = require 'trouble'
      trouble.setup({})

      vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle focus=true<cr>')
      vim.keymap.set('n', '<leader>cs', '<cmd>Trouble lsp_document_symbols toggle focus=true filter.buf=0<cr>')
    end,
  },
}
