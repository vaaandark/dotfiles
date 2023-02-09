local api = vim.api
api.nvim_set_keymap('n', '<leader>j', ':Gitsigns next_hunk<CR>',
                    {noremap = true})
api.nvim_set_keymap('n', '<leader>k', ':Gitsigns prev_hunk<CR>',
                    {noremap = true})
