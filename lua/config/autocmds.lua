-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- NOTE: Mapping multiple commands piped (|) cannot be done with nvim_create_autocmds "command" but must be used with a separate callback function
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.api.nvim_set_keymap("n", "<C-x>", ":vsplit | :term svenv; python %<CR>", { noremap = true, silent = true })
    vim.api.nvim_command("set cc=80")
    vim.api.nvim_set_keymap("n", "<leader>dd", "obreakpoint()<Esc>", { noremap = true, silent = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.api.nvim_set_keymap("n", "<C-x>", ":vsplit | :term cargo run<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<C-b>", ":vsplit | :term cargo build<CR>", { noremap = true, silent = true })
  end,
})

-- Prose-style editing for LaTeX and markdown. Options are window/buffer-local
-- so they do not leak into code buffers opened later.
--
-- NOTE: user autocmds are loaded on VeryLazy, i.e. AFTER the FileType event has
-- already fired for a file opened on the command line (`nvim thesis.tex`).
-- The autocmd alone therefore misses the very first buffer, so prose_setup() is
-- also applied directly to any matching window already open at load time.
local prose_filetypes = { tex = true, plaintex = true, bib = true, markdown = true }

local function prose_setup(buf, win)
  vim.api.nvim_buf_call(buf, function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_gb" }
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true -- wrap at word boundaries, not mid-word
    vim.opt_local.breakindent = true -- keep the indent of wrapped lines

    -- Conceal maths/markup in LaTeX only; the global conceallevel stays 0 so
    -- backticks remain visible in markdown.
    if vim.bo[buf].filetype ~= "markdown" then
      vim.opt_local.conceallevel = 2
    end
  end)

  -- spell/wrap/conceallevel are window-local: set them on the window too, so
  -- they survive LazyVim's global `opt.wrap = false` applied during init.
  if win and vim.api.nvim_win_is_valid(win) then
    vim.wo[win].spell = true
    vim.wo[win].wrap = true
    vim.wo[win].linebreak = true
    vim.wo[win].breakindent = true
    if vim.bo[buf].filetype ~= "markdown" then
      vim.wo[win].conceallevel = 2
    end
  end

  -- Move by screen line, so j/k do not jump whole wrapped paragraphs.
  for _, key in ipairs({ "j", "k" }) do
    vim.keymap.set("n", key, "v:count == 0 ? 'g" .. key .. "' : '" .. key .. "'", {
      expr = true,
      buffer = buf,
      desc = "Move by display line",
    })
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = vim.tbl_keys(prose_filetypes),
  callback = function(args)
    prose_setup(args.buf, vim.api.nvim_get_current_win())
  end,
})

-- Catch buffers whose FileType already fired before this file was loaded.
-- Deferred to VeryLazy: at the time this file is sourced the startup window
-- does not yet display the command-line file, so setting options here directly
-- would be applied to the wrong (empty) window.
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if prose_filetypes[vim.bo[buf].filetype] then
        prose_setup(buf, win)
      end
    end
  end,
})

-- -- Autoformat on save
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("lsp", { clear = true }),
--   callback = function(args)
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       pattern = "*",
--       callback = function()
--         require("conform").format({ bufnr = args.buf }) -- conform is default in lazyvim
--       end,
--     })
--   end,
-- })
--
--
-- vim.cmd([[autocmd BufWritePre <t buffer> lua vim.lsp.buf.format()]])

-- Adopt the light/dark mode last chosen by kitty-theme-toggle, so a newly
-- started nvim matches the terminal instead of always coming up dark.
--
-- Called directly rather than from a VeryLazy autocmd: this file is itself
-- loaded on VeryLazy (see line 1), so such an autocmd would register after the
-- event had already fired and would never run. vim.schedule defers it past
-- LazyVim's own colorscheme call, which would otherwise overwrite it.
vim.schedule(function()
  pcall(function()
    require("config.theme").sync_from_state()
  end)
end)
