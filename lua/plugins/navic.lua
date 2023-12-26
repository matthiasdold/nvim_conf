-- navic is used in the LazyNvim lualine default, but it needs a few tweeks
return {
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require("lazyvim.util").lsp.on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = " ",
        highlight = false, -- disable to not interfer too much with the rest of lualine
        depth_limit = 5,
        icons = require("lazyvim.config").icons.kinds,
      }
    end,
  },
}
