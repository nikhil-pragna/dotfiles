-- Key mappings configuration
-- Set up key mappings for vim-dadbod-ui
vim.api.nvim_set_keymap('n', '<leader>db', ':DBUI<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dbr', ':DBUIReload<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dbc', ':DBUIClose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dbt', ':DBUIToggle<CR>', { noremap = true, silent = true })

-- Optional: Additional configuration for vim-dadbod-completion
vim.cmd [[
  autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = { { name = 'vim-dadbod-completion' } } })
]]
