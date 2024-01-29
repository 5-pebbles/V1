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
            require("catppuccin").setup({
                integrations = {
                    telescope = {
                        enabled = true,
                        style = "nvchad",
                    },
                },
                custom_highlights = function(colors)
                    return {
                        FloatTitle = { link = "TelescopeResultsTitle" },
                        NormalFloat = { link = "TelescopeResultsNormal" },
                        FloatBorder = { link = "TelescopeResultsBorder" },
                    }
                end,
            })
            vim.cmd.colorscheme("catppuccin-frappe")
        end,
    }
}

return M
