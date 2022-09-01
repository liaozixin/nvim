-- keymap
local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = false}
keymap("n", "t", "<cmd>FloatermToggle<CR>", opts)
keymap("t", "T", [[<C-\><C-n><cmd>FloatermToggle<CR>]], opts)

