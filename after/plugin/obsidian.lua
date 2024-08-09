local obsidian = require 'obsidian'
local base_vault_path = '~/Vaults/'

obsidian.setup({
  workspaces = {
    {
      name = "Work",
      path = base_vault_path .. "Work"
    }
  },
  completion = {
    nvim_cmp = true,
    min_chars = 2
  }
})
