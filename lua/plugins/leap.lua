local M = {
    "ggandor/leap.nvim",
    config = function()
        local leap = require("leap")
        leap.create_default_mappings()
        leap.opts.safe_labels = {}
    end,
}

return M
