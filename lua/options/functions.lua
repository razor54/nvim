_G.get_fold_text = function()
    local foldstart = vim.v.foldstart

    -- get text of first line of fold to use as preview
    local first_line_str = vim.api.nvim_buf_get_lines(
        0,
        foldstart - 1,
        foldstart,
        true
    )[1]

    -- if the text of the first line preview if longer than x chars
    if #first_line_str >= 60 then
        -- get only the first x chars
        first_line_str = string.sub(first_line_str, 1, 60) .. "… "
    end

    return string.format(
        "%s {%s more lines}",
        first_line_str,
        vim.v.foldend - foldstart
    )
end
