local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    config = function()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "%.git/.*" },
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
