-- local dashbaord_header= [[
--  ____ ____ ____ ____ ____ ____ ____  _________  ____ ____ ____
-- ||N |||i |||k |||h |||i |||' |||s || |       || |P |||D |||E ||
-- ||__|||__|||__|||__|||__|||__|||__|| |_______|| |__|||__|||__||
-- |/__\|/__\|/__\|/__\|/__\|/__\|/__\| /_______\| /__\|/__\|/__\|
--  ]],

local quotes_module = require("utils.quotes")
local dashbaord_header = quotes_module.get_random_quote()

return {
  "folke/snacks.nvim",

  ---@type snacks.Config
  opts = {
    scroll = {
      enabled = false,
    },
    animate = {
      enabled = false,
    },
    statuscolumn = {
      enabled = true,
      right = { "fold", "git" }, -- priority of signs on the right (high to low)
      folds = {
        open = false, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50, -- refresh at most every 50ms
    },
    dashboard = {
      preset = {
        header = dashbaord_header,
        row = 5,
        keys = {
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
        },
      },
      formats = {
        header = { "%s", align = "center" },
      },
      sections = {
        { section = "header", align = "left" },
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
