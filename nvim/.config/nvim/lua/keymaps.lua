local keymaps = {}

keymaps.setup = function ()
  local api = vim.api

  -- leader
  vim.g.mapleader = " "

  -- quickly change buffer in the list
  -- show all open buffers and their status
  api.nvim_set_keymap('n', '<leader>bl', ':ls<CR>',
  {noremap = true, silent = true})
  -- move to the previous buffer
  api.nvim_set_keymap('n', '<leader>[', ':bprevious<CR>',
  {noremap = true, silent = true})
  -- move to the next buffer
  api.nvim_set_keymap('n', '<leader>]', ':bnext<CR>',
  {noremap = true, silent = true})
  -- move to the first buffer
  api.nvim_set_keymap('n', '<leader>bf', ':bfirst<CR>',
  {noremap = true, silent = true})
  -- move to the last buffer
  api.nvim_set_keymap('n', '<leader>bl', ':blast<CR>',
  {noremap = true, silent = true})
  -- close the current buffer and move to the previous one
  api.nvim_set_keymap('n', '<leader>bq', ':bp <BAR> bd #<CR>',
  {noremap = true, silent = true})

  -- quickly expand the editing file's dirctory
  api.nvim_set_keymap('c', '%%', "getcmdtype() == ':' ? expand('%:h').'/' : '%%'",
  {noremap = true, expr = true})

  -- make the search results centered
  api.nvim_set_keymap('n', 'n', 'nzz', {noremap = true, silent = true})
  api.nvim_set_keymap('n', 'N', 'Nzz', {noremap = true, silent = true})

  -- copy to system clipboard
  api.nvim_set_keymap('v', 'Y', '"+y', {noremap = true, silent = true})

  -- create a new tab
  api.nvim_set_keymap('n', 't', ':tabnew ',
  {noremap = true, silent = false})
  -- move to the previous tab
  api.nvim_set_keymap('n', '<leader>p', ':tabprevious<CR>',
  {noremap = true, silent = true})
  -- move to the next tab
  api.nvim_set_keymap('n', '<leader>n', ':tabnext<CR>',
  {noremap = true, silent = true})
  -- move to the first tab
  api.nvim_set_keymap('n', '<leader>tf', ':tabfirst<CR>',
  {noremap = true, silent = true})
  -- move to the last tab
  api.nvim_set_keymap('n', '<leader>tl', ':tablast<CR>',
  {noremap = true, silent = true})
end

return keymaps

