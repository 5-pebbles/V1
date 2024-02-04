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
                        -- Floats
                        FloatTitle = { link = "TelescopeResultsTitle" },
                        NormalFloat = { link = "TelescopeResultsNormal" },
                        FloatBorder = { link = "TelescopeResultsBorder" },

                        -- Statusline
                        StatusLineHighlightInsert = { bg = colors.red, fg = colors.base },
                        StatusLineHighlightNormal = { bg = colors.green, fg = colors.mantle },
                        StatusLineHighlightVisual = { bg = colors.mauve, fg = colors.mantle },
                    }
                end,
            })
            vim.cmd.colorscheme("catppuccin-frappe")
        end,
    }
}

return M
