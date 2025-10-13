return {
  {
    "olimorris/codecompanion.nvim",
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle CodeCompanion", mode = "n" },
      {
        "<leader>aa",
        function()
          local start_line = vim.fn.line("v")
          local end_line = vim.fn.line(".")
          local bufname = vim.api.nvim_buf_get_name(0)
          local filename = vim.fn.fnamemodify(bufname, ":~:.")

          -- Ensure start_line is before end_line
          if start_line > end_line then
            start_line, end_line = end_line, start_line
          end

          local context = string.format("%s:%d-%d", filename, start_line, end_line)
          vim.cmd("CodeCompanionChat Toggle")
          vim.defer_fn(function()
            vim.api.nvim_feedkeys(context, "n", false)
          end, 100)
        end,
        desc = "CodeCompanion with selection context",
        mode = "v",
      },
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
      display = {
        chat = {
          separator = "─", -- Separator between messages (uses CodeCompanionChatSeparator highlight group)
          show_header_separator = true, -- Show separator lines between prompts and responses
          show_settings = true,
          show_token_count = true,
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
