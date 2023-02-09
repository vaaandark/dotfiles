local api = vim.api
api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<cr>',
                    {noremap = true})
api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<cr>',
                    {noremap = true})
api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<cr>',
                    {noremap = true})
api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<cr>',
                    {noremap = true})
