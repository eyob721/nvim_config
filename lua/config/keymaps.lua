-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local del = vim.keymap.del

local toggle = require("utils.toggle")

-- Toggle Git blame
map("n", "<leader>ub", toggle.git_blame, { desc = "Toggle Git line blame" })

-- Toggle Colorizer
del("n", "<leader>uC")
map("n", "<leader>uC", ":ColorizerToggle<CR>", { desc = "Toggle Colorizer" })
