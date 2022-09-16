vim.cmd([[
  let g:coc_global_extensions = ['coc-json', 'coc-clangd', 'coc-pyright'] 

  autocmd CursorHold * silent call CocActionAsync('highlight')
  command! -nargs=0 Format :call CocActionAsync('format')

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd FileType python let b:coc_root_patterns = ['.git', '.env']

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocActionAsync('format')
  
  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end
]])


