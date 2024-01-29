local M = {}

M.plugin = {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
}

M.styles = {
    {
        "Catppuccin",
        config = function()
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    }
}

return M
