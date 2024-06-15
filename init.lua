vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")
vim.cmd("set guicursor=i-v:block")
vim.cmd("syntax=on")
vim.cmd("set number")
vim.g.mapleader = " "
vim.cmd("set whichwrap+=h,l")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Lazy init
require("lazy").setup("plugins")

-- Theme and autoclose brackets
require("autoclose").setup()
require('stay-centered').setup()
