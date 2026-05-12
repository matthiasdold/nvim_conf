-- https://github.com/zbirenbaum/copilot.lua
return {
  {
    "zbirenbaum/copilot.lua",
    requires = {
      "copilotlsp-nvim/copilot-lsp",
      init = function()
        vim.g.copilot_nes_debounce = 500
      end,
    },
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        -- enabled = not vim.g.ai_cmp,
        enabled = true,
        auto_trigger = true,
        virtual_text_hl = "Comment",
        keymap = {
          accept = false, -- handled by nvim-cmp / blink.cmp
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
      -- nes = {
      --   enabled = true, -- requires copilot-lsp as a dependency
      --   auto_trigger = true,
      --   keymap = {
      --     accept_and_goto = false,
      --     accept = "<Tab>",
      --     dismiss = false,
      --   },
      -- },
    },
  },
}
