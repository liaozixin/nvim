vim.g.mapleader = " "
vim.g.maplocalleader= " "

local keymap = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- source init.vim
keymap("n", "<F1>", "<cmd>source %<CR>", default_opts)

-- to normal mode
keymap("i", "jj", "<ESC>", default_opts)

-- use "H" to line head
keymap("n", "H", "^", default_opts)

--use "L" to line tail
keymap("n", "L", "$", default_opts)

-- up a line 
keymap("", "<M-Up>", "<cmd>LUpLines<CR>", default_opts)

-- dowm a line
keymap("", "<M-Down>", "<cmd>LDownLines<CR>", default_opts)

-- copy to system's clipboard
keymap("v", "<C-c>", [["*y]], default_opts)

-- paster from system's clipboard
keymap("v", "<C-v>", [["*p]], default_opts)

-- close hightlight
keymap("n", "<leader>", "<cmd>noh<cr>", default_opts)

-- next tab
keymap("n", "tl", "<cmd>tabn<CR>", default_opts)
-- prior tab
keymap("n", "th", "<cmd>tabp<CR>", default_opts)
-- close current tab
keymap("", "tc", "<cmd>tabclose<CR>", default_opts)

-- save all
keymap("i", "<C-s>", "<cmd>wa!<CR>", default_opts)
keymap("n", "<C-s>", "<cmd>wa!<CR>", default_opts)

-- nvim-tree
keymap('', "<C-n>", "<cmd>NvimTreeToggle<CR>", default_opts);

--bufferline
keymap('', '<M-Left>', ':BufferLineCyclePrev<CR>', default_opts)
keymap('', '<M-Right>', ':BufferLineCycleNext<CR>', default_opts)

--vim-floaterm
keymap("n", "t", "<cmd>wa!<CR><cmd>FloatermToggle<CR>", default_opts)
keymap("t", "T", [[<C-\><C-n><cmd>FloatermToggle<CR>]], default_opts)

--coc
vim.cmd([[
  inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<C-e>"
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

]])

--asynctasks
keymap('', '<F5>', "<cmd>AsyncTask compilefile-build<CR>", default_opts)
keymap('', '<F4>', "<cmd>AsyncTask file-build<CR>", default_opts)
keymap('', '<F9>', "<cmd>AsyncTask project-run<CR>", default_opts)

--taglist
keymap('n', '<F2>', "<cmd>TlistToggle<CR>", default_opts)

--easymotion
vim.cmd([[
    map  <Leader>w <Plug>(easymotion-bd-w)
    nmap <Leader>w <Plug>(easymotion-overwin-w)
]])

--telescope
keymap('n', 'ff', "<cmd>Telescope find_files<CR>", default_opts)

--CreateFile
keymap('n', 'cf', "<cmd>CreateFile<CR>", default_opts)
--vim-surround
--cs"' change " " to ' '
--ds" del " "
--ysiw] add [  ] to current world
--yss{ add {  } to current line






