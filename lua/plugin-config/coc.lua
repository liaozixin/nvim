vim.cmd([[
  let g:coc_global_extensions = ['coc-json', 'coc-clangd'] 

  autocmd CursorHold * silent call CocActionAsync('highlight')
  command! -nargs=0 Format :call CocActionAsync('format')
]])


