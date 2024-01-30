local blend = require("theme.utils").blend
local M = {}

M.plugin = {
    "navarasu/onedark.nvim",
    config = function()
    end,
}

local function set_style(style)
    local palette = require("onedark.palette")[style]

    local headline = function(color)
        return { fg = color, bg = blend(color, palette.bg0, 0.07), fmt = "bold" }
    end

    require("onedark").setup({
        style = style,
        colors = {
            cyan = "#6CE9B5",
        },
        highlights = {
            ["StatusLine"] = { fg = palette.gray1, bg = palette.black },
            -- Markdown headers
            -- 1
            ["Headline1"] = headline(palette.red),
            -- 2
            ["Headline2"] = headline(palette.green),
            -- 3
            ["Headline3"] = headline(palette.cyan),
            -- 4
            ["Headline4"] = headline(palette.blue),
            -- 5
            ["Headline5"] = headline(palette.purple),
            -- Float
            ["FloatTitle"] = { fg = palette.black, bg = palette.green },
            ["NormalFloat"] = { bg = palette.black },
            ["FloatBorder"] = { fg = palette.black, bg = palette.black },
            -- Telescope
            ["TelescopeNormal"] = { bg = palette.black },
            ["TelescopeMultiSelection"] = { fg = palette.blue },
            ["TelescopeSelectionCaret"] = { fg = palette.red },
            -- Prompt
            ["TelescopePromptTitle"] = { fg = palette.black, bg = palette.red },
            ["TelescopePromptBorder"] = { fg = palette.black, bg = palette.black },
            ["TelescopePromptPrefix"] = { fg = palette.red },
            -- Results
            ["TelescopeResultsTitle"] = { bg = palette.black },
            ["TelescopeResultsBorder"] = { fg = palette.black, bg = palette.black },
            -- Preview
            ["TelescopePreviewTitle"] = { fg = palette.black, bg = palette.green },
            ["TelescopePreviewBorder"] = { fg = palette.black, bg = palette.black },
            -- ToggleTerm
            ["Terminal"] = { bg = palette.black },
            -- Nvim CMP
        },
        diagnostics = {
            darker = true,     -- darker colors for diagnostic
            undercurl = false, -- use undercurl instead of underline for diagnostics
            background = true, -- use background color for virtual text
        },
    })
    require("onedark").load()
    -- Leap
    vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = palette.gray })

    -- New
    vim.api.nvim_set_hl(0, "StatusLineHighlightNormal", { fg = palette.black, bg = palette.green })
    vim.api.nvim_set_hl(0, "StatusLineHighlightInsert", { fg = palette.black, bg = palette.red })
    vim.api.nvim_set_hl(0, "StatusLineHighlightVisual", { fg = palette.black, bg = palette.blue })
end

M.styles = {
    {
        "OneDark",
        config = function()
            set_style("deep")
        end,
    }
}

return M
