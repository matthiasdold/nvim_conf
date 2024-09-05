return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji", "onsails/lspkind.nvim" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      opts.auto_brackets = opts.auto_brackets or {}
      table.insert(opts.auto_brackets, "python")
      table.insert(opts.sources, { name = "emoji" })
      table.insert(opts.sources, { name = "copilot", group_index = 3 })
    end,
  },
}
