-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Auto group template function
local function augroup(name)
  return vim.api.nvim_create_augroup("papi_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = augroup("c_files"),
  pattern = { "*.c", "*.h" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = false
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = augroup("small_indent_files"),
  pattern = { "*.lua", "*.md", "*.html", "*.css", "*.js", "*.sql" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- TODO: Remeber to enable autocmd for JS linter
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   group = augroup("js_lint"),
--   pattern = { "*.js" },
--   callback = function()
--     vim.cmd("EslintFixAll")
--     vim.cmd("write")
--   end,
-- })

-- For closeing all folds when exiting a buffer
-- vim.api.nvim_create_autocmd({ "BufWritePost", "BufDelete" }, {
--   group = augroup("folds_autoclose"),
--   callback = function()
--     vim.cmd.normal("zM") -- zM closes all folds
--   end,
-- })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = augroup("python3_hashbang"),
  pattern = { "*.py" },
  callback = function()
    local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
    local python3_hashbang = "#!/usr/bin/python3"

    if first_line ~= python3_hashbang then
      -- Add the hashbang at the first line
      -- This will not replace the first line, just adds the line
      vim.api.nvim_buf_set_lines(0, 0, 0, true, { python3_hashbang })
    end

    -- NOTE: I left these here for learning purposes
    --
    -- local file = vim.api.nvim_buf_get_name(0) -- current buffer full file path
    -- local file = vim.fn.expand("%:p") -- the current buffer full file path
    -- local line_count = vim.api.nvim_buf_line_count(0)
    --
    -- Using Vimscript
    -- vim.cmd([[
    -- norm i#!/usr/bin/python3
    -- norm o
    -- ]])
  end,
})
