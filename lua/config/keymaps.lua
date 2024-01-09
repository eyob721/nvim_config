-- Keymaps for better default experience

-- See `:help vim.keymap.set()`
local map = vim.keymap.set

-- Disable <Space> in normal and visual mode for better map-leader usability
map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Better up/down - deals with word wrap
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Window Management
map("n", "<leader>|", ":vsplit<CR>", { silent = true, desc = "Split window vertically" })
map("n", "<leader>-", ":split<CR>", { silent = true, desc = "Split window horizontally" })

-- Toggle Options

-- Load my utils
-- local util = require('utils.toggle')

-- map("n", "<leader>us", util.spell(), { desc = "Toggle Spelling" })
-- map("n", "<leader>uw", util.wrap(), { desc = "Toggle Word Wrap" })

-- local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
-- map("n", "<leader>uc", function() toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
