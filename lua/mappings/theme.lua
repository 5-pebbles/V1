local theme_selector = require("theme.selector")

-- Themes
vim.keymap.set("n", "<leader>,", function() theme_selector:mount() end)
