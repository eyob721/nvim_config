-- Auto group template function
local function augroup(name)
  return vim.api.nvim_create_augroup("papi_" .. name, { clear = true })
end

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group =
  vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- [[ Indentation for C and C++ ]]
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = augroup("c_files"),
  pattern = { "*.c", "*.h" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = false
  end,
})

-- [[ Indentation for files that use 2 tabstops ]]
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = augroup("web_files"),
  pattern = { "*.lua", "*.md", "*.html", "*.css", "*.js", "*.sql" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})
