local opts = { noremap = true, silent = false}

vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)
-- open neotree
vim.keymap.set('n', '\\', '<cmd> Neotree toggle<cr>', opts)

-- buffer switching
vim.keymap.set('n', '<TAB>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-TAB>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ":Bdelete!<CR>", opts)

vim.keymap.set('i', 'jj', "<Esc>", opts)
