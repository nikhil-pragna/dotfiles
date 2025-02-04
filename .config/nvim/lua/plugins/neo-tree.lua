return {
  "nvim-neo-tree/neo-tree.nvim",
  init = function() end,
  opts = {
    window = {
      position = "right",
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          ".git",
          ".DS_Store",
        },
        always_show = {
          ".env",
        },
      },
    },
  },
}
