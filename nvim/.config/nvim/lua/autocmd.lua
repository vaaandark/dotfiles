-- auto commands

vim.cmd([[
autocmd FileType c set tabstop=4 | set shiftwidth=4
autocmd FileType arduino set tabstop=2 | set shiftwidth=2
autocmd FileType cpp set tabstop=2 | set shiftwidth=2
autocmd FileType python set tabstop=2 | set shiftwidth=2
autocmd FileType asm set tabstop=2 | set shiftwidth=2
autocmd FileType sh set tabstop=2 | set shiftwidth=2
autocmd FileType zsh set tabstop=2 | set shiftwidth=2
autocmd FileType lisp set tabstop=2 | set shiftwidth=2
autocmd FileType lua set tabstop=2 | set shiftwidth=2

augroup filetypedetect
  au! BufRead,BufNewFile *.h         setfiletype c
augroup END

autocmd BufReadPost * if line("'\"'") > 1 && line("'\'") <= line("$") | exe "normal! g'\"" | endif

au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
]])
