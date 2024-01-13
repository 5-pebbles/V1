local M = {}

M.treesitters = { "markdown_inline" }

M.formatters = {}

M.plugins = {}

vim.api.nvim_create_autocmd("BufNew", {
    pattern = "*.md",
    once = true,
    callback = function()
        require("lang.utils").ensure_installed("marksman", function()
            local lspconfig = require("lspconfig")
            local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.marksman.setup({
                capabilities = lsp_capabilities,
                filetypes = { "markdown" },
            })
        end, 100000)
    end,
})

return M
