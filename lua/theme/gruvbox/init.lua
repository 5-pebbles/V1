local M = {}

M.plugin = {
    "luisiacc/gruvbox-baby",
}

M.styles = {
    {
        "Gruvbox",
        config = function()
            vim.g.gruvbox_baby_telescope_theme = 1
            vim.g.gruvbox_baby_highlights = {
                FloatTitle = { link = "TelescopePromptTitle" },
                NormalFloat = { link = "TelescopePreviewNormal" },
                FloatBorder = { link = "TelescopePreviewBorder" },
            }
            vim.cmd [[colorscheme gruvbox-baby]]
        end
    }
}

return M
