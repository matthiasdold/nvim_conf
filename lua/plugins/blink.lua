return {
  "saghen/blink.cmp",
  optional = true,
  version = "*",
  dependencies = {
    "saghen/blink.compat",
    "rafamadriz/friendly-snippets",
  },
  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    keymap = {
      -- ["<Tab>"] = {
      --   function(_)
      --     if require("minuet.virtualtext").action.is_visible() then
      --       print("accepting")
      --       vim.defer_fn(require("minuet.virtualtext").action.accept, 30)
      --       return true
      --     end
      --   end,
      --   "accept",
      --   "snippet_forward",
      --   "fallback",
      -- },
      ["<Tab>"] = {
        -- This was used with copilot
        -- function(_)
        --   if require("copilot.suggestion").is_visible() then
        --     vim.defer_fn(require("copilot.suggestion").accept, 30)
        --     return true
        --   end
        -- end,
        function(_)
          if require("neocodeium").visible() then
            require("neocodeium").accept()
            return true
          end
        end,
        "accept",
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },
    fuzzy = { implementation = "lua" },
  },
}
