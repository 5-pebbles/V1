local M = {}

M.treesitters = { "rust" }

M.formatters = { rust = { "rustfmt" } }

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.rs",
    once = true,
    callback = function()
        require("lang.utils").ensure_installed("rust_analyzer", function()
            local lspconfig = require("lspconfig")
            local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.rust_analyzer.setup({
                capabilities = lsp_capabilities,
                filetypes = { "rust" },
            })
        end, 100000)
    end,
})

return M
