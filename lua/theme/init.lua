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
    require("theme.onedark")
}

return M
