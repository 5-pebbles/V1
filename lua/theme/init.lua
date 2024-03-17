local M = {
    -- Indent lines
    {
        {
            "lukas-reineke/indent-blankline.nvim",
            main = "ibl",
            opts = {
                scope = {
                    enabled = true,
                    show_start = false,
                    show_end = false,
                },
            }
        }
    },
    -- Headlines
    {
        "lukas-reineke/headlines.nvim",
        dependencies = "nvim-treesitter/nvim-treesitter",
        opts = {
            markdown = {
                headline_highlights = {
                    "Headline1",
                    "Headline2",
                    "Headline3",
                    "Headline4",
                    "Headline5",
                },
                codeblock_highlight = "CodeBlock",
                dash_highlight = "Dash",
                dash_string = "_",
                quote_highlight = "Quote",
                fat_headlines = true,
                fat_headline_upper_string = "▃",
                fat_headline_lower_string = "▀",
            },
        },
    },
}

local T = {}

local function merge(theme)
    table.insert(M, theme.plugin)
    for _, v in ipairs(theme.styles) do
        table.insert(T, v)
    end
end

merge(require("theme.onedark"))
merge(require("theme.catppuccin"))
merge(require("theme.nordic"))
merge(require("theme.gruvbox"))
merge(require("theme.bluloco"))
-- merge(require("theme.nord"))

table.sort(T, function(a, b) return a[1] < b[1] end)

require("theme.selector"):setup(T)

return M
