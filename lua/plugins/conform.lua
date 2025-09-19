-- no longer using null-lsp, this should serve my autoformatting needs
return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    optional = false,
    init = function()
      --  Gemini merge of the original LazyVim config and the example on the conform.nvim github repo
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufEnter" }, {
        group = vim.api.nvim_create_augroup("ConformDisable", { clear = true }),
        callback = function(args)
          -- Disable autoformat on certain filetypes
          local ignore_filetypes = { "sql", "java" }
          if vim.tbl_contains(ignore_filetypes, vim.bo[args.buf].filetype) then
            vim.b[args.buf].disable_autoformat = true
            return
          end

          -- Disable autoformat for files in a certain path
          local bufname = vim.api.nvim_buf_get_name(args.buf)
          if bufname:match("/node_modules/") then
            vim.b[args.buf].disable_autoformat = true
            return
          end

          -- Re-enable it for other buffers, in case you disabled it manually
          -- You can remove this line if you want the disabled state to persist
          -- across buffers.
          vim.b[args.buf].disable_autoformat = nil
        end,
      })

      -- This part is from the original LazyVim config and should be kept
      LazyVim.on_very_lazy(function()
        LazyVim.format.register({
          name = "conform.nvim",
          priority = 100,
          primary = true,
          format = function(buf)
            require("conform").format({ bufnr = buf })
          end,
          sources = function(buf)
            local ret = require("conform").list_formatters(buf)
            ---@param v conform.FormatterInfo
            return vim.tbl_map(function(v)
              return v.name
            end, ret)
          end,
        })
      end)
    end,
    opts = {
      formatters = { -- Define a new formatter that uses ruff's linter to sort imports
        ruff_organize_imports = {
          -- This runs `ruff check --select I --fix`
          command = "ruff",
          args = { "check", "--select", "I", "--fix", "--exit-non-zero-on-fix", "-" },
          stdin = true,
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        python = { "ruff_organize_imports", "ruff_format" },
      },
    },
  },
}
