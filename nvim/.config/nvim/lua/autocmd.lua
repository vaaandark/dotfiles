-- auto commands

vim.cmd('autocmd FileType c set tabstop=4 | set shiftwidth=4')
vim.cmd('autocmd FileType arduino set tabstop=2 | set shiftwidth=2')
vim.cmd('autocmd FileType cpp set tabstop=2 | set shiftwidth=2')
vim.cmd('autocmd FileType python set tabstop=2 | set shiftwidth=2')
vim.cmd('autocmd FileType asm set tabstop=2 | set shiftwidth=2')
vim.cmd('autocmd FileType sh set tabstop=2 | set shiftwidth=2')
vim.cmd('autocmd FileType zsh set tabstop=2 | set shiftwidth=2')
vim.cmd('autocmd FileType lisp set tabstop=2 | set shiftwidth=2')
vim.cmd('autocmd FileType lua set tabstop=2 | set shiftwidth=2')

vim.cmd([[
augroup filetypedetect
  au! BufRead,BufNewFile *.h         setfiletype c
augroup END
]])
vim.cmd([[
autocmd BufReadPost * if line("'\"'") > 1 && line("'\'") <= line("$") | exe "normal! g'\"" | endif
]])
