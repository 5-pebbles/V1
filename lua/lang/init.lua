local M = {
    -- Auto Pairing
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    -- Mason
    {
        "williamboman/mason.nvim",
        config = function()
            -- import mason
            local mason = require("mason")

            -- enable mason and configure icons
            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({ automatic_installation = true })
        end,
    },
    -- LSPs
    {
        "neovim/nvim-lspconfig",
    },
    -- AutoCompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-buffer",
        },
        config = function()
            local cmp = require("cmp")

            -- `/` cmdline setup.
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- `:` cmdline setup.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    {
                        name = 'cmdline',
                        option = {
                            ignore_cmds = { 'Man', '!' }
                        }
                    }
                })
            })

            cmp.setup({
                enabled = function()
                    return true
                end,

                preselect = cmp.PreselectMode.None,

                window = {
                    documentation = {
                        scrollbar = true,
                        border = { '', '', '', ' ', ' ', ' ', ' ', ' ' },
                        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
                        scrolloff = 2,
                    },
                    completion = {
                        scrollbar = true,
                        border = { '', '', '', ' ', '', '', '', '' },
                        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
                        scrolloff = 2,
                    },
                },

                mapping = {
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ['<C-Space>'] = cmp.mapping.complete(),
                },

                formatting = {
                    fields = { 'abbr', 'kind' },
                    format = function(_, vim_item)
                        vim_item.menu = ""
                        return vim_item
                    end,
                },

                sources = cmp.config.sources({
                    {
                        name = "spell",
                        option = {
                            keep_all_entries = false,
                            enable_in_context = function()
                                -- disable completion in comments
                                local context = require("cmp.config.context")
                                -- keep command mode completion enabled when cursor is in a comment
                                if vim.api.nvim_get_mode().mode == "c" then
                                    return true
                                else
                                    -- check if the current file is a Markdown file
                                    local bufname = vim.api.nvim_buf_get_name(0)
                                    if bufname:match("%.md$") then
                                        return true
                                    else
                                        return context.in_treesitter_capture("comment")
                                            or context.in_syntax_group("Comment")
                                    end
                                end
                            end,
                        },
                    },
                    {
                        name = "nvim_lsp",
                        entry_filter = function(entry)
                            return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
                        end,
                    },
                    { name = "luasnip" },
                    { name = 'buffer', keyword_length = 3 },
                    { name = 'path' },
                }),
            })
        end,
    },
}


-- Treesitter
local T = {}
-- Formatters
local F = {}

local function activate(lang)
    -- Treesitter
    for _, v in ipairs(lang.treesitters or {}) do
        table.insert(T, v)
    end
    -- Formatters
    for i, v in pairs(lang.formatters or {}) do
        F[i] = v
    end
    -- Plugins
    for _, v in ipairs(lang.plugins or {}) do
        table.insert(M, v)
    end
end

-- English
activate(require("lang.english"))
-- Markdown
activate(require("lang.markdown"))
-- Lua
activate(require("lang.lua"))
-- Rust
activate(require("lang.rust"))
-- Docker
activate(require("lang.docker"))

-- Treesitter
table.insert(M, {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        vim.cmd("TSUpdate")

        require("nvim-treesitter.configs").setup({
            ensure_installed = T,

            auto_install = true,

            sync_install = false,

            highlight = {
                enable = true,
                custom_captures = {
                    ["markdownH1"] = "markdownH1",
                    ["_h1"] = "markdownH1",
                    ["markdownH2"] = "markdownH2",
                    ["_h2"] = "markdownH2",
                    ["h3"] = "markdownH3",
                    ["_h3"] = "markdownH3",
                    ["h4"] = "markdownH4",
                    ["_h4"] = "markdownH4",
                    ["h5"] = "markdownH5",
                    ["_h5"] = "markdownH5",
                },
                additional_vim_regex_highlighting = false,
            },
        })
    end,
})

-- Format
table.insert(M, {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("conform").setup({
            formatters_by_ft = F,
        })
    end,
})

-- User Commands

-- Toggle Diagnostics
vim.api.nvim_create_user_command("DiagnosticsToggle", function()
    local current_value = vim.diagnostic.is_disabled()
    if current_value then
        vim.diagnostic.enable()
    else
        vim.diagnostic.disable()
    end
end, {})

return M
