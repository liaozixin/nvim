local api = vim.api
local win, border_win
local buf
local user_input = nil
local path
local win_levels = 0

local Type = {
    "Class",
    "File"
}

local function close_win(handle)
    if handle and vim.api.nvim_win_is_valid(handle) then
        api.nvim_win_close(handle, true)
    end
end

local function create_win(w, h, title, modifiable, content)
    local win_buf = api.nvim_create_buf(false, true)
    local width = api.nvim_get_option("columns")
    local height = api.nvim_get_option("lines")

    local win_width = w
    local win_height = h

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

    border[1] = '╔' ..'═'.. title .. string.rep('═', win_width - 5) .. '╗'
    for i = 2, win_height + 2 do
        border[i] = '║' .. string.rep(' ', win_width) .. '║'
    end
    border[win_height + 2] = '╚' .. string.rep('═', win_width) .. '╝'
    
    vim.api.nvim_buf_set_option(win_buf, 'modifiable', true)
    api.nvim_buf_set_lines(border_buf, 0, 0, true, border)
    api.nvim_buf_set_lines(win_buf, 0, 0, true, content)
    vim.api.nvim_buf_set_option(win_buf, 'modifiable', modifiable)

    local border_win_handle = api.nvim_open_win(border_buf, true, border_opts)
    local win_handle = api.nvim_open_win(win_buf, true, opts)

    return win_buf,win_handle,border_win_handle
end

local set_mappings = function()
    local mappings = {
        ['<CR>'] = 'core()'
    }
    for k,v in pairs(mappings) do
        api.nvim_buf_set_keymap(buf, 'n', k, [[<cmd>lua require"scripts/create-files".]]..v..'<CR>', {
            nowait = true, noremap = true, silent = true
        })
    end
end

local file_type
local file_name

local core = function()
    user_input = api.nvim_get_current_line()
    

    for key, value in ipairs(Type) do
        if(user_input == value) then
            close_win(win)
            close_win(border_win)
            buf, win, border_win = create_win(30, 1, "Name", true, {})
            file_type = user_input
            set_mappings()
            print(file_type)
            return
        end
    end
    if(user_input) then
        file_name = user_input
        file_name = path .. "\\" .. file_name 
        print(file_name)
        file_name = nil
        file_type = nil
        close_win(win)
        close_win(border_win)
    end
end

local create_file = function()
    path = vim.fn.expand('%:p:h')
    buf, win, border_win = create_win(30, 2, "Type", false, Type)  
    set_mappings()

end

vim.api.nvim_create_user_command(
    'CreateFile',
    create_file,
    {bang = true, desc = 'create file'}
)

return{
    core = core
}
