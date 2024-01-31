-- Telescope
local telescope = require('telescope.builtin')

vim.keymap.set("n", "<leader>f", function()
    telescope.find_files()
end)

vim.keymap.set("n", "<leader>g", function()
    telescope.git_files()
end)

vim.keymap.set("n", "<leader><S-f>", function()
    telescope.live_grep()
end)

vim.keymap.set("n", "<leader>.", function()
    telescope.find_files({ cwd = vim.fn.stdpath('config') })
end)
