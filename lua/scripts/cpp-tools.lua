local scripts_path = vim.fn.stdpath('config')
local api = vim.api
scripts_path = scripts_path..[[/lua/scripts]]
package.path = package.path..scripts_path..[[/?.lua]]
local buf_path
local home_path = os.getenv("HOMEPATH")
local system_drive = os.getenv("SYSTEMDRIVE")
home_path = system_drive..home_path
home_path = string.gsub(home_path, [[\]], [[/]])

local function create_file()
    buf_path = vim.fn.expand('%:p:h')
    buf_path = string.gsub(buf_path, [[\]], [[/]])
    buf_path = buf_path..[[/]]
    local win, border_win
    local buf, border_buf
    local buf = api.nvim_create_buf(false, true)
    local width = api.nvim_get_option("columns")
    local height = api.nvim_get_option("lines")
    local win_width = string.len(buf_path) + 6
    local win_height = 1
    local row = math.ceil((height - win_height) / 2 - 1)
    local col = math.ceil((width - win_width) / 2)
    local opts = {
        style = "minimal",
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col
    }
    local border_opts = {
        style = 'minimal',
        relative = 'editor',
        width = win_width + 2,
        height = win_height + 2,
        row = row - 1,
        col = col - 1
    }

    local border_buf = api.nvim_create_buf(false, true)
    local border = {}

    border[1] = '╔' ..'═'.. 'FileName' .. string.rep('═', win_width - 9) .. '╗'
    for i = 2, win_height + 2 do
        border[i] = '║' .. string.rep(' ', win_width) .. '║'
    end
    border[win_height + 2] = '╚' .. string.rep('═', win_width) .. '╝'
    
    api.nvim_buf_set_lines(border_buf, 0, 0, true, border)
    api.nvim_buf_set_lines(buf, 0, 0, true, {buf_path})
    api.nvim_buf_set_option(buf, 'modifiable', true)
    api.nvim_buf_set_option(border_buf, 'modifiable', true)

    local border_win = api.nvim_open_win(border_buf, true, border_opts)
    local win = api.nvim_open_win(buf, true, opts)

    api.nvim_input("$")
    api.nvim_input("a")

    api.nvim_buf_set_keymap(buf, 'i', "<CR>", 
        [[<cmd>lua require"scripts/cpp-tools".cpp_tools_create(]]..buf..","..win..","..border_win..[[)<CR>]],
        {nowait = true, noremap = true, silent = true}
    )
    api.nvim_buf_set_keymap(buf, 'n', "<ESC>", 
        [[<cmd>lua require"scripts/cpp-tools".cpp_tools_close_win(]]..win..","..border_win..[[)<CR>]],
        {nowait = true, noremap = true, silent = true}
    )
    api.nvim_buf_set_keymap(buf, 'i', "<Down>", 
        [[<cmd>lua require"scripts/cpp-tools".cpp_tools_ban_key()<CR>]],
        {nowait = true, noremap = true, silent = true}
    )
end

api.nvim_create_user_command(
    'CreateFile',
    create_file,
    {bang = true, desc = 'create file'}
)

local function cpp_tools_close_win(win, border_win)
    if win and vim.api.nvim_win_is_valid(win) then
        api.nvim_win_close(win, true)
    end
    if border_win and vim.api.nvim_win_is_valid(border_win) then
        api.nvim_win_close(border_win, true)
    end
end

local function cpp_tools_ban_key()
    return
end

local function cpp_tools_create(buf, win, border_win)
    input = api.nvim_get_current_line()
    if (input == buf_path) then
        print("Please input file name!")
        return 
    end
    local input_len = string.len(input)
--    print(input)
    local file_name = string.match(input, [[[^/][^/]+$]])
--    print(file_name)
    local dir = string.match(input,[[.+/]])
--    print(dir)

    os.execute("python "..scripts_path.."/create_dir.py "..dir)
    if (file_name == nil) then
        cpp_tools_close_win(win, border_win)
        return
    end

    if (string.match(file_name, "%.h") or string.match(file_name, "%.hpp")) then 
        local file = assert(io.open(input, 'w'))
        file:write("#pragma once\n")
        file:close()
        cpp_tools_close_win(win, border_win)
        api.nvim_command('edit '..input)
        api.nvim_input('<ESC>')
        api.nvim_input('o')
        api.nvim_input('<CR>')
    elseif (string.match(file_name, "%.c") or 
            string.match(file_name, "%.cpp") or 
            string.match(file_name, "%.cu")) then
        local file = assert(io.open(input, 'w'))
        file:close()
        cpp_tools_close_win(win, border_win)
        api.nvim_command('edit '..input)
    else
        local file = assert(io.open(input, 'w'))
        file:close()
        cpp_tools_close_win(win, border_win)
        api.nvim_command('edit '..input)
    end
end

return{
    cpp_tools_create = cpp_tools_create,
    cpp_tools_close_win = cpp_tools_close_win,
    cpp_tools_ban_key = cpp_tools_ban_key
}


