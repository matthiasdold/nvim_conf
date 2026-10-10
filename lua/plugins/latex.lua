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
        -- LTeX is a grammar/style checker, separate from Neovim's built-in
        -- speller. `zg` only ever touches the .add spellfile, so LTeX keeps
        -- flagging words until its OWN dictionary is told about them. Feed it
        -- the same project word list so one `zg` covers both.
        ltex = {
          settings = {
            ltex = {
              language = "en-GB", -- match spelllang in config/autocmds.lua
              -- Populated on attach from <project>/.nvim.spell.add and the
              -- generated acronym list; see the LspAttach autocmd below.
              dictionary = {},
              -- \ac{} and friends expand to text LTeX cannot see, so the
              -- surrounding sentence often looks ungrammatical to it.
              disabledRules = { ["en-GB"] = { "WHITESPACE_RULE" } },
            },
          },
        },

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

  -- Keep LTeX's dictionary in sync with the project spellfiles.
  --
  -- `zg` appends to <project>/.nvim.spell.add, which only Neovim's internal
  -- speller reads. LTeX runs as a separate process with its own dictionary, so
  -- without this it keeps underlining words you have already whitelisted.
  -- Reading the same files keeps one `zg` authoritative for both.
  {
    "neovim/nvim-lspconfig",
    optional = true,
    init = function()
      local function project_words(root)
        local words = {}
        for _, name in ipairs({ ".nvim.spell.add", ".nvim.spell.acronyms.add" }) do
          local path = root .. "/" .. name
          if vim.fn.filereadable(path) == 1 then
            for _, line in ipairs(vim.fn.readfile(path)) do
              line = vim.trim(line)
              -- Skip blanks and the region markers vim writes into .add files.
              if line ~= "" and not line:match("^[/#]") then
                table.insert(words, line)
              end
            end
          end
        end
        return words
      end

      local function push_dictionary(client, root)
        local words = project_words(root)
        if vim.tbl_isempty(words) then
          return
        end
        local lang = vim.tbl_get(client.config.settings or {}, "ltex", "language") or "en-GB"
        client.config.settings = vim.tbl_deep_extend("force", client.config.settings or {}, {
          ltex = { dictionary = { [lang] = words } },
        })
        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client or client.name ~= "ltex" then
            return
          end
          local root = client.config.root_dir or vim.fn.getcwd()
          push_dictionary(client, root)

          -- Re-push after `zg`/`zw` so a newly added word stops being flagged
          -- without restarting the server.
          for _, key in ipairs({ "zg", "zw", "zug", "zuw" }) do
            vim.keymap.set("n", key, function()
              vim.cmd("normal! " .. key)
              vim.schedule(function()
                push_dictionary(client, root)
              end)
            end, { buffer = args.buf, desc = "spell " .. key .. " (+ sync LTeX)" })
          end
        end,
      })
    end,
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
