local M = {}

M.treesitters = { "lua" }

M.formatters = { lua = { "luaformatter" } }

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.lua",
    once = true,
    callback = function()
        require("lang.utils").ensure_installed("lua_ls", function()
            local lspconfig = require("lspconfig")
            local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.lua_ls.setup({
                capabilities = lsp_capabilities,
                filetypes = { "lua" },
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                }
            })
        end, 100000)
    end,
})

return M
