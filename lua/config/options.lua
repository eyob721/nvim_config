-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- [[ Tabs / Indentation ]]
opt.tabstop = 4 -- Number of spaces a <Tab> counts for
opt.shiftwidth = 0 -- Number of spaces to use for each space of autoindent
opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations
opt.expandtab = true -- Expand tabs to spaces
opt.shiftround = true -- Rounds indent to multiple of `shiftwidth`, applies to > and <
opt.smartindent = true -- automatic indenting

-- [[ Formatting ]]
opt.textwidth = 79
opt.colorcolumn = "+1"
