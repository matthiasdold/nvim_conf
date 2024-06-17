-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.wo.wrap = false --Display long lines as just one line vim.cmd("set whichwrap+=<,>,[,],h,l") vim.o.pumheight = 10 --Makes popup menu smaller
-- vim.o.fileencoding = "utf-8" --The encoding written to file
vim.o.cmdheight = 2 --More space for displaying messages
vim.o.mouse = "a" --Enable your mouse
-- vim.o.splitbelow = true --Horizontal splits will automatically be below
vim.o.termguicolors = true
-- vim.o.splitright = true --Vertical splits will automatically be to the right
vim.o.conceallevel = 0 --So that I can see `` in markdown files
-- vim.wo.relativenumber = true
vim.wo.signcolumn = "yes" --Always show the signcolumn, otherwise it would shift the text each time
vim.o.updatetime = 300 --Faster completion
vim.o.timeoutlen = 500 --By default timeoutlen is 1000 ms
-- vim.o.ttimeoutlen = 10 -- Used for key code delays
-- vim.o.clipboard = "unnamedplus" --Copy paste between vim and everything else
vim.api.nvim_command("set synmaxcol=120") -- stop syntax highlighting after a certain column to not be super slow on files with long lines

-- Had to remove the line below to work properly on windows / might be still usefull for the unix setup
-- vim.o.filetype = "on" -- needs to be enabled to to have autocmd based of FileType working
-- vim.o.hidden = true -- To be able to move out of a modified buffer without writing
-- vim.g.tex_flavor = "latex" -- to also have files ot type plaintex treated as latex files

vim.api.nvim_command("set cursorlineopt=number")
