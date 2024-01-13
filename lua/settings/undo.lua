-- Undo
vim.opt.swapfile = false
vim.opt.backup = false
-- Long Lasting Undo
os.execute("mkdir -p ./.vi")
vim.opt.undodir = "./.vi"
vim.opt.undofile = true
