-- Neovim Lua plugin to automatically manage character pairs. 
-- Part of 'mini.nvim' library. 

return {
  'echasnovski/mini.pairs', 
  lazy = false,
  version = '*',
  opts = {
    {
      -- In which modes mappings from this `config` should be created
      modes = { insert = true, command = true, terminal = true },

      -- Global mappings. Each right hand side should be a pair information, a
      -- table with at least these fields (see more in |MiniPairs.map|):
      -- - <action> - one of 'open', 'close', 'closeopen'.
      -- - <pair> - two character string for pair to be used.
      -- By default pair is not inserted after `\`, quotes are not recognized by
      -- `<CR>`, `'` does not insert pair after a letter.
      -- Only parts of tables can be tweaked (others will use these defaults).
      mappings = {
        ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

        [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
      },
    }
  },
  -- This is a good example on toggling options
  keys = {
    {
      "<leader>up",
      function()
        local lazy_util = require("lazy.core.util")
        vim.g.minipairs_disable = not vim.g.minipairs_disable
        if vim.g.minipairs_disable then
          lazy_util.warn("Disabled auto pairs", { title = "Option" })
        else
          lazy_util.info("Enabled auto pairs", { title = "Option" })
        end
      end,
      desc = "Toggle auto pairs",
    },
  },
}
