local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system(
                      {'git', 'clone', 
                      '--depth', '1', 
                      'https://github.com/wbthomason/packer.nvim', 
                      install_path})
end

vim.cmd[[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'Mofiqul/vscode.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'kyazdani42/nvim-web-devicons' -- optional, for file icons
  use 'nvim-lualine/lualine.nvim'
  use {
    'kyazdani42/nvim-tree.lua',
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use 'jiangmiao/auto-pairs'
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'skywind3000/asyncrun.vim'
  use 'skywind3000/asynctasks.vim'
  use 'voldikss/vim-floaterm'
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

  if packer_bootstrap then
    require('packer').sync()
  end
end)

