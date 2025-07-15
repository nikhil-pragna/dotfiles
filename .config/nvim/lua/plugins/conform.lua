return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            c = { "clang_format" },
            lua = { "stylua" },
        },
        formatters = {
            clang_format = {
                prepend_args = { "-style={IndentWidth: 4}" },
            },
        },
    },
}
