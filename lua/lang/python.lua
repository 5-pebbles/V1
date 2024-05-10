local M = {}

M.treesitters = { "python" }

M.formatters = { "black" }

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.py",
    once = true,
    callback = function()
        require("lang.utils").ensure_installed("pyright", function()
            local lspconfig = require("lspconfig")
            local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.pyright.setup({
                capabilities = lsp_capabilities,
                filetypes = { "python" },
            })
        end, 100000)
    end,
})

return M
