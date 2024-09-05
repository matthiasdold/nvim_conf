-- no longer using null-lsp, this should serve my autoformatting needs
return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    optional = true,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        python = { "black", "isort" },
      },
    },
  },
}
