return {
  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup({
        highlight = {
          fg = "#9CABCA",
        },
      })
    end,
    event = { "WinNew" },
  },
}
