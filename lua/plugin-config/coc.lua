vim.cmd([[
  let g:coc_global_extensions = ['coc-json', 'coc-clangd'] 

  autocmd CursorHold * silent call CocActionAsync('highlight')
  command! -nargs=0 Format :call CocActionAsync('format')

  inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<C-e>"
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
]])


