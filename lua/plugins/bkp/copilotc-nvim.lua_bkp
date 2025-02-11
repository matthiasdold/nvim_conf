-- Github Copilot chat
-- https://github.com/jellydn/lazy-nvim-ide/blob/main/lua/plugins/extras/copilot-chat-v2.lua
-- local IS_DEV = false
--
-- local prompts = {
--   -- Code related prompts
--   Explain = "Please explain how the following code works.",
--   Review = "Please review the following code and provide suggestions for improvement.",
--   Tests = "Please explain how the selected code works, then generate unit tests for it.",
--   Refactor = "Please refactor the following code to improve its clarity and readability.",
--   FixCode = "Please fix the following code to make it work as intended.",
--   FixError = "Please explain the error in the following text and provide a solution.",
--   BetterNamings = "Please provide better names for the following variables and functions.",
--   Documentation = "Please provide documentation for the following code.",
--   SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
--   SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
--   -- Text related prompts
--   Summarize = "Please summarize the following text.",
--   Spelling = "Please correct any grammar and spelling errors in the following text.",
--   Wording = "Please improve the grammar and wording of the following text.",
--   Concise = "Please rewrite the following text to make it more concise.",
-- }

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = "CopilotChat",
    opts = function()
      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      return {
        auto_insert_mode = true,
        question_header = "  " .. user .. " ",
        answer_header = "  Copilot ",
        window = {
          width = 0.4,
        },
      }
    end,
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      -- Show prompts actions with telescope
      { "<leader>ap", M.pick("prompt"), desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
        end,
      })

      chat.setup(opts)
    end,
  },
}
