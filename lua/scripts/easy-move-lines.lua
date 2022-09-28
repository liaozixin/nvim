local mode
local buf 

local get_select_lines = function(buf)
    local lines_end = vim.fn.getcurpos()[2]
    local lines_begin = vim.fn.line("v")
    local lines_num
    if(lines_begin > lines_end) then
        local tem = lines_end
        lines_end = lines_begin
        lines_begin = tem
    end
    lines_num = lines_end - lines_begin
    local lines_str = vim.api.nvim_buf_get_lines(buf, lines_begin - 1, lines_end, null) 
    return {lines_begin, lines_end, lines_str, lines_num}
end

local up_lines = function()
    mode = vim.fn.mode()
    buf = vim.api.nvim_get_current_buf()
    if(mode == "V") then
        local lines_range = get_select_lines(buf)
                
        if(lines_range[1] - 2 == 0) then
            vim.api.nvim_buf_set_lines(buf, lines_range[1]-1, lines_range[2], null, {})
            vim.api.nvim_buf_set_lines(buf, lines_range[1]-2, lines_range[1]-2, null, lines_range[3])
            vim.api.nvim_input("<ESC>")
            for i=0,lines_range[4] * 2 + 1,1 do
                vim.api.nvim_input("k")
            end
            vim.api.nvim_input("V")
            for i=0,lines_range[4] - 1,1 do
                vim.api.nvim_input("j")
            end
        elseif(lines_range[1] - 2 > 0) then
            vim.api.nvim_input("d")
            vim.api.nvim_input("kk")        
            vim.api.nvim_input("p")        
            vim.api.nvim_input("<ESC>")
            vim.api.nvim_input("V")
            for i=0,lines_range[4] - 1,1 do
                vim.api.nvim_input("j")
            end
        end

    end
    if(mode == "n") then
        vim.api.nvim_input("k")
        vim.api.nvim_input("dd")
        vim.api.nvim_input("p")
        vim.api.nvim_input("k")
    end
    if(mode == "i") then
        vim.api.nvim_input("<ESC>")
        vim.api.nvim_input("k")
        vim.api.nvim_input("dd")
        vim.api.nvim_input("p")
        vim.api.nvim_input("k")
    end
end

local down_lines = function()
    mode = vim.fn.mode()
    buf = vim.api.nvim_get_current_buf()
    if(mode == "V") then
        local lines_range = get_select_lines(buf)
        vim.api.nvim_input("d")
        vim.api.nvim_input("p")
        vim.api.nvim_input("V")
        for i=0,lines_range[4] - 1,1 do
            vim.api.nvim_input("j")
        end
    end
    if(mode == "n") then
        vim.api.nvim_input("dd")
        vim.api.nvim_input("p")
    end
    if(mode == "i") then
        vim.api.nvim_input("<ESC>")
        vim.api.nvim_input("dd")
        vim.api.nvim_input("p")
    end
end

vim.api.nvim_create_user_command(
    'LUpLines',
    up_lines,
    {bang = true, desc = 'Up select lines'}
)

vim.api.nvim_create_user_command(
    'LDownLines',
    down_lines,
    {bang = true, desc = 'Down select lines'}
)

