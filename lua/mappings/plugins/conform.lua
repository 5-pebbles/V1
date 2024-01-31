-- Conform
vim.keymap.set({ "n", "v" }, "<leader>w", function()
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    })
end, { desc = "Format file or range (in visual mode)" })
