-- Cursor
vim.opt.guicursor = {
    ["n-v-c-i-ci-ve-r-cr-o"] = "block",
    ["a"] = "blinkwait2000-blinkoff400-blinkon250-Cursor/lCursor",
    ["sm"] = "block-blinkwait175-blinkoff150-blinkon175",
}

-- Autocomplete
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

-- Spelling
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Colors
vim.opt.termguicolors = true

-- Scroll
vim.opt.scrolloff = 8
vim.opt.signcolumn = "number"
vim.opt.isfname:append("@-@")

-- Misc
vim.opt.updatetime = 50
vim.opt.timeoutlen = 2500
vim.opt.colorcolumn = "0"

require("settings.undo")
require("settings.netrw")
require("settings.indent")
require("settings.linenr")
require("settings.statusline")
