vim.g.mapleader = " "
vim.g.maplocalleader= " "

local keymap = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

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
