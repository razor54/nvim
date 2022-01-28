-- init

vim.cmd("colorscheme still_light")

local modules = {
    "options",
    "maps",
    "aucmd",
    "plugins",
    "cmd",
    "lsp",
}

for _, module in ipairs(modules) do
    require(module)
end

--[[
    news:
    merging filetype.nvim:
        -- https://www.reddit.com/r/neovim/comments/rvwsl3/introducing_filetypelua_and_a_call_for_help/
        -- https://github.com/nathom/filetype.nvim/issues/36
    merging impatient.nvim: https://github.com/neovim/neovim/pull/15436
    msg:
        -- https://github.com/neovim/neovim/pull/16480
        -- https://github.com/neovim/neovim/pull/16396
    anticonceal: https://github.com/neovim/neovim/pull/9496
    lua aucmds interface: https://github.com/neovim/neovim/pull/14661
]]
