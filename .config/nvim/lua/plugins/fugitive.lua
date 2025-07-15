return {
  "tpope/vim-fugitive",
  opts = {},
  config = function() end,
  keys = {
    {
      "<leader>gS",
      ":Git<cr><c-w>K",
      { desc = "Fugitive status" },
    },
  },
}
