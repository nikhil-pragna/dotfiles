-- NVIM_LEAN=1 (set on low-RAM servers like the factory VPS) installs only a
-- TypeScript-focused parser set. LazyVim concatenates ensure_installed lists
-- across spec files, so the trimming MUST happen here at the source list.
local lean = vim.env.NVIM_LEAN == "1"

local full = {
  "bash",
  "css",
  "dockerfile",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "python",
  "toml",
  "typescript",
  "yaml",
  "dart",
  "elixir",
}

local minimal = {
  "bash",
  "lua",
  "json",
  "yaml",
  "markdown",
  "javascript",
  "typescript",
  "tsx",
}

return {
  "nvim-treesitter/nvim-treesitter",
  init = function() end,
  opts = {
    ensure_installed = lean and minimal or full,
  },
}
