-- Lean profile for low-RAM servers (e.g. the `factory` VPS, 4GB).
-- Inert unless NVIM_LEAN=1 is set in the environment, so the Mac is unaffected.
-- Trims treesitter to a TypeScript-focused parser set and skips heavy/unused
-- Mason LSP installs (clangd, shopify, dartls).
if vim.env.NVIM_LEAN ~= "1" then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = {
        "bash",
        "lua",
        "json",
        "yaml",
        "markdown",
        "javascript",
        "typescript",
        "tsx",
      }
      return opts
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      -- don't let Mason pull these on the VPS; they're heavy or need external CLIs
      for _, server in ipairs({ "clangd", "shopify_theme_ls", "dartls" }) do
        opts.servers[server] = vim.tbl_deep_extend("force", opts.servers[server] or {}, { mason = false })
      end
      return opts
    end,
  },
}
