return {
  {
    "lervag/vimtex",
    init = function()
      -- Skim is the right viewer on macOS: it auto-reloads on recompile and
      -- supports synctex inverse search (Cmd-Shift-click -> jump to source).
      -- zathura is installed via brew but has no inverse search without X11.
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_view_skim_sync = 1 -- refresh Skim after a rebuild
      vim.g.vimtex_view_skim_activate = 1 -- focus Skim when viewing
      vim.g.vimtex_view_skim_reading_bar = 1 -- highlight the synced line

      vim.g.vimtex_quickfix_mode = 0 -- suppress error reporting on save and build
      vim.g.vimtex_mappings_enabled = 1 -- vimtex motions/text objects (]], ace, ie, dse)
      vim.g.vimtex_indent_enabled = 0 -- Auto Indent
      vim.g.tex_flavor = "latex" -- how to read tex files
      vim.g.tex_indent_items = 0 -- turn off enumerate indent
      vim.g.tex_indent_brace = 0 -- turn off brace indent
      vim.g.vimtex_syntax_enabled = 1 -- Syntax highlighting
      vim.g.vimtex_context_pdf_viewer = "open -a Skim" -- external viewer from the vimtex menu
      vim.g.vimtex_log_ignore = { -- Error suppression:
        "Underfull",
        "Overfull",
        "specifier changed to",
        "Token not allowed in a PDF string",
      }

      -- No build_dir here on purpose: a project-local latexmkrc owns $out_dir /
      -- $aux_dir, so shell builds and vimtex builds share one output directory.
      -- No -shell-escape either; enable it per project only when a document
      -- genuinely needs minted/gnuplot, since it allows arbitrary code execution.
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-verbose",
          "-file-line-error",
          "-interaction=nonstopmode",
          "-synctex=1",
        },
      }

      vim.g.vimtex_fold_enabled = true
    end,
  },
}
