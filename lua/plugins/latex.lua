-- LaTeX tooling that is not vimtex itself: the language server, treesitter
-- parsers and the project-local spell dictionary.
return {
  -- texlab drives \ref / \cite completion, cross-file symbol jumps and rename.
  -- Managed through mason, like the other servers.
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "texlab" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          -- Building is vimtex's job; texlab only provides language features.
          -- Leaving its builder unset avoids two compilers fighting over the
          -- same aux files.
          settings = {
            texlab = {
              build = { onSave = false },
              chktex = { onOpenAndSave = true, onEdit = false },
              diagnosticsDelay = 300,
            },
          },
          keys = {
            { "<leader>cb", "<cmd>LspTexlabBuild<cr>", desc = "Build (texlab)", ft = "tex" },
          },
        },
      },
    },
  },

  -- bibtex highlighting for .bib files; latex.so was already installed.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "bibtex", "latex" })
    end,
  },
}
