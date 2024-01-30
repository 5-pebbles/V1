local blend = require("theme.utils").blend
local M = {}

M.plugin = {
    "AlexvZyl/nordic.nvim",
    name = "nordic",
    lazy = false,
    priority = 1000,
    config = function()
        local palette = require("nordic.colors")
        local main_highlight = palette.orange.base

        local headline = function(color)
            return { fg = color, bg = blend(color, palette.gray0, 0.07), bold = true }
        end

        require("nordic").setup({
            reduced_blue = false,
            -- swap_backgrounds = true,
            cursorline = {
                bg = main_highlight,
                blend = 0.9,
            },
            override = {
                -- Headlines
                Headline1 = headline(palette.orange.base),
                Headline2 = headline(palette.red.base),
                Headline3 = headline(palette.green.base),
                Headline4 = headline(palette.cyan.base),
                Headline5 = headline(palette.magenta.base),
                -- Line Numbers
                LineNr = { fg = main_highlight, bold = true },
                LineNrAbove = { fg = palette.gray2, bold = false },
                LineNrBelow = { fg = palette.gray2, bold = false },
                -- UI
                NormalFloat = { link = "TelescopeNormal" },
                FloatTitle = { link = "TelescopeTitle" },
                FloatBorder = { link = "TelescopePreviewBorder" },
                -- StatusLine
                StatusLine = { fg = palette.gray2, bg = palette.black0 },
                StatusLineHighlight = { fg = palette.gray2, bg = main_highlight },
                StatusLineSep = { fg = main_highlight, bg = palette.black0 },
                -- MsgArea
                MsgArea = { link = "StatusLine" },
            },
        })
    end,
}

M.styles = {
    {
        "Nordic",
        config = function()
            require("nordic").load()
        end,
    }
}

return M
