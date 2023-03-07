vim.notify = require("notify")

local scripts_path = vim.fn.stdpath('config')
local api = vim.api
scripts_path = scripts_path..[[/lua/scripts]]
package.path = package.path..scripts_path..[[/?.lua]]
local buf_path
local home_path = os.getenv("HOMEPATH")
local system_drive = os.getenv("SYSTEMDRIVE")
home_path = system_drive..home_path
home_path = string.gsub(home_path, [[\]], [[/]])

local ds = require("data_structure")
local tree = ds.tree:new(nil)
tree:initTree("root", 1)
local node = ds.tree:createNode("soon", 2)
tree:insertNode(node, "root")

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
        vim.notify(dir, "info",{
            title = "Create dir!",
        })
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
        vim.notify(input, "info",{
            title = "Create header file!"
        })
    elseif (string.match(file_name, "%.c") or 
            string.match(file_name, "%.cpp") or 
            string.match(file_name, "%.cu")) then
        file_name = string.match(file_name, [[[^\.]+]])
        local head_file_name = string.match(file_name, "^[%w_%s]+")
        local head_file_path = buf_path..head_file_name..".h"
        local head_file = io.open(head_file_path, "r")
        if (head_file) then
            head_file:close()
            local file = assert(io.open(input, 'w'))
            file:write([[#include "]]..file_name..[[.h"]].."\n")
            file:close()
            cpp_tools_close_win(win, border_win)
            api.nvim_command('edit '..input)
            api.nvim_input('<ESC>')
            api.nvim_input('o')
            api.nvim_input('<CR>')
            vim.notify(input, "info", {
                title = "Create source file!"
            })
            return
        end

        head_file_path = buf_path..head_file_name..".hpp"
        local head_file = io.open(head_file_path, "r")
        if (head_file) then
            head_file:close()
            local file = assert(io.open(input, 'w'))
            file:write([[#include "]]..file_name..[[.hpp"]].."\n")
            file:close()
            cpp_tools_close_win(win, border_win)
            api.nvim_command('edit '..input)
            api.nvim_input('<ESC>')
            api.nvim_input('o')
            api.nvim_input('<CR>')
            vim.notify(input, "info", {
                title = "Create source file!"
            })
            return
        end

        local file = assert(io.open(input, 'w'))
        file:close()
        cpp_tools_close_win(win, border_win)
        api.nvim_command('edit '..input)
        vim.notify(input, "info", {
            title = "Create source file!"
        })
    else
        local file = assert(io.open(input, 'w'))
        file:close()
        cpp_tools_close_win(win, border_win)
        api.nvim_command('edit '..input)
        vim.notify(input, "info", {
            title = "Create source file!"
        })
    end
end

local function imp_function()
    if (vim.fn.mode() ~= "V") then
        return
    end
    local file_full_name = vim.fn.expand("%:t")
    local file_name = string.match(file_full_name, [[[^%.]+]])
    local file_path = vim.fn.expand("%:p:h")
    local file_ex_name = string.match(file_full_name, "%.h%w*$")
    if (not file_ex_name) then
        vim.notify("","error",{
            title = "Not a c++ header file!"
        })
        return
    end

    local choose_begin = vim.fn.line("v")
    local choose_end = vim.fn.getcurpos()[2]
    if (choose_begin > choose_end) then
        local tem = choose_end
        choose_end = choose_begin
        choose_begin = tem
    end
    local func_info = {} 
    local file_info = {}


    

    -- for i = choose_begin, 1, -1 do
    --     local str = api.nvim_buf_get_lines(0, i - 1, i, null)[1]
    --
    --     if (string.match(str, [[^[%s_%w]*{]])) then
    --         cal_brace = cal_brace + 1
    --     elseif (string.match(str, [[[%s_%w]*}[;%s]*$]])) then
    --         cal_brace = cal_brace - 1
    --     end
    --     if (string.match(str, [[class%s+[%w_]+%s*$]]) or 
    --         string.match(str, [[class%s+[%w_]+%s*{%s*$]])) then 
    --         
    --         class_name = string.match(str, "[%w_]+%s*{*%s*$")
    --         class_name = string.match(class_name, "^[%w_]+")
    --         if (1 == cal_brace) then
    --             in_class = true
    --         end
    --         choose_begin = i
    --         break
    --     end
    -- end
    -- cal_brace = 0
    --
    -- for i = choose_begin, 1, -1 do
    --     local str = api.nvim_buf_get_lines(0, i - 1, i, null)[1]
    --     if (string.match(str, "[%s_%w]*{")) then
    --         cal_brace = cal_brace + 1
    --     elseif (string.match(str, "[%s_%w]*}[;%s]*$")) then
    --         cal_brace = cal_brace - 1
    --     end
    --     if (string.match(str, [[^namespace%s+[%w_]+%s*$]]) or 
    --         string.match(str, [[^namespace%s+[%w_]+%s*{%s*$]])) then 
    --         if (0 ~= cal_brace) then
    --             namespace_name = string.match(str, "[%w_]+%s*{*$")
    --             namespace_name = string.match(namespace_name, "^[%w_]+")
    --         end
    --     end
    -- end
    --
    -- print(namespace_name)
    --
    -- if (nil == class_name and in_class) then
    --     return
    -- end
    --
    -- local source_file_path = file_path.."/"..file_name..".cpp"
    -- local source_file = assert(io.open(source_file_path, "a+"))
    -- local content = source_file:read('*all')
    -- source_file:close()
    -- source_file = assert(io.open(file_path.."/"..file_name..".cpp", "w+"))
    -- if (not string.match(content, "#include%s*"..[[["<]+]]..file_full_name..[[[">]+]])) then
    --     content = "#include "..[["]]..file_full_name..[["]]..content
    -- end
    --
    --
    -- local functions = api.nvim_buf_get_lines(0, choose_begin - 1, choose_end, null)
    -- local func_imp
    -- local func_tmp
    -- for index, func in ipairs(functions) do
    --     if (string.match(func, "~*"..class_name..[[%([%w_,%s]*%);$]])) then
    --         func = string.match(func, "~*"..class_name..[[%([%w_,%s]*%)]])
    --         func_tmp = func
    --         func_tmp = string.gsub(func_tmp, "%(", "%%(")
    --         func_tmp = string.gsub(func_tmp, "%)", "%%)")
    --         if (not string.find(content, func_tmp)) then
    --             func_imp = class_name.."::"..func.."\n{\n\n}"
    --             content = content .. "\n\n" .. func_imp
    --         end
    --     elseif (string.match(func, "[%w_:]+%s".."[%w_]+".."%([%w_%s,]*%)%s*".."[%w]*;$")) then
    --         func = string.match(func, "[%w_:]+%s".."[%w_]+".."%([%w_%s,]*%)%s*".."[%w]*")
    --
    --         func_tmp = func
    --         func_tmp = string.gsub(func_tmp, "%(", "%%(")
    --         func_tmp = string.gsub(func_tmp, "%)", "%%)")
    --
    --         local return_type_begin, return_type_end = string.find(func_tmp, "^[%w_:]+%s")
    --         local return_type = string.sub(func_tmp, return_type_begin, return_type_end)
    --         func_tmp = string.sub(func_tmp, return_type_end, -1)
    --         func_tmp = string.gsub(func_tmp, "^%s", "")
    --         
    --         if (not string.find(content, return_type..class_name.."::"..func_tmp)) then
    --             func = string.sub(func, return_type_end, -1)
    --             func = string.gsub(func, "^%s", "")
    --             func_imp = return_type..class_name.."::"..func.."\n{\n\n}"
    --             content = content .. "\n\n" .. func_imp
    --         end
    --     end
    -- end
    -- source_file:write(content)
    -- source_file:close()
    -- api.nvim_command('vs '..source_file_path)
end

local function switch_head_source()
    local file_full_name = vim.fn.expand("%:t")
    local file_name = string.match(file_full_name, [[[^%.]+]])
    local file_path = vim.fn.expand("%:p:h")
    local file_ex_name = string.match(file_full_name, "%.%w*$")
    if (string.match(file_ex_name, "^%.h%w*$")) then
        local source_file_path = file_path .. "/" .. file_name .. ".cpp"
        local source_file = io.open(source_file_path, "r")
        if (source_file) then
            api.nvim_command('edit '..source_file_path)
            source_file:close()
            return
        end
        source_file_path = file_path .. "/" .. file_name .. ".c"
        source_file = io.open(source_file_path, "r")
        if (source_file) then
            api.nvim_command('edit '..source_file_path)
            source_file:close()
            return
        end
    elseif (string.match(file_ex_name, "^.c%w*$")) then
        local head_file_path = file_path .. "/" .. file_name .. ".hpp"
        local head_file = io.open(head_file_path, "r")
        if (head_file) then
            api.nvim_command('edit '..head_file_path)
            head_file:close()
            return
        end
        head_file_path = file_path .. "/" .. file_name .. ".h"
        head_file = io.open(head_file_path, "r")
        if (head_file) then
            api.nvim_command('edit '..head_file_path)
            head_file:close()
            return
        end
    end
end

api.nvim_create_user_command(
    'SwitchHS',
    switch_head_source,
    {bang = true, desc = 'switch head file and source file'}
)

api.nvim_create_user_command(
    'CreateFile',
    create_file,
    {bang = true, desc = 'create file'}
)

api.nvim_create_user_command(
    "ImpFunction",
    imp_function,
    {bang = true, desc = 'Imp CPP Function'}
)

return{
    cpp_tools_create = cpp_tools_create,
    cpp_tools_close_win = cpp_tools_close_win,
    cpp_tools_ban_key = cpp_tools_ban_key
}


