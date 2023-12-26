-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Repl
vim.api.nvim_set_keymap("n", "<leader>rr", ":IronRestart<CR>", { noremap = true, desc = "Restart iron repl" })
vim.api.nvim_set_keymap(
  "n",
  "<leader>pm",
  ":IronSend import ipdb; ipdb.pm()<CR>",
  { noremap = true, desc = "Start ipython post mortem debugger" }
)

-- Latex related
function OpenZathuraPdf()
  os.execute("zathura " .. vim.fn.expand("%:p:r") .. ".pdf" .. " &")
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>zz",
  "<Cmd>:lua OpenZathuraPdf()<CR>",
  { noremap = true, desc = "Open zathura pdf preview" }
)

vim.api.nvim_set_keymap("n", "<leader>ww", "<Cmd>:w<CR>", { noremap = true, desc = "save file" })

vim.api.nvim_set_keymap("t", "<ESC>", "<C-\\><C-n>", { noremap = true, desc = "leave terminal mode" })

-- Easier way of editing lua snippets
-- -> TODO: currently this would be execute on each buffer load, figure out how to fix this
-- vim.api.nvim_create_user_command("LuaSnipEdit", require("luasnip.loaders").edit_snippet_files())
