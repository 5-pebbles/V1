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
