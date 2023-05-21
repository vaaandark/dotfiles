local set = vim.opt

-- editor behavior
set.number = true
set.relativenumber = true
set.cursorline = true
set.autoindent = true
set.compatible = false
set.backspace = {'indent', 'eol', 'start'}
-- set.clipboard = 'unnamedplus'
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.makeprg = './build.sh'
set.scrolloff = 3

set.syntax = 'on'
set.colorcolumn = '80'
vim.wo.signcolumn = 'yes'

vim.api.nvim_set_var("c_syntax_for_h", 1)
