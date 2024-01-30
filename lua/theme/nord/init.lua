local M = {}

M.plugin = {
    "shaunsingh/nord.nvim",
}

M.styles = {
    {
        "Nord",
        config = function()
            vim.g.nord_contrast = true
            vim.cmd [[colorscheme nord]]
        end,
    },
}

return M
