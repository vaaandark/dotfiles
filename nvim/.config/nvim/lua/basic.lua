local set = vim.opt

-- editor behavior
set.number = true
set.relativenumber = true
set.cursorline = true
set.autoindent = true
set.compatible = false
set.backspace = {'indent', 'eol', 'start'}
-- set.clipboard = 'unnamedplus'
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.scrolloff = 3

set.syntax = 'on'
set.colorcolumn = '80'
vim.wo.signcolumn = 'yes'

vim.api.nvim_set_var("c_syntax_for_h", 1)
vim.cmd('colorscheme github_light')
