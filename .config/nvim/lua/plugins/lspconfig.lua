-- Get all default runtime paths
local runtime_path = vim.api.nvim_get_runtime_file("", true)
-- Explicitly add the path where `lazy.nvim` installs plugins
table.insert(runtime_path, vim.fn.stdpath("data") .. "/lazy")

return {
  "neovim/nvim-lspconfig",
  opts = {
    document_highlight = {
      enabled = false,
    },
    inlay_hints = { enabled = false },

    servers = {
      clangd = {
        settings = {},
      },
      lua_ls = {
        settings = {
          Lua = {
            -- This is the key part for your question
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = runtime_path,
              checkThirdParty = true,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
      shopify_theme_ls = {
        cmd = { "shopify", "theme", "language-server" },
        filetypes = { "liquid", "json" },
        root_dir = require("lspconfig.util").root_pattern("shopify.yml", ".shopifyignore", "config.yml"),
      },
      dartls = {
        cmd = { "dart", "language-server", "--protocol=lsp" },
      },
    },
  },
}
