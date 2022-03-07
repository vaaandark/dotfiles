function RunCode()
  filetype = vim.o.filetype
  if (filetype == 'c') then
    vim.cmd([[
      :AsyncRun name=$(basename % .c); cc % -o /tmp/"$name"-$$ || exit 1; /tmp/"$name"-$$ "$@"; ret=$?; rm /tmp/"$name"-$$; exit $ret
    ]])
  elseif (filetype == 'cpp') then
    vim.cmd([[
      :AsyncRun name=$(basename % .cpp); xx % -o /tmp/"$name"-$$ || exit 1; /tmp/"$name"-$$ "$@"; ret=$?; rm /tmp/"$name"-$$; exit $ret
    ]])
  elseif (filetype == 'asm') then
    vim.cmd([[
      :AsyncRun name=$(basename % .asm); as --32 % -o /tmp/"$name"-$$.o || exit 1; ld -m elf_i386 /tmp/"$name"-$$.o -o /tmp/"$name"-$$ || exit 1; /tmp/"$name"-$$ "$@"; ret=$?; rm /tmp/"$name"-$$ /tmp/"$name"-$$.o; exit $ret
    ]])
  elseif (filetype == 'rust') then
    vim.cmd([[
      :AsyncRun name=$(basename % .rs); rustc % -o /tmp/"$name"-$$ || exit 1; /tmp/"$name"-$$ "$@"; ret=$?; rm /tmp/"$name"-$$; exit $ret
    ]])
  elseif (filetype == 'lua') then
    vim.cmd([[
      :AsyncRun lua %
    ]])
  elseif (filetype == 'lisp') then
    vim.cmd([[
      :AsyncRun clisp %
    ]])
  elseif (filetype == 'python') then
    vim.cmd([[
      :AsyncRun python %
    ]])
  end
end
