local M = {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            size = function()
                return vim.o.columns * 0.35
            end,
            persist_size = false,
            direction = "vertical",
            start_in_insert = false,

            highlights = {
                Normal = {
                    link = "Terminal"
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
