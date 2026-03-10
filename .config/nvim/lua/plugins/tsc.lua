return {
  "dmmulroy/tsc.nvim",
  config = function()
    require("tsc").setup({
      use_trouble_qflist = true,
      bin_path = "tsgo",
      auto_start_watch_mode = true,
    })
  end,
}
