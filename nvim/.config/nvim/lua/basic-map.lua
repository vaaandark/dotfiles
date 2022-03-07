local api = vim.api

-- leader
vim.g.mapleader = " "

-- quickly change buffer in the list
api.nvim_set_keymap('n', '[b', ':bprevious<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', ']b', ':bnext<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', '[B', ':bfirst<CR>', { noremap = true, silent = true })
api.nvim_set_keymap('n', ']B', ':blast<CR>', { noremap = true, silent = true })

-- quickly expand the editing file's dirctory
api.nvim_set_keymap('c', '%%', "getcmdtype() == ':' ? expand('%:h').'/' : '%%'", { noremap = true, expr = true })

-- make the search results centered
api.nvim_set_keymap('n', 'n', 'nzz', { noremap = true, silent = true })
api.nvim_set_keymap('n', 'N', 'Nzz', { noremap = true, silent = true })

-- F5 to run
api.nvim_set_keymap('', '<F5>', ':lua RunCode() <CR>', { noremap = true })

-- NERDTree
api.nvim_set_keymap('n', '<C-n>', ':NERDTree<CR>', { noremap = true })
api.nvim_set_keymap('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true })
