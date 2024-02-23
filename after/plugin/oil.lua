local oil = require("oil")

oil.setup({
    default_file_explorer = true,
    keymaps = {
        ["<C-o>"] = "actions.preview",
    },
    view_options = {
        show_hidden = true,
    },
})



vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
