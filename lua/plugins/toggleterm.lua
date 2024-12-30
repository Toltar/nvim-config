return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<c-\>]],
        size = 25,
        hide_numbers = true,
        start_in_insert = true,
      }
    end,
  },
}
