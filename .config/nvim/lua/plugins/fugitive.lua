return {
  "tpope/vim-fugitive",
  lazy = false,
  opts = {},
  config = function() end,
  keys = {
    {
      "<leader>gs",
      ":Git<cr><c-w>K",
      { desc = "Fugitive status" },
    },
  },
}
