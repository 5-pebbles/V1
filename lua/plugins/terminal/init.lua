local M = {
    "akinsho/toggleterm.nvim",
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
