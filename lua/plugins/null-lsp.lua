-- Setup null-ls for formatting especially python code
return {
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      local nls_formatting = nls.builtins.formatting
      local formatting = {
        -- black's default line length is 88, but I want to stick with 80
        nls_formatting.black.with({ extra_args = { "--line-length", 79 } }),
        nls_formatting.prettier,
        nls_formatting.isort,
      }

      local nls_diagnostics = nls.builtins.diagnostics
      local diagnostics = {
        -- nls_diagnostics.flake8, -- done by ruff
        -- nls_diagnostics.ruff, -- done by ruff  -- ruff is activated as standalone LSP
        -- nls_diagnostics.pylint.with({
        --   diagnostic_config = {
        --     -- see :help vim.diagnostic.config()
        --     underline = true,
        --     virtual_text = true,
        --     signs = true,
        --     update_in_insert = false,
        --     severity_sort = true,
        --   },
        --   extra_args = { "--rcfile", "~/.config/.pylintrc" },
        -- }),
      }
      --
      -- local nls_ca = nls.builtins.code_actions
      -- local code_actions = {
      --   nls_ca.ruff,
      -- }

      if type(opts.sources) == "table" then
        opts.sources = vim.list_extend(opts.sources, formatting)
        opts.sources = vim.list_extend(opts.sources, diagnostics)
        -- opts.sources = vim.list_extend(opts.sources, code_actions)
      end

      opts.debug = true
    end,
  },
}
