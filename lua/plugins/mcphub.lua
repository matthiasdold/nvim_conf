return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub", -- Installs `mcp-hub` node binary globally
    opts = {
      -- MCP Hub configuration options
      -- Add your server configurations here
    },
  },
}
