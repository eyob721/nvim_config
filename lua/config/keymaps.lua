-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local delete = vim.keymap.del

-- [[ Delete unwanted default keymaps ]]
delete("n", "<C-h>")
delete("n", "<C-j>")
delete("n", "<C-k>")
delete("n", "<C-l>")

-- Move between windows using the <alt> hjkl keys
map("n", "<A-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<A-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<A-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<A-l>", "<C-w>l", { desc = "Go to right window", remap = true })
