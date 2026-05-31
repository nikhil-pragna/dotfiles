return {
  "tpope/vim-fugitive",
  lazy = false,
  opts = {},
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("fugitive_status_top", { clear = true }),
      pattern = "fugitive",
      callback = function()
        vim.cmd("wincmd K")
      end,
    })
  end,
  keys = {
    {
      "<leader>gs",
      ":Git<cr>",
      { desc = "Fugitive status" },
    },
  },
}
