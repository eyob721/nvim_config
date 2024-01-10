local M = {}

function M.spell()
  local lazy_util = require("lazy.core.util")
  vim.opt.spell = not vim.opt.spell:get()
  if vim.opt.spell:get() then
    lazy_util.info("Enabled spell check", { title = "Option" })
  else
    lazy_util.warn("Disabled spell check", { title = "Option" })
  end
end

function M.wrap()
  local lazy_util = require("lazy.core.util")
  vim.opt.wrap = not vim.opt.wrap:get()
  if vim.opt.wrap:get() then
    lazy_util.info("Enabled wrap", { title = "Option" })
  else
    lazy_util.warn("Disabled wrap", { title = "Option" })
  end
end

return M
