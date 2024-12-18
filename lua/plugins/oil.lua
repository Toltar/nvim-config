return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      columns = {
        "icon",
      },
      view_options = {
        show_hidden = true
      },
      keymaps = {
        ['<CR>'] = 'actions.select',
        ['g?'] = 'actions.show_help',
        ['<C-t>'] = 'actions.select_tab',
        ['-'] = 'actions.parent',
        ['<C-o>'] = 'actions.preview',
        ['<C-s>'] = 'actions.select_split',
        ['<C-a>'] = 'actions.select_vsplit',
      },
    },
    dependencies = { { "echasnovski/mini.icons" } },
    config = function()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", {desc = "Open parent directory"})
      require("oil").setup()
    end
  }
}
