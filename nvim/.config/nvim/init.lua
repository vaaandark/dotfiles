require('default').setup()
require('keymaps').setup()
require('autocmd').setup()

-- use lasy.nvim to manage plugins
require('plugins').setup()

-- LSP
require('lsp').setup()
require('lsp_cmp').setup()
require('lsp_fmt').setup()

-- lualine
require('plugins.lualine').setup()

