-- Undo
vim.opt.swapfile = false
vim.opt.backup = false
-- Long Lasting Undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undofile = true
