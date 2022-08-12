vim.g.asyncrun_mode = 'term'
vim.g.asyncrun_save = 1
vim.g.asyncrun_windows = 1

vim.api.nvim_set_keymap('', '<leader>rn', ':lua RunCode() <CR>', { noremap = true })
