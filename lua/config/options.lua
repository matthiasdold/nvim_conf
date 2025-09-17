vim.o.cmdheight = 2 --More space for displaying messages
vim.o.mouse = "a" --Enable your mouse
-- vim.o.splitbelow = true --Horizontal splits will automatically be below
vim.o.termguicolors = true
-- vim.o.splitright = true --Vertical splits will automatically be to the right
vim.o.conceallevel = 0 --So that I can see `` in markdown files
-- vim.wo.relativenumber = true
vim.wo.signcolumn = "no" --Always show the signcolumn, otherwise it would shift the text each time -- else too much flickering
vim.o.updatetime = 300 --Faster completion
vim.o.timeoutlen = 500 --By default timeoutlen is 1000 ms
-- vim.o.ttimeoutlen = 10 -- Used for key code delays
-- vim.o.clipboard = "unnamedplus" --Copy paste between vim and everything else
vim.api.nvim_command("set synmaxcol=120") -- stop syntax highlighting after a certain column to not be super slow on files with long lines
-- vim.o.filetype = "on" -- needs to be enabled to to have autocmd based of FileType working
-- vim.o.hidden = true -- To be able to move out of a modified buffer without writing
-- vim.g.tex_flavor = "latex" -- to also have files ot type plaintex treated as latex files

vim.api.nvim_command("set cursorlineopt=number")

-- vim.g.lazyvim_python_lsp = "jedi_language_server"
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"

vim.g.lazyvim_blink_main = true

-- improved speed according to kapral18 in this issue: https://github.com/LazyVim/LazyVim/discussions/326
vim.lsp.set_log_level("off")
vim.g.snacks_animate = false
vim.opt.showmatch = true -- Show matching brackets
vim.opt.matchtime = 2 -- Tenths of a second to show matching brackets
-- adds <> to % matchpairs
vim.opt.matchpairs:append("<:>")
