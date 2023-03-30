local max_filesize = _max_filesize

vim.api.nvim_create_autocmd(
    {"InsertLeave", "TextChanged"},
    {
        pattern = {"*"},
        command = "silent! wall",
        nested = true,
    }
)

vim.cmd("augroup hugefile")
vim.cmd("autocmd!")
vim.api.nvim_create_autocmd(
    {"BufReadPre"},
    {
        pattern = "*",
        callback = function (opt)
            local buf = vim.api.nvim_get_current_buf()
            local file = vim.api.nvim_buf_get_name(buf)
            local file_size = vim.fn.getfsize(file)
            if file_size < max_filesize then
                vim.cmd("CocEnable")
                vim.cmd("CocStart")
                vim.cmd("TSEnable highlight")
                vim.cmd("TSEnable rainbow")
            else
                vim.cmd("CocDisable")
            end
        end
    }
)
vim.cmd("augroup END")
