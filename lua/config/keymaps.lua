-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local toggle = require("utils.toggle")

-- Git signs
map("n", "<leader>ub", toggle.git_blame, { desc = "Toggle Git line blame" })
