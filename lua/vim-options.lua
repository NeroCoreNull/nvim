vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")
vim.cmd("set shiftround")
vim.cmd("syntax=on")
vim.cmd("set spell")
vim.cmd("set number")
vim.g.mapleader = " "
vim.cmd("set scrolloff=10")
vim.cmd("set ruler")

-- cursor
vim.cmd("set guicursor=i-v:block")
vim.cmd("set cursorline")
vim.keymap.set("n", "k", "gk", {})
vim.keymap.set("n", "j", "gj", {})
vim.keymap.set("n", "<Up>", "gk", {})
vim.keymap.set("n", "<Down>", "gj", {})

-- linebreak
vim.cmd("set wrap")
vim.cmd("set linebreak")
vim.cmd("set textwidth=80")
