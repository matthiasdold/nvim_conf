-- Some custom elements and highlights for the bufferline
return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        separator_style = "slope",
      },
      highlights = {
        background = { bg = "#2a2a37" },
        close_button = { bg = "#2a2a37" },
        close_button_visible = { bg = "#2a2a37" },
        buffer_selected = { bg = "#3a3a47", fg = "#ffffff", bold = true },
        buffer_visible = { bg = "#2a2a37" },
        close_button_selected = { bg = "#3a3a47" },
        separator = { bg = "#2a2a37", fg = "#1f1f28" },
        separator_selected = { bg = "#3a3a47", fg = "#1f1f28" },
        offset_separator = { bg = "#3a3a47", fg = "#1f1f28" },
        separator_visible = { bg = "#2a2a37", fg = "#1f1f28" },
        modified = { bg = "#2a2a37", fg = "#98BB66" },
        modified_visible = { bg = "#2a2a37", fg = "#98BB66" },
        modified_selected = { bg = "#3a3a47", fg = "#98BB66" },
        error_visible = { bg = "#2a2a37", fg = "#C75D6A" },
        error_selected = { bg = "#3a3a47", fg = "#C75D6A" },
        error = { bg = "#2a2a37", fg = "#C75D6A" },
        warning_visible = { bg = "#2a2a37", fg = "#ffa066" },
        warning_selected = { bg = "#3a3a47", fg = "#ffa066" },
        warning = { bg = "#2a2a37", fg = "#ffa066" },
        duplicate_selected = { bg = "#3a3a47", fg = "#cacaca" },
        duplicate_visible = { bg = "#2a2a37", fg = "#1f1f28" },
        duplicate = { bg = "#2a2a37", fg = "#1f1f28" },
      },
    },
  },
}
