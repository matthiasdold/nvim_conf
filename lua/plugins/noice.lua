-- noice.nvim is used by lazy on default. Using this for my own config.
return {
  {
    "folke/noice.nvim",
    enabled = false, -- disable and test if vim performance is better
    event = "VeryLazy",
    opts = {},
    config = function()
      require("noice").setup({
        cmdline = {
          view = "cmdline",
        },
      })
    end,
  },
}
