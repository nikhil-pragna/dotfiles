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
      })
    end,
  },
}
