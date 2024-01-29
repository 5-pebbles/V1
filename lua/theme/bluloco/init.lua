local M = {}

M.plugin = {
    'uloco/bluloco.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
        require("bluloco").setup({
            style       = "auto", -- "auto" | "dark" | "light"
            transparent = false,
            italics     = true,
            terminal    = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
            guicursor   = true,
        })
    end,
}

M.styles = {
    {
        "Bluloco",
        config = function()
            vim.cmd('colorscheme bluloco')
        end,
    },
}

return M
