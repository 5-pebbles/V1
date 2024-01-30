local theme_path = vim.fn.stdpath("data") .. "/theme/current"

M = {}

M.current_theme = 1
M.selector_themes = {}

function M:update()
    local function load_theme_data()
        local file = io.open(theme_path, "r")
        if not file then
            M.current_theme = 1
            return
        end
        local content = file:read("*all")
        file:close()
        local num = tonumber(content)
        M.current_theme = num or 1
    end

    if not M.current_theme then
        load_theme_data()
    end

    if #M.selector_themes == 0 then return end
    M.selector_themes[math.min(M.current_theme, #M.selector_themes)].config()
    local file = io.open(theme_path, "w+")
    if file then
        file:write(M.current_theme)
        file:close()
    else
        local dir = theme_path:match("(.*/)")
        local _, err = os.execute("mkdir -p " .. dir)
        if err then
            print("Failed to create persistent theme directory: " .. err)
        end
        file = io.open(theme_path, "w+")
        if file then
            file:write(M.current_theme)
            file:close()
        end
        print("Failed to save persistent theme.")
    end
end

function M:cycle(increment)
    M.current_theme = (M.current_theme + increment - 1) % #M.selector_themes + 1
end

function M:setup(themes)
    M.selector_themes = themes or M.selector_themes
end

function M:mount()
    local Popup = require("nui.popup")

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

    local selector_items = {}


    function selector_items:set_active()
        for i, v in ipairs(self) do
            local current = v.settings
            if i == M.current_theme then
                current.size.height = 4
            else
                current.size.height = 2
            end
            v.theme:update_layout(current)
        end
    end

    function selector_items:mount()
        for _, v in ipairs(self) do
            v.theme:mount()
        end
    end

    function selector_items:unmount()
        for _, v in ipairs(self) do
            v.theme:unmount()
        end
    end

    -- Selector background window info
    local background_filetype = vim.bo.filetype
    local background_window_id = vim.api.nvim_get_current_win()

    -- Selector item settings
    local selector_item_width = 60 / #M.selector_themes
    local selector_item_margin = (100 - (selector_item_width * #M.selector_themes)) / (#M.selector_themes + 1)
    local selector_item_settings = {
        enter = false,
        focusable = false,
        relative = "editor",
        position = {
            row = "85%",
            col = "50%",
        },
        size = {
            height = 1,
            width = selector_item_width .. "%",
        },
        border = {
            style = "rounded",
            text = {
                bottom = " Custom ",
            },
        },
    }

    -- Create selector items
    for i = 1, #M.selector_themes do
        local current = deep_copy(selector_item_settings)
        current.position.col = (selector_item_margin * i) + (selector_item_width * (i - 1)) + (selector_item_width * 0.5) ..
            "%"
        current.border.text.bottom = " " .. M.selector_themes[i][1] .. " "
        table.insert(selector_items, { settings = current, theme = Popup(current) })
    end

    -- Header and Keymaps
    local selector_header_text = " Theme Selector "
    local selector_header = Popup({
        enter = true,
        relative = "editor",
        position = {
            row = "65%",
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
                top = selector_header_text,
            },
        },
    })

    selector_header:map("n", "l", function()
        M:cycle(1)
        selector_items:set_active()
    end)

    selector_header:map("n", "h", function()
        M:cycle(-1)
        selector_items:set_active()
    end)

    selector_header:map("n", "<CR>", function()
        M:update()

        -- Headlines does not auto update
        if background_filetype == "markdown" then
            -- If you know a better way of doing this... Please make a pr or issue
            -- Save the current window
            local current_id = vim.api.nvim_get_current_win()

            -- Go to the background one
            vim.api.nvim_set_current_win(background_window_id)

            -- Refresh the headlines
            require('headlines').refresh()

            -- Back to the selector
            vim.api.nvim_set_current_win(current_id)
        end
    end)

    selector_header:map("n", "<esc>", function()
        selector_header:unmount()
        selector_items:unmount()
    end)

    -- Mount the header
    selector_header:mount()

    -- Mount the items
    selector_items:mount()

    -- Display the current select theme
    selector_items:set_active()
end

return M
