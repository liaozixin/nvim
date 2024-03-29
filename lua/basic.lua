-- MAX file size & lines
_max_filesize = 100 * 1024
_max_filelines = 1500

--补全菜单
vim.opt.wildmenu = true

-- utf8
vim.opt.encoding = "UTF-8"
vim.opt.fileencoding = 'utf-8'

-- jk移动时保留光标上方8行
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- 相对行号
vim.opt.number = true
-- vim.opt.relativenumber = true

-- 高亮当前行
vim.opt.cursorline = true

-- 显示左侧图标指示列
vim.opt.signcolumn = "yes"

-- 缩进4空格等于1tab
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true 
vim.o.shiftwidth = 4

-- 新行对齐当前行，空格替代tab
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.autoindent =  true
vim.bo.autoindent = true
vim.o.smartindent = true

-- 搜索大小写不敏感,除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true

-- 边输入边搜索
vim.o.incsearch = true

-- 命令行高为2
vim.o.cmdheight = 2

-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true

--禁止折行
vim.o.wrap = false
vim.wo.wrap = false

-- 鼠标支持
vim.o.mouse = "a"

-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- 允许隐藏被修改的buffer
vim.o.hidden = true

-- 行尾可以跳转到下一行
vim.o.whichwrap = 'b,s,<,>,[,],h,l'

-- smaller updatetime
vim.o.updatetime = 300

-- split window 从下和右出现
vim.o.splitbelow = true
vim.o.splitright = true

-- 显示tabline
vim.o.showtabline = 2

--filetype
vim.o.filetype = true

-- 设置目录
--vim.o.autochdir = true
