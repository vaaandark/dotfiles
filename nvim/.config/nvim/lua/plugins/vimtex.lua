vim.cmd([[
  let g:vimtex_view_method = 'zathura'
  " see ":help vimtex-compiler".
  let g:vimtex_compiler_method = 'latexmk'
  let maplocalleader = ","
]])

local api = vim.api

api.nvim_set_keymap('n', '<leader>ll', ':w<CR>:VimtexCompile<CR>',
                    {noremap = true, silent = true})
api.nvim_set_keymap('n', '<leader>lc', ':VimtexClean<CR>',
                    {noremap = true, silent = true})
api.nvim_set_keymap('n', '<leader>lv', ':w<CR>:VimtexView<CR>',
                    {noremap = true, silent = true})
api.nvim_set_keymap('n', '<leader>lr', ':VimtexReload<CR>',
                    {noremap = true, silent = true})
api.nvim_set_keymap('n', '<leader>ls', ':VimtexStop<CR>',
                    {noremap = true, silent = true})
