-- noice.nvim is used by lazy on default. Using this for my own config.
return {
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        cmdline = {
          view = "cmdline",
        },
      })
    end,
  },
}
