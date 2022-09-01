vim.opt.termguicolors = true
require("bufferline").setup{
    options = {
        diagnostics = "coc",

        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
            }
        }
    }
}
local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
keymap('', '<M-Left>', ':BufferLineCyclePrev<CR>', opts)
keymap('', '<M-Right>', ':BufferLineCycleNext<CR>', opts)
