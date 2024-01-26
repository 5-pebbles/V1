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

    local date_time = os.date("%I:%M %p %a %b %d")
    local line = " %<%f%( %m%)%( %r%) %= %[ 🌸 " ..
        date_time .. " %] %= " .. git_branch() .. " %y " .. mode_highlight() .. " %(  %P %) "
    return line
end

vim.opt.statusline = "%!v:lua.MyStatusline()"

-- Update the Statusline at the start of each minute
function UpdateStatusline()
    -- Calculate the remaining time until the next minute
    local now = os.time()
    local _, sec = math.modf(now)
    -- 61 not 60 or it will update before the minute changes
    local wait_time = 61 - sec

    local timer = vim.loop.new_timer()
    timer:start(wait_time * 1000, 60000, vim.schedule_wrap(function() vim.cmd("redrawstatus") end))
end

-- Call UpdateStatusline initially to set everything up
UpdateStatusline()
