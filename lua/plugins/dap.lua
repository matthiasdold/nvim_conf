return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>db", "<Cmd>DapToggleBreakpoint<CR>", desc = "Toggle dap breakpoint" },
      { "<leader>dc", "<Cmd>DapContinue<CR>",         desc = "Dap Conitnue" },
      { "<leader>di", "<Cmd>DapStepInto<CR>",         desc = "DapStepInto" },
      { "<leader>do", "<Cmd>DapStepOut<CR>",          desc = "DapStepOut" },
      { "<leader>dv", "<Cmd>DapStepOver<CR>",         desc = "DapStepOver" },
      { "<leader>dt", "<Cmd>DapTerminate<CR>",        desc = "DapTerminate" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
-- {
--   ,
--   -- taken from here https://www.youtube.com/watch?v=4BnVeOUeZxc
-- -- VERY important for being able to debug modules! -> see keymaps for starting my debugging
-- -- [ ] Also install debugpy via Mason
-- {
--   "HiPhish/debugpy.nvim",
--   keys = {
--     {
--       "<leader>dc",
--       function()
--         vim.cmd("Debugpy module " .. vim.fn.expand("%"):gsub("/", "."):gsub(".py", ""))
--       end,
--       desc = "Dap continue",
--     },
--   },
-- },
