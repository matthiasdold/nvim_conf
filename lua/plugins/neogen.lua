-- Using neogen to auto generate docstrings
return {
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>dm",
        function()
          require("neogen").generate()
        end,
        desc = "Make documentation with neogen",
      },
    },
    opts = {
      options = {
        -- snipped_engine = "luasnip",
      },
      languages = {
        python = {
          template = {
            annotation_convention = "numpydoc",
          },
        },
      },
    },
  },
}
