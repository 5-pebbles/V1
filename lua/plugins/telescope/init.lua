local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    config = function()
        local action_state = require("telescope.actions.state")
        local actions = require("telescope.actions")

        -- Delete
        local function delete_file(prompt_bufnr)
            local selection = action_state.get_selected_entry(prompt_bufnr)

            actions.close(prompt_bufnr)

            local answer = vim.fn.input("Remove " .. selection.value .. " y/N: ")

            local lower_answer = string.lower(answer)

            if lower_answer == "yes" or lower_answer == "y" then
                local scandir = function(directory)
                    local i, t, popen = 0, {}, io.popen
                    local pfile = popen('ls -a "' .. directory .. '"')
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
                    for _, i in ipairs(scandir(directory)) do
                        if i ~= "." and i ~= ".." then
                            return
                        end
                    end
                    os.remove(directory)
                    walk(directory)
                end

                -- Delete the file
                os.remove(selection.value)

                -- Get the directory of the file
                walk(selection.value)
            end


            vim.api.nvim_command("Telescope resume")
        end

        -- New Buffer
        local function create_file(prompt_bufnr)
            local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
            local prompt = current_picker:_get_prompt()

            actions.close(prompt_bufnr)

            local answer = vim.fn.input("Create File: ", prompt)

            local current_dir = vim.fn.expand("%:p:h")
            if answer:sub(1, 2) == "./" then
                answer = current_dir .. "/" .. answer:sub(3)
            end
            vim.api.nvim_command("e " .. answer)
        end

        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "%.git/.*", "%.vi/.*" },
                mappings = {
                    i = {
                        ["<C-d>"] = delete_file,
                        ["<C-n>"] = create_file,
                    },
                    n = {
                        ["<C-d>"] = delete_file,
                        ["<C-n>"] = create_file,
                    },
                },
                layout_config = {
                    prompt_position = "top",
                },
                sorting_strategy = "ascending",
            },
            pickers = {
                find_files = {
                    hidden = true,
                }
            },
        })
    end,
}

return M
