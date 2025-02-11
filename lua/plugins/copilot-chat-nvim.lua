return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {

      -- Prompts from here: https://github.com/CopilotC-Nvim/CopilotChat.nvim
      prompts = {
        Explain = {
          prompt = "> /COPILOT_EXPLAIN\n\nWrite an explanation for the selected code as paragraphs of text.",
        },
        Review = {
          prompt = "> /COPILOT_REVIEW\n\nReview the selected code.",
          -- see config.lua for implementation
        },
        Fix = {
          prompt = "> /COPILOT_GENERATE\n\nThere is a problem in this code. Rewrite the code to show it with the bug fixed.",
        },
        Optimize = {
          prompt = "> /COPILOT_GENERATE\n\nOptimize the selected code to improve performance and readability.",
        },
        Docs = {
          prompt = "> /COPILOT_GENERATE\n\nPlease add documentation comments to the selected code. If in python, use numpy convention.",
        },
        Tests = {
          prompt = "> /COPILOT_GENERATE\n\nPlease generate tests for my code.",
        },
        Commit = {
          prompt = "> #git:staged\n\nWrite commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
        },
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
