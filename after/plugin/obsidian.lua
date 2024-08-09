local obsidian = require 'obsidian'
local base_vault_path = '~/Vaults/'
vim.opt.conceallevel = 1
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
  },
  sort_by = "modified",
  picker = {
    name = "telescope.nvim",
    note_mappings = {
      new = "<C-x>",
      insert_link = "<C-l>",
    },
    tag_mappings = {
      tag_note = "<C-x>",
      insert_tag = "<C-l>",
    },
  },
  ui = {
    enable = true,         -- set to false to disable all additional syntax features
    update_debounce = 200, -- update delay after a text change (in milliseconds)
    -- Define how various check-boxes are displayed
    checkboxes = {
      -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
      [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      ["x"] = { char = "", hl_group = "ObsidianDone" },
      [">"] = { char = "", hl_group = "ObsidianRightArrow" },
      ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
      ["!"] = { char = "", hl_group = "ObsidianImportant" },
      -- Replace the above with this if you don't have a patched font:
      -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
      -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

      -- You can also add more custom ones...
    },
    -- Use bullet marks for non-checkbox lists.
    bullets = { char = "•", hl_group = "ObsidianBullet" },
    external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    -- Replace the above with this if you don't have a patched font:
    -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    reference_text = { hl_group = "ObsidianRefText" },
    highlight_text = { hl_group = "ObsidianHighlightText" },
    tags = { hl_group = "ObsidianTag" },
    block_ids = { hl_group = "ObsidianBlockID" },
    hl_groups = {
      -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
      ObsidianTodo = { bold = true, fg = "#ffffff" },
      ObsidianDone = { bold = true, fg = "#89ddff" },
      ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
      ObsidianTilde = { bold = true, fg = "#ff5370" },
      ObsidianImportant = { bold = true, fg = "#d73128" },
      ObsidianBullet = { bold = true, fg = "#89ddff" },
      ObsidianRefText = { underline = true, fg = "#c792ea" },
      ObsidianExtLinkIcon = { fg = "#c792ea" },
      ObsidianTag = { italic = true, fg = "#89ddff" },
      ObsidianBlockID = { italic = true, fg = "#89ddff" },
      ObsidianHighlightText = { bg = "#75662e" },
    },
  },
})
