local M = {}

local function merge(plugins)
    -- Iterate over each element in the table
    for _, value in ipairs(plugins) do
        -- Add each element from the table to M
        table.insert(M, value)
    end
end

-- Other plugins
merge(require("plugins"))
-- Lang
merge(require("lang"))
-- Theme
merge(require("theme"))

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(M)

-- Settings
require("settings")
require("mappings")
require("autocmds")

-- Set Theme
require("theme.selector"):update()


-- Spotify Tokens
-- CLIENT_ID = "d59290fe7c1645528981d230dfc2f2d4"
-- CLIENT_SECRET = "c222fb5b2d4949d6a79f5fe3ed7f7db5"
