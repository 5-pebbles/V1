M =	{}

M.plugins = {
    -- Spelling
    {
		"f3fora/cmp-spell",
	},
}

vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

vim.cmd([[autocmd TermOpen * setlocal nospell]])

return M
