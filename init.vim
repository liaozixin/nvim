" vim.g euqivalent of let g:
" eg. vim.g.mapleader = "," is equivalent of let g:mapleader=","

" vim.opt.encoding = "utf-8" is equivalent of set encoding=utf-8
" vim.o for global options
" vim.wo for window options
" vim.bo for buffer options 
" vim.fn is a table representing function
" vim.api is colleciton of API functions
" for the most part, you just use vim.opt to set value
lua require('basic')
lua require('plugins')

lua require('plugin-config/nvim-treesitter')
lua require('plugin-config/nvim-lualine')
lua require('plugin-config/nvim-tree')
lua require('plugin-config/AutoPair')
lua require('plugin-config/coc')
lua require('plugin-config/bufferline')
lua require('plugin-config/asynctask')
lua require('plugin-config/taglist')

lua require('keymapping')

colorscheme vscode


