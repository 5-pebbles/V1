-- Status Line
function MyStatusline()
    local function git_branch()
        local handle = io.popen("git rev-parse --abbrev-ref HEAD 2>/dev/null")

        if handle == nil then return "" end
        local result = handle:read("*a")
        handle:close()

        if result == "" then
            return ""
        else
            return " " .. result:match("([^\n]+)")
        end
    end

    local function mode_highlight()
        local mode = vim.api.nvim_get_mode().mode
        if mode == 'i' or mode == 't' then
            return "%#StatusLineHighlightInsert#"
        elseif mode == 'v' then
            return "%#StatusLineHighlightVisual#"
        else
            return "%#StatusLineHighlightNormal#"
        end
    end

    local win_id = vim.g.statusline_winid
    local buf_id = vim.api.nvim_win_get_buf(win_id)
    local buftype = vim.api.nvim_buf_get_option(buf_id, "buftype")
    if buftype == "terminal" then
        return "%#Terminal# %= " .. mode_highlight() .. " Terminal %#Terminal# %="
    else
        local date_time = os.date("%I:%M %p %a %b %d")
        local line = " %<%f%( %m%)%( %r%) %= %[ 🌸 " .. date_time .. " %] %= " .. git_branch() .. " %y " .. mode_highlight() .. " %(  %P %) "
        return line
    end
end

vim.opt.statusline = "%!v:lua.MyStatusline()"
