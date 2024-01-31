local M = {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-notify",
    },
    config = function()
        require("noice").setup({})
    end,
}

-- User CMDs
vim.api.nvim_create_user_command('Delete', function(opts)
    local args = opts.fargs
    local path = vim.fn.expand('%:p')
    local answer = vim.fn.input("Delete: " .. path .. " y/N: ")
    local lower_answer = string.lower(answer)

    if lower_answer ~= "yes" and lower_answer ~= "y" then
        print("Delete Failed")
        return
    end

    if #args > 0 and args[1] == '-r' then
        -- Delete the file and any empty directories in its path
        local scandir = function(directory)
            local i, t, popen = 0, {}, io.popen
            local pfile = popen('ls -A "' .. directory .. '"')
            if pfile == nil then
                return {}
            end
            for filename in pfile:lines() do
                i = i + 1
                t[i] = filename
            end
            pfile:close()
            return t
        end

        local function walk(directory)
            directory = directory:match("(.*)/[^/]+$")
            if #scandir(directory) ~= 0 then
                    return
            end
            os.remove(directory)
            walk(directory)
        end

        -- Delete the file
        os.remove(path)

        -- Get the directory of the file
        walk(path)
    else
        -- Delete the file
        os.remove(path)
    end
    print("Delete Successful")
end, { nargs = '*' })

return M
