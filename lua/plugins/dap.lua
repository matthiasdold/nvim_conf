return {
  -- recommended requirement for nvim-dap-ui
  -- { "folke/neodev.nvim", opts = { library = { plugins = { "nvim-dap-ui" }, types = true } } },
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dt", "<Cmd>DapToggleBreakpoint<CR>", desc = "Toggle dap breakpoint" },
    },
  },
  -- for mason management of the dap clients
  {
    "jay-babu/mason-nvim-dap.nvim",
  },
  { "nvim-neotest/nvim-nio" },
  {
    "rcarriga/nvim-dap-ui",
    -- taken from here https://www.youtube.com/watch?v=4BnVeOUeZxc
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
  -- VERY important for being able to debug modules! -> see keymaps for starting my debugging
  -- [ ] Also install debugpy via Mason
  {
    "HiPhish/debugpy.nvim",
    keys = {
      {
        "<leader>dc",
        function()
          vim.cmd("Debugpy module " .. vim.fn.expand("%"):gsub("/", "."):gsub(".py", ""))
        end,
        desc = "Dap continue",
      },
    },
  },
}
