-- Terminal
local Terminal     = require('toggleterm.terminal').Terminal
local zsh_terminal = Terminal:new({ cmd = "ZDOTDIR=" .. vim.fn.stdpath('config') .. "/stuff zsh", close_on_exit = false })

function ZshToggleTerm() zsh_terminal:toggle() end

vim.keymap.set("n", "<leader>q", ZshToggleTerm)

function ApplyTerminalMapings()
    vim.keymap.set("n", "<esc>", ZshToggleTerm, { buffer = 0 })
    vim.keymap.set("t", "<esc>", "<C-\\><C-n>")
end

vim.cmd([[autocmd! TermOpen term://*toggleterm#* lua ApplyTerminalMapings()]])

-- Conform
vim.keymap.set({ "n", "v" }, "<leader><S-w>", function()
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    })
end, { desc = "Format file or range (in visual mode)" })

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

vim.keymap.set("n", "<leader>,", function()
    telescope.find_files({ cwd = vim.fn.stdpath('config') })
end)


-- Harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>s", function()
    harpoon:list():append()
end)
vim.keymap.set("n", "<leader>a", function()
    harpoon.ui:toggle_quick_menu(harpoon:list(), { title_pos = "center", title = " Harpoon " })
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<Tab>", function()
    harpoon:list():next()
end)
vim.keymap.set("n", "<S-Tab>", function()
    harpoon:list():prev()
end)

-- Go to numbered buffers stored within Harpoon list
vim.keymap.set("n", "<leader>z", function()
    harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>x", function()
    harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>c", function()
    harpoon:list():select(3)
end)
vim.keymap.set("n", "<leader>v", function()
    harpoon:list():select(4)
end)
vim.keymap.set("n", "<leader>b", function()
    harpoon:list():select(5)
end)
vim.keymap.set("n", "<leader>n", function()
    harpoon:list():select(6)
end)
vim.keymap.set("n", "<leader>m", function()
    harpoon:list():select(7)
end)
