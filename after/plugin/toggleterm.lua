local toggleterm = require 'toggleterm'

toggleterm.setup {
    size = function()
        return 20
    end,
    open_mapping = [[<C-\>]],
}
