-- Neovim Lua plugin to visualize and operate on indent scope.
-- Part of 'mini.nvim' library.

return {
  "echasnovski/mini.indentscope",
  opts = {
    -- symbol = "▏",
    symbol = "│",
    options = { try_as_border = true },
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
  keys = {
    {
      "<leader>ui",
      function()
        local lazy_util = require("lazy.core.util")
        vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
        if vim.g.miniindentscope_disable then
          lazy_util.warn("Disabled indent scope", { title = "Option" })
        else
          lazy_util.info("Enabled indent scope", { title = "Option" })
        end
      end,
      desc = "Toggle indent scope",
    },
  },
  
}
