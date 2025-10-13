return {
  {
    "olimorris/codecompanion.nvim",
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle CodeCompanion", mode = { "n", "v" } },
    },
    opts = {
      adapters = {
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend(
              "claude_code",
              { env = {
                CLAUDE_CODE_OAUTH_TOKEN = os.getenv("CLAUDE_CODE_TOKEN"),
              } }
            )
          end,
        },
      },
      strategies = {
        chat = {
          adapter = "claude_code",
          variables = {
            ["buffer"] = {
              opts = {
                default_params = "watch",
              },
            },
          },
        },
        inline = {
          adapter = "claude_code",
        },
      },
      extensions = {
        spinner = {},
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ravitemer/mcphub.nvim", -- MCP Hub integration
      "franco-ruggeri/codecompanion-spinner.nvim",
    },
  },
  -- Markdown rendering in the chat buffer
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },

  -- Cleaner diffs
  {
    "nvim-mini/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
}
