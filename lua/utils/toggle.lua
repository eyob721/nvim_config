local M = {}
local lazy_util = require("lazy.core.util")

function M.git_blame()
  local gs = package.loaded.gitsigns

  if gs.toggle_current_line_blame() then
    lazy_util.info("Enabled git line blame", { title = "Option" })
  else
    lazy_util.warn("Disabled git line blame", { title = "Option" })
  end
end

return M
