-- Trying the config from here https://github.com/mfussenegger/nvim-dap/discussions/846
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "mason-org/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      { "<F7>", "<Cmd>DapToggleBreakpoint<CR>", desc = "Toggle dap breakpoint", mode = "n" },
      { "<F12>", "<Cmd>DapContinue<CR>", desc = "Dap Conitnue", mode = "n" },
      { "<F8>", "<Cmd>DapStepInto<CR>", desc = "DapStepInto", mode = "n" },
      { "<F9>", "<Cmd>DapStepOut<CR>", desc = "DapStepOut", mode = "n" },
      { "<F10>", "<Cmd>DapStepOver<CR>", desc = "DapStepOver", mode = "n" },
      { "<F6>", "<Cmd>DapStepBack<CR>", desc = "DapStepBack", mode = "n" },
      { "<leader>dr", "<Cmd>DapReplOpen<CR>", desc = "DapReplOpen", mode = "n" },
      { "<leader>dt", "<Cmd>DapTerminate<CR>", desc = "DapTerminate", mode = "n" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_python = require("dap-python")

      -- 1. DEFINE SIGNS (Added DapStopped so you see the current line)
      vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapStopped",
        { text = "", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "DiagnosticWarn" }
      )

      -- LSP might complain, but this still works, having the config here is good to have the hints for the shortcuts displayed alongside where the keymaps are defined
      dapui.setup({
        controls = {
          enabled = true,
          element = "repl", -- Use 'repl' or 'console' to choose where controls appear
          icons = {
            pause = "",
            play = " (F12)",
            step_into = " (F8)",
            step_over = " (F10)",
            step_out = " (F9)",
            step_back = " (F6)",
            run_last = "",
            terminate = " (<leader>dt)", -- \t adds a little spacing
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        -- You can customize the layout here if you want the REPL in a specific spot
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10,
          },
        },
      })

      -- 3. SETUP PYTHON
      -- Ensure path handling handles different OS or Standard paths if needed,
      -- but your existing logic is generally fine for Linux/Mac.
      local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
      local debugpy_path = mason_path .. "packages/debugpy/venv/bin/python"

      dap_python.setup(debugpy_path)
      dap_python.default_port = 38000

      -- 4. AUTO OPEN/CLOSE UI
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}

-- "mfussenegger/nvim-dap",
-- config = function() end,
--     -- dependencies = {
--     --   "rcarriga/nvim-dap-ui",
--     --   "jay-babu/mason-nvim-dap.nvim",
--     --   "theHamsta/nvim-dap-virtual-text",
--     --   "nvim-neotest/nvim-nio",
--     -- },
--     -- keys = {
--     --   { "<leader>db", "<Cmd>DapToggleBreakpoint<CR>", desc = "Toggle dap breakpoint" },
--     --   { "<leader>dc", "<Cmd>DapContinue<CR>", desc = "Dap Conitnue" },
--     --   { "<leader>di", "<Cmd>DapStepInto<CR>", desc = "DapStepInto" },
--     --   { "<leader>do", "<Cmd>DapStepOut<CR>", desc = "DapStepOut" },
--     --   { "<leader>dv", "<Cmd>DapStepOver<CR>", desc = "DapStepOver" },
--     --   { "<leader>dt", "<Cmd>DapTerminate<CR>", desc = "DapTerminate" },
--     -- },
--     -- config = function()
--     --   local dap = require("dap")
--     --
--     --   -- Adding setup for gdb << something like that
--     --   dap.configurations.cpp = {
--     --     {
--     --       name = "Launch",
--     --       type = "gdb",
--     --       request = "launch",
--     --       program = function()
--     --         return vim.fn.input({
--     --           prompt = "Path to executable: ",
--     --           default = vim.fn.getcwd() .. "/",
--     --           completion = "file",
--     --         })
--     --       end,
--     --       cwd = "${workspaceFolder}",
--     --       stopAtBeginningOfMainSubprogram = false,
--     --     },
--     --   }
--     --
--     --   local dapui = require("dapui")
--     --   dapui.setup()
--     --   dap.listeners.after.event_initialized["dapui_config"] = function()
--     --     dapui.open()
--     --   end
--     --   dap.listeners.before.event_terminated["dapui_config"] = function()
--     --     dapui.close()
--     --   end
--     --   dap.listeners.before.event_exited["dapui_config"] = function()
--     --     dapui.close()
--     --   end
--     -- end,
--   },
-- }
-- -- {
-- --   ,
-- --   -- taken from here https://www.youtube.com/watch?v=4BnVeOUeZxc
-- -- -- VERY important for being able to debug modules! -> see keymaps for starting my debugging
-- -- -- [ ] Also install debugpy via Mason
-- -- {
-- --   "HiPhish/debugpy.nvim",
-- --   keys = {
-- --     {
-- --       "<leader>dc",
-- --       function()
-- --         vim.cmd("Debugpy module " .. vim.fn.expand("%"):gsub("/", "."):gsub(".py", ""))
-- --       end,
-- --       desc = "Dap continue",
-- --     },
-- --   },
-- -- },
