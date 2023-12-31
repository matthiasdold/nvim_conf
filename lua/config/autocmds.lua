-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- NOTE: Mapping multiple commands piped (|) cannot be done with nvim_create_autocmds "command" but must be used with a separate callback function
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.api.nvim_set_keymap("n", "<C-x>", ":vsplit | :term svenv; python %<CR>", { noremap = true, silent = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.api.nvim_set_keymap("n", "<C-x>", ":vsplit | :term cargo run<CR>", { noremap = true, silent = true })
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.api.nvim_set_keymap("n", "<C-b>", ":vsplit | :term cargo build<CR>", { noremap = true, silent = true })
  end,
})

-- vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
