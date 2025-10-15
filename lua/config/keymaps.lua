-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Repl
vim.api.nvim_set_keymap("n", "<leader>rn", ":IronRestart<CR>", { noremap = true, desc = "Restart iron repl" })
vim.api.nvim_set_keymap("n", "<leader>rr", ":IronRepl<CR>", { noremap = true, desc = "Toggle IronRepl" })
vim.api.nvim_set_keymap("n", "<leader>rh", ":IronReplHere<CR>", { noremap = true, desc = "IronReplHere" })
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

vim.api.nvim_set_keymap("n", "<leader>vt", "<Cmd>:VimtexCompile<CR>", { noremap = true, desc = "Toggle VimtexCompile" })
vim.api.nvim_set_keymap("n", "<leader>ve", "<Cmd>:VimtexErrors<CR>", { noremap = true, desc = "Show VimtexErrors" })

vim.api.nvim_set_keymap("n", "<leader>zm", "<Cmd>:ZenMode<CR>", { noremap = true, desc = "Toggle ZenMode" })

-- Easier way of editing lua snippets
-- -> TODO: currently this would be execute on each buffer load, figure out how to fix this
-- vim.api.nvim_create_user_command("LuaSnipEdit", require("luasnip.loaders").edit_snippet_files())
--
--
--
-- Map gx to open the file under the cursor in a new buffer
function OpenFileInNewBuffer()
  -- Get the current line and cursor position
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".")

  -- Extract the word under the cursor, including suffixes like `:<line_number>` or `#<line_number>`
  local word_under_cursor = vim.fn.expand("<cWORD>")

  -- Match the file path and optional line number (e.g., `file.txt:42` or `file.txt#42`)
  local file_path, line_number = word_under_cursor:match("^([^:#]+)[:#](%d+)")
  if not file_path then
    -- If no line number suffix, use the entire word as the file path
    file_path = word_under_cursor
  end

  -- Expand `~` to the home directory
  file_path = vim.fn.expand(file_path)

  -- Check if the file is readable
  if vim.fn.filereadable(file_path) == 1 then
    -- Open the file in a new buffer
    vim.cmd("edit " .. file_path)

    -- Move to the specified line number if it exists
    if line_number then
      vim.api.nvim_win_set_cursor(0, { tonumber(line_number), 0 })
    end
  else
    print("File not found: " .. file_path)
  end
end
vim.api.nvim_set_keymap("n", "gx", ":lua OpenFileInNewBuffer()<CR>", { noremap = true, silent = true })
