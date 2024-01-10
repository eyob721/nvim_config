local M = {}
local lazy_util = require("lazy.core.util")

function M.spell()
  vim.opt.spell = not vim.opt.spell:get()
  if vim.opt.spell:get() then
    lazy_util.info("Enabled spell check", { title = "Option" })
  else
    lazy_util.warn("Disabled spell check", { title = "Option" })
  end
end

function M.wrap()
  vim.opt.wrap = not vim.opt.wrap:get()
  if vim.opt.wrap:get() then
    lazy_util.info("Enabled wrap", { title = "Option" })
  else
    lazy_util.warn("Disabled wrap", { title = "Option" })
  end
end

function M.git_blame()
  local gs = package.loaded.gitsigns

  if gs.toggle_current_line_blame() then
    lazy_util.info("Enabled git line blame", { title = "Option" })
  else
    lazy_util.warn("Disabled git line blame", { title = "Option" })
  end
end

return M
