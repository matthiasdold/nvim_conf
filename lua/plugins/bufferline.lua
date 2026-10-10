-- Some custom elements and highlights for the bufferline.
--
-- The highlights are NOT set here: they depend on light/dark mode and are
-- applied by lua/config/theme.lua, which re-derives them whenever the
-- background changes. Setting them statically here would pin the bufferline to
-- dark colors and leave it unreadable in light mode.
return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        separator_style = "slope",
      },
    },
  },
}
