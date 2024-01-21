-- Undo
vim.opt.swapfile = false
vim.opt.backup = false
-- Long Lasting Undo
vim.opt.undodir = os.getenv("HOME") .. "/.vi"
vim.opt.undofile = true
