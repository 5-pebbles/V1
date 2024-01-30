-- Leader
vim.g.mapleader = " "

-- Write
vim.keymap.set("n", "<leader><S-w>", vim.cmd.w)

-- Clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>y", '"+y')

-- Exit
vim.keymap.set("n", "<leader><S-q>", vim.cmd.q)

-- Search
vim.keymap.set("n", "N", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Windows
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true })


-- Toggle Diagnostics
vim.api.nvim_create_user_command("DiagnosticsToggle", function()
    local current_value = vim.diagnostic.is_disabled()
    if current_value then
        vim.diagnostic.enable()
    else
        vim.diagnostic.disable()
    end
end, {})
vim.keymap.set("n", "<leader>p", vim.cmd.DiagnosticsToggle)
