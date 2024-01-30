local theme_path = vim.fn.stdpath("data") .. "/theme/current"

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
        "5-pebbles/headlines.nvim",
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

local function deep_copy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            v = deep_copy(v)
        end
        copy[k] = v
    end
    return copy
end

merge(require("theme.onedark"))
merge(require("theme.catppuccin"))
merge(require("theme.nordic"))
merge(require("theme.gruvbox"))
merge(require("theme.bluloco"))
-- merge(require("theme.nord"))

table.sort(T, function(a, b) return a[1] < b[1] end)

local function load_theme_data()
    local file = io.open(theme_path, "r")
    if not file then
        vim.g.theme = 1
        return
    end
    local content = file:read("*all")
    file:close()
    local num = tonumber(content)
    vim.g.theme = num or 1
end

load_theme_data()

function ThemeUpdate()
    T[vim.g.theme].config()
    local file = io.open(theme_path, "w+")
    if file then
        file:write(vim.g.theme)
        file:close()
    else
        local dir = theme_path:match("(.*/)")
        local _, err = os.execute("mkdir -p " .. dir)
        if err then
            print("Failed to create persistent theme directory: " .. err)
        end
        file = io.open(theme_path, "w+")
        if file then
            file:write(vim.g.theme)
            file:close()
        end
        print("Failed to save persistent theme.")
    end
end

function ThemeCycle(increment)
    vim.g.theme = (vim.g.theme + increment - 1) % #T + 1
end

function ThemeSelector()
    local filetype = vim.bo.filetype
    local window_id = vim.api.nvim_get_current_win()

    local Popup = require("nui.popup")

    local theme_width = 60 / #T
    local theme_margin = (100 - (theme_width * #T)) / (#T + 1)
    local theme_settings = {
        enter = false,
        focusable = false,
        relative = "editor",
        position = {
            row = "85%",
            col = "50%",
        },
        size = {
            height = 1,
            width = theme_width .. "%",
        },
        border = {
            style = "rounded",
            text = {
                bottom = " Custom ",
            },
        },
    }

    local themes = {}

    for i = 1, #T do
        local current = deep_copy(theme_settings)
        current.position.col = (theme_margin * i) + (theme_width * (i - 1)) + (theme_width * 0.5) .. "%"
        current.border.text.bottom = " " .. T[i][1] .. " "
        table.insert(themes, { settings = current, theme = Popup(current) })
    end

    function themes:set_active()
        for i, v in ipairs(self) do
            local current = v.settings
            if i == vim.g.theme then
                current.size.height = 4
            else
                current.size.height = 2
            end
            v.theme:update_layout(current)
        end
    end

    function themes:mount()
        for _, v in ipairs(self) do
            v.theme:mount()
        end
    end

    function themes:unmount()
        for _, v in ipairs(self) do
            v.theme:unmount()
        end
    end

    local header_text = " Theme Selector "
    local header = Popup({
        enter = true,
        relative = "editor",
        position = {
            row = "60%",
            col = "50%",
        },
        size = {
            height = 1,
            width = "35%",
        },
        buf_options = {
            modifiable = false,
            readonly = false,
        },
        border = {
            style = "rounded",
            text = {
                top = header_text,
            },
        },
    })
    header:map("n", "l", function()
        ThemeCycle(1)
        themes:set_active()
    end)
    header:map("n", "h", function()
        ThemeCycle(-1)
        themes:set_active()
    end)
    header:map("n", "<CR>", function()
        ThemeUpdate()
        if filetype == "markdown" then
            local current_id = vim.api.nvim_get_current_win()

            vim.api.nvim_set_current_win(window_id)
            require('headlines').refresh()
            vim.api.nvim_set_current_win(current_id)
        end
    end)
    header:map("n", "<esc>", function()
        header:unmount()
        themes:unmount()
    end)

    header:mount()

    themes:mount()

    themes:set_active()
end

vim.api.nvim_create_user_command("ThemeUpdate", ThemeUpdate, {})
vim.api.nvim_create_user_command("ThemeSelector", ThemeSelector, {})

return M
