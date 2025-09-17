return {
  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup({
        highlight = "#9CABCA",
        animate = {
          enabled = false,
        },
      })
    end,
    event = { "WinNew" },
  },
}
