local _M = {}
local buf_path = vim.fn.expand('%:p:h')

_M.create_file = function()
    print(buf_path)
end

return _M
