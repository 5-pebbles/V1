local M = {
    "AlexvZyl/nordic.nvim",
    name = "nordic",
    lazy = false,
    priority = 1000,
    config = function()
        local palette = require("nordic.colors")
        local main_highlight = palette.green.base
        require("nordic").load({
            reduced_blue = false,
            -- swap_backgrounds = true,
            cursorline = {
                bg = main_highlight,
                blend = 0.9,
            },
            override = {
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

return M
