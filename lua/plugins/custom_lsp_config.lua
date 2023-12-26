return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- My custom server setup
      servers = {
        clangd = {
          cmd = { "clangd", "--offset-encoding=utf-16" },
        },
      },
    },
  },
}
