local blend = require("theme.utils").blend

local M = {}

M.plugin = {
    "luisiacc/gruvbox-baby",
}

M.styles = {
    {
        "Gruvbox",
        config = function()
            local palette = require("gruvbox-baby.colors").config()
            local headline = function(color)
                return { fg = color, bg = blend(color, palette.background, 0.07), fmt = "bold" }
            end

            vim.g.gruvbox_baby_telescope_theme = 1
            vim.g.gruvbox_baby_highlights = {
                FloatTitle = { link = "TelescopePromptTitle" },
                NormalFloat = { link = "TelescopePreviewNormal" },
                FloatBorder = { link = "TelescopePreviewBorder" },
                Headline1 = headline(palette.soft_yellow),
                Headline2 = headline(palette.red),
                Headline3 = headline(palette.pink),
                Headline4 = headline(palette.blue_gray),
                Headline5 = headline(palette.forest_green),
            }
            vim.cmd [[colorscheme gruvbox-baby]]
        end
    }
}

return M
