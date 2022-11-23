local api = vim.api
local file_path
local root
local len
local wins = {}
local bufs = {}
local border_wins = {}
local border_bufs = {}

local flags = {
    ".git",
    ".root",
}

local function close_win(handle)
    if handle and api.nvim_win_is_valid(handle) then
        api.nvim_win_close(handle, true)
    end
end

local function create_win()
    local edit_w = api.nvim_get_option("columns")
    local edit_h = api.nvim_get_option("lines")
    
    local win_h = 3 
end

local function if_root(path)
    for i = 1, #flags, 1 do
        local _path = path..flags[i]
        local open = io.open(_path, "r")
        if(open) then
            open:close()
            return true
        elseif(os.execute("cd".._path..">nul 2>nul") == 0) then
            return true
        end
    end
    return false
end

local function normalize_path()
    file_path = file_path .. [[\]]
    local separator = {}
    for i = 1, string.len(file_path) do
        local char = string.sub(file_path, i, i)
        if(char == [[\]]) then
            table.insert(separator, i)
        end
    end
    table.insert(separator, string.len(file_path))
    
    for i = #separator, 1, -1 do
        local path = string.sub(file_path, 1, separator[i])
        if(if_root(path)) then
            root = path
            break
        end
    end
    print(root)
end

local function create_file()
    file_path = vim.fn.expand('%:p:h')
    normalize_path() 

end

vim.api.nvim_create_user_command(
    'CreateFile',
    create_file,
    {bang = true, desc = 'create file'}
)
