vim.g.mapleader = " "
vim.g.maplocalleader= " "

local keymap = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- to normal mode
keymap("i", "jj", "<ESC>", default_opts)

-- use "H" to line head
keymap("n", "H", "^", default_opts)

-- use "L" to line tail
keymap("n", "L", "$", default_opts)

-- up a line 
keymap("n", "<M-Up>", "kddpk", default_opts)

-- dowm a line
keymap("n", "<M-Down>", "ddp", default_opts)

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
keymap("i", "<C-s>", "<cmd>wa<CR>", default_opts)
keymap("n", "<C-s>", "<cmd>wa<CR>", default_opts)

