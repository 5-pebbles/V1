vim.api.nvim_create_autocmd({ 'filetype' },
    {
        pattern = 'harpoon',
        callback = function()
            vim.cmd([[highlight HarpoonBorder guibg=#313132]])
            vim.cmd([[highlight HarpoonWindow guibg=#313132]])
        end
    })
