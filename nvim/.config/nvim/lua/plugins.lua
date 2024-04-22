local plugins = {}

plugins.setup = function ()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {
      'projekt0n/github-nvim-theme',
      lazy = false,
      priority = 1000,
      config = function()
        require('github-theme').setup()
        vim.cmd('colorscheme github_light')
      end,
    },
    {
      'mrcjkb/rustaceanvim',
      version = '^4', -- Recommended
      lazy = false, -- This plugin is already lazy
    },
    'Yggdroot/indentLine',
    'nvim-lualine/lualine.nvim',
    'kyazdani42/nvim-web-devicons',
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true,
      opts = {
        map_c_h = true,  -- Map the <C-h> key to delete a pair
        map_c_w = true, -- map <c-w> to delete a pair if possible
      }
    },
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp"
    },
    {
      'stevearc/conform.nvim',
      opts = {},
    },
  })
end

return plugins

