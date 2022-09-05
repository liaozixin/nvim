vim.cmd([[
  let g:coc_global_extensions = ['coc-json', 'coc-clangd', 'coc-pyright'] 

  autocmd CursorHold * silent call CocActionAsync('highlight')
  command! -nargs=0 Format :call CocActionAsync('format')
  autocmd FileType python let b:coc_root_patterns = ['.git', '.env']
]])


