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

      -- Project-local spelling: acronyms.tex is the single source of truth.
      --
      -- `spellfile` is a comma-separated list and `zg` always writes to the
      -- FIRST entry, so the project file is listed first: words added with `zg`
      -- while writing land next to the dissertation, not in the global config.
      --
      --   <project>/.nvim.spell.add  -- zg target, committed with the thesis
      --   ~/.config/nvim/spell/...   -- personal words shared across projects
      --
      -- Acronym short forms are parsed out of acronyms.tex into a generated
      -- spellfile, so defining an acronym there is all that is needed for it to
      -- spell-check clean.

      local function sync_acronym_spell(root)
        local acro = root .. "/acronyms.tex"
        if vim.fn.filereadable(acro) == 0 then
          return nil
        end

        local words = {}
        for _, line in ipairs(vim.fn.readfile(acro)) do
          -- Match the key and any explicit short=, since they can differ.
          local key = line:match("\\DeclareAcronym%s*{([^}]+)}")
          if key then
            words[key] = true
          end
          local short = line:match("^%s*short%s*=%s*([^,}]+)")
          if short then
            words[vim.trim(short)] = true
          end
        end
        if vim.tbl_isempty(words) then
          return nil
        end

        local sorted = vim.tbl_keys(words)
        table.sort(sorted)
        local generated = root .. "/.nvim.spell.acronyms.add"
        local existing = vim.fn.filereadable(generated) == 1 and vim.fn.readfile(generated) or {}
        -- Only rewrite when the contents actually changed: writing the file
        -- unconditionally would invalidate the .spl on every buffer enter.
        -- The .spl is what spell checking actually reads; Neovim only rebuilds
        -- it from an .add file on `zg`, so compile it here whenever the word
        -- list changed (or the .spl is missing). `silent!` keeps mkspell from
        -- blocking on its overwrite prompt.
        if not vim.deep_equal(existing, sorted) or vim.fn.filereadable(generated .. ".spl") == 0 then
          vim.fn.writefile(sorted, generated)
          pcall(vim.cmd, "silent! mkspell! " .. vim.fn.fnameescape(generated))
        end
        return generated
      end

      -- VimtexEventInitPost, not FileType: b:vimtex (and therefore the project
      -- root) only exists once vimtex has initialised the buffer, which happens
      -- after FileType has already fired.
      vim.api.nvim_create_autocmd("User", {
        pattern = "VimtexEventInitPost",
        callback = function(args)
          local root = vim.b[args.buf].vimtex and vim.b[args.buf].vimtex.root
          if not root then
            return
          end

          local files = { root .. "/.nvim.spell.add" }
          local generated = sync_acronym_spell(root)
          if generated then
            table.insert(files, generated)
          end
          table.insert(files, vim.fn.stdpath("config") .. "/spell/en.utf-8.add")

          -- Set it on the buffer explicitly: vim.opt_local follows the current
          -- window, which is not guaranteed to be this buffer's window when a
          -- User autocmd fires.
          vim.api.nvim_buf_call(args.buf, function()
            vim.opt_local.spellfile = files
          end)
        end,
      })
    end,
  },
}
