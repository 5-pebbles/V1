local M = {
    "navarasu/onedark.nvim",
    config = function()
        local style = "cool"
        local palette = require("onedark.palette")[style]

        require("onedark").setup({
            style = style,
            colors = {
                cyan = "#6CE9B5",
            },
            highlights = {
                ["StatusLine"] = { fg = palette.gray1, bg = palette.black },
                -- Markdown headers
                -- 1
                ["@text.title.1.markdown"] = { fg = palette.red, fmt = "bold" },
                ["@text.title.1.marker.markdown"] = { fg = palette.red, fmt = "bold" },
                -- 2
                ["@text.title.2.markdown"] = { fg = palette.green, fmt = "bold" },
                ["@text.title.2.marker.markdown"] = { fg = palette.green, fmt = "bold" },
                -- 3
                ["@text.title.3.markdown"] = { fg = palette.yellow, fmt = "bold" },
                ["@text.title.3.marker.markdown"] = { fg = palette.yellow, fmt = "bold" },
                -- 4
                ["@text.title.4.markdown"] = { fg = palette.blue, fmt = "bold" },
                ["@text.title.4.marker.markdown"] = { fg = palette.blue, fmt = "bold" },
                -- 5
                ["@text.title.5.markdown"] = { fg = palette.purple, fmt = "bold" },
                ["@text.title.5.marker.markdown"] = { fg = palette.purple, fmt = "bold" },
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
    end,
}

return M
