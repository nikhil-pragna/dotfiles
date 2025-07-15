return {
  "neovim/nvim-lspconfig",
  opts = {
    document_highlight = {
      enabled = false,
    },
    inlay_hints = { enabled = false },

    servers = {
      clangd = {
        settings = {
          IndentWidth = 4,
        },
      },
      lua_ls = {
        settings = {
          IndentWidth = 4,
        },
      },
      shopify_theme_ls = {
        cmd = { "shopify", "theme", "language-server" },
        filetypes = { "liquid", "json" },
        root_dir = require("lspconfig.util").root_pattern("shopify.yml", ".shopifyignore", "config.yml"),
      },
    },

    require("lspconfig").dartls.setup({
      cmd = { "dart", "language-server", "--protocol=lsp" },
    }),
  },
}
