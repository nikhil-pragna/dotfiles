-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_user_command("SessionRestore", function()
  require("persistence").load({ last = true })
end, { desc = "Restore last session" })
