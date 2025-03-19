return {
  "saghen/blink.cmp",
  optional = true,
  dependencies = { "saghen/blink.compat" },
  opts = {
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    keymap = {
      ["<Tab>"] = {
        function(_)
          if require("minuet.virtualtext").action.is_visible() then
            print("accepting")
            vim.defer_fn(require("minuet.virtualtext").action.accept, 30)
            return true
          end
        end,
        "accept",
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },
  },
}
