local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'iamcco/markdown-preview.nvim'
Plug 'skywind3000/vim-terminal-help'
Plug 'skywind3000/asyncrun'
Plug 'morhetz/gruvbox'
Plug 'lambdalisue/suda.vim'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-surround'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'goolord/alpha-nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'neovim/nvim-lspconfig'

vim.call('plug#end')

require('plugin/rainbow')
require('plugin/markdown-preview')
require('plugin/asyncrun')
require('plugin/suda')
require('plugin/alpha-nvim')
require('plugin/telescope')
require('plugin/vim-vsnip')
require('plugin/nvim-cmp')
require('plugin/lualine')

vim.cmd([[colorscheme gruvbox]])
