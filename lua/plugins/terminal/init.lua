local M = {
    "akinsho/toggleterm.nvim",
    dependencies = {
        {
            "willothy/flatten.nvim",
            lazy = false,
            opts = function()
                ---@type Terminal?
                local saved_terminal

                return {
                    window = {
                        open = "alternate",
                    },
                    callbacks = {
                        should_block = function(argv)
                            return vim.tbl_contains(argv, "-b")
                        end,
                        pre_open = function()
                            local term = require("toggleterm.terminal")
                            local termid = term.get_focused_id()
                            saved_terminal = term.get(termid)
                        end,
                        post_open = function(bufnr, winnr, ft, is_blocking)
                            if is_blocking and saved_terminal then
                                saved_terminal:close()
                            else
                                vim.api.nvim_set_current_win(winnr)
                            end

                            -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
                            if ft == "gitcommit" or ft == "gitrebase" then
                                vim.api.nvim_create_autocmd("BufWritePost", {
                                    buffer = bufnr,
                                    once = true,
                                    callback = vim.schedule_wrap(function()
                                        vim.api.nvim_buf_delete(bufnr, {})
                                    end),
                                })
                            end
                        end,
                        block_end = function()
                            vim.schedule(function()
                                if saved_terminal then
                                    saved_terminal:open()
                                    saved_terminal = nil
                                end
                            end)
                        end,
                    },
                }
            end,
        }
    },
    config = function()
        require("toggleterm").setup({
            persist_size = false,
            direction = "float",
            start_in_insert = false,
            hide_numbers = true,

            highlights = {
                NormalFloat = {
                    link = 'NormalFloat'
                },
                FloatBorder = {
                    link = "FloatBorder",
                },
            },

            shade_terminals = false,

            winbar = {
                enabled = false,
                name_formatter = function(term) --  term: Terminal
                    return term.name
                end,
            },
        })
    end,
}

return M
