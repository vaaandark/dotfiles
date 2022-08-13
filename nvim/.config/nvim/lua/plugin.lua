--local Plug = vim.fn['plug#']
--
--vim.call('plug#begin', '~/.config/nvim/plugged')
--
--Plug 'jiangmiao/auto-pairs'
--Plug 'luochen1990/rainbow'
--Plug 'iamcco/markdown-preview.nvim'
--Plug 'skywind3000/vim-terminal-help'
--Plug 'skywind3000/asyncrun'
--Plug 'morhetz/gruvbox'
--Plug 'lambdalisue/suda.vim'
--Plug 'Yggdroot/indentLine'
--Plug 'tpope/vim-surround'
--Plug 'nvim-lualine/lualine.nvim'
--Plug 'kyazdani42/nvim-web-devicons'
--Plug 'goolord/alpha-nvim'
--Plug 'nvim-lua/plenary.nvim'
--Plug 'nvim-telescope/telescope.nvim'
--
--Plug 'neovim/nvim-lspconfig'
--Plug 'hrsh7th/cmp-nvim-lsp'
--Plug 'hrsh7th/cmp-buffer'
--Plug 'hrsh7th/cmp-path'
--Plug 'hrsh7th/cmp-cmdline'
--Plug 'hrsh7th/nvim-cmp'
--
--Plug 'hrsh7th/cmp-vsnip'
--Plug 'hrsh7th/vim-vsnip'
--
--Plug 'neovim/nvim-lspconfig'
--
--vim.call('plug#end')

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'jiangmiao/auto-pairs'
  use 'luochen1990/rainbow'
  use 'iamcco/markdown-preview.nvim'
  use 'skywind3000/vim-terminal-help'
  use 'skywind3000/asyncrun.vim'
  use 'morhetz/gruvbox'
  use 'lambdalisue/suda.vim'
  use 'Yggdroot/indentLine'
  use 'tpope/vim-surround'
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'goolord/alpha-nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

end)
