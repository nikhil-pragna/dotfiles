return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "biome" },
      javascriptreact = { "biome" },
      typescript = { "biome" },
      typescriptreact = { "biome" },
      json = { "biome" },
      jsonc = { "biome" },
    },
    formatters = {
      biome = {
        -- Prefer the project-local biome (matches the version in package.json),
        -- fall back to a global install on PATH.
        command = require("conform.util").find_executable({
          "node_modules/.bin/biome",
        }, "biome"),
        -- Only run when the project actually has a biome config.
        require_cwd = true,
        cwd = require("conform.util").root_file({ "biome.json", "biome.jsonc" }),
      },
    },
  },
}
