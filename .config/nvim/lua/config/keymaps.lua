-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open NetRw" })

-- move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z", { silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste wihthout copy" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "copy to sytem clipboard" })

vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "copy line to sytem clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { silent = true })

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "Format buffer (LSP)" })

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- remapped for navigation, find other keymaps for navigating quick fix list
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>rn", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- vim.keymap.set("n", "<leader>s", function()
--   vim.cmd("so")
-- end)

-- Plugin Keymaps
vim.keymap.set("n", "<leader>U", vim.cmd.UndotreeToggle)

-- -- Unset swapping lines, tmux send <esx> j as A-j
vim.keymap.del("i", "<A-j>")
vim.keymap.del("i", "<A-k>")
vim.keymap.del("n", "<A-j>")
vim.keymap.del("n", "<A-k>")

-- Delete the stupid previous and next buffers from LazyVim
vim.keymap.del("n", "<S-l>")
vim.keymap.del("n", "<S-h>")
