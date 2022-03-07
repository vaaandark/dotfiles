-- auto commands
local api = vim.api

vim.cmd('autocmd FileType c set tabstop=4 | set shiftwidth=4 | set noexpandtab')
vim.cmd('autocmd FileType sh set tabstop=2 | set shiftwidth=2')
vim.cmd('autocmd FileType zsh set tabstop=2 | set shiftwidth=2')
vim.cmd('autocmd FileType lisp set tabstop=2 | set shiftwidth=2')
vim.cmd('autocmd FileType lua set tabstop=2 | set shiftwidth=2')

vim.cmd([[
autocmd BufReadPost * if line("'\"'") > 1 && line("'\'") <= line("$") | exe "normal! g'\"" | endif
]])

-- Exit Vim if NERDTree is the only window remaining in the only tab.
vim.cmd([[
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
]])

-- Close the tab if NERDTree is the only window remaining in it.
vim.cmd([[
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
]])

-- If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
vim.cmd([[
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
]])
