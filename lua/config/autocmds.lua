-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- NOTE: Mapping multiple commands piped (|) cannot be done with nvim_create_autocmds "command" but must be used with a separate callback function
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.api.nvim_set_keymap("n", "<C-x>", ":vsplit | :term svenv; python %<CR>", { noremap = true, silent = true })
    vim.api.nvim_command("set cc=80")
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.api.nvim_set_keymap("n", "<C-x>", ":vsplit | :term cargo run<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<C-b>", ":vsplit | :term cargo build<CR>", { noremap = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.api.nvim_command("set spell")
    vim.api.nvim_command("set wrap")
    vim.api.nvim_command("setlocal foldtext")
    -- vim.api.nvim_command("colorscheme shine")
    vim.api.nvim_command("Copilot disable")
    require("gitsigns").detach()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.api.nvim_command("set spell")
    vim.api.nvim_command("set wrap")
  end,
})

-- -- Autoformat on save
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("lsp", { clear = true }),
--   callback = function(args)
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = args.buf,
--       callback = function()
--         vim.lsp.buf.format({ async = false, id = args.data.client_id })
--       end,
--     })
--   end,
-- })
--
--
-- vim.cmd([[autocmd BufWritePre <t buffer> lua vim.lsp.buf.format()]])
