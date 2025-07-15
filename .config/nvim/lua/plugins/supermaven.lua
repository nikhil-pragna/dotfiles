return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      -- setup keymaps
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<c-g>",
          clear_suggestion = "<c-\\>",
          accept_word = "<c-y>",
        },
        vim.api.nvim_set_keymap("n", "<leader>tc", "<cmd>SupermavenToggle<cr>", { noremap = true, silent = true }),
      })
    end,
  },
}
