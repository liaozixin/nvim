local fn = vim.fn

vim.g.Tlist_Exit_OnlyWindow = 1
vim.g.Tlist_Use_Right_Window = 1
vim.g.Tlist_Show_One_File = 1
vim.g.Tlist_GainFocus_On_ToggleOpen = 1

if(fn.has("win32")) then
  vim.g.Tlist_Ctags_Cmd = fn.stdpath('config')..[[\ctags\win\ctags.exe]]
end
