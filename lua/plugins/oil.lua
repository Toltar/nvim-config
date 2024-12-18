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
    },
    dependencies = { { "echasnovski/mini.icons" } },
    config = function()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", {desc = "Open parent directory"})
      require("oil").setup()
    end
  }
}
