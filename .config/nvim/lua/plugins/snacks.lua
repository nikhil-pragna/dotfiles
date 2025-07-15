return {
  "folke/snacks.nvim",
  opts = {
    scroll = {
      enabled = false,
    },
    dashboard = {
      preset = {
        header = [[ 
 ____ ____ ____ ____ ____ ____ ____  _________  ____ ____ ____ 
||N |||i |||k |||h |||i |||' |||s || |       || |P |||D |||E ||
||__|||__|||__|||__|||__|||__|||__|| |_______|| |__|||__|||__||
|/__\|/__\|/__\|/__\|/__\|/__\|/__\| /_______\| /__\|/__\|/__\|
 ]],
        row = 5,
        keys = {
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
        },
      },

      sections = {
        { section = "header" },
        { icon = " ", title = "Recent Files", section = "recent_files", cwd = true, indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "keys", gap = 1, padding = 1 },
      },
    },
    keys = {
      { "<leader>gs", nil },
    },
  },
}
