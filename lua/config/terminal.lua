vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custon-term-open', { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})

-- local job_id = 0
local split_terminal_state = {
    terminal = {
        current_window = -1,
        current_buffer = -1,
    },
}
function createNewTerminal()
    -- Create a vsplit window
    vim.cmd.vnew()
    -- Set it to a terminal
    vim.cmd.term()
    -- Move it to the bottom
    vim.cmd.wincmd 'J'
    -- Get the current buffer and window
    local window = vim.api.nvim_get_current_win()
    local buffer = vim.api.nvim_get_current_buf()
    -- Set the focus to the current buffer and window
    vim.api.nvim_win_set_buf(window, buffer)
    -- Set the height of the terminal window
    vim.api.nvim_win_set_height(window, 20)
    --job_id = vim.bo.channel
    return { current_window = window, current_buffer = buffer }
end
local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(split_terminal_state.terminal.current_window) then
        split_terminal_state.terminal = createNewTerminal()
        if vim.bo[split_terminal_state.terminal.current_buffer].buftype ~= 'terminal' then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(split_terminal_state.terminal.current_window)
    end
end
vim.keymap.set('n', '<space>to', toggle_terminal)

-- TODO: Revisit this in the future for possible wins with building and scripting
-- you can use this to run make or go build or anything.
-- vim.keymap.set('n', '<leader>example', function()
-- vim.fn.chansend(job_id, { "ls -al\r\n" })
-- end)
