-- Create Directory on Buffer Write
function CreateDirForFilePath(filepath)
	local dir = vim.fn.fnamemodify(filepath, ":h")
	if dir ~= "" then
		vim.fn.mkdir(dir, "p")
	end
end
vim.cmd([[
 augroup CreateDirectories
   autocmd!
   autocmd BufWritePre * lua CreateDirForFilePath(vim.fn.expand("<afile>:p"))
 augroup END
]])
