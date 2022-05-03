local utils = require("maps.bindings.utils")

-- jump diagnostics
utils.fmap("n", "<up>", function()
    vim.diagnostic.goto_prev({ float = false })
end, {})

utils.fmap("n", "<down>", function()
    vim.diagnostic.goto_next({ float = false })
end, {})

-- rename
utils.fmap("n", "<leader>r", function()
    vim.lsp.buf.rename()
end, {})

-- show line diagnostics
utils.fmap("n", "<leader>vd", function()
    vim.diagnostic.open_float({
        height = 15,
        width = 50,
    })
end, {})

utils.fmap("n", "<leader>h", function()
    vim.lsp.buf.hover()
end, {})

-- utils.fmap("n", "<leader>s", function()
--     vim.lsp.buf.signature_help()
-- end, { buffer = true })
