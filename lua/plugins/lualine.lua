-- A function to show indentation
local function indentation ()
  local expandtab = vim.api.nvim_buf_get_option(0, "expandtab")
  local tabstop = vim.api.nvim_buf_get_option(0, "tabstop")

  if expandtab then
    return "spaces: " .. tabstop
  else
    return "tabs: " .. tabstop
  end
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function ()
    return {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        globalstatus = false,
        always_divide_middle = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        -- TODO: Remeber diagnostics icons later on
        lualine_c = {'filename'},
        lualine_x = {'selectioncount', indentation, 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      -- tabline = {
      --   lualine_a = {'buffers'},
      --   lualine_b = {'branch'},
      --   lualine_c = {'filename'},
      --   lualine_x = {},
      --   lualine_y = {},
      --   lualine_z = {'tabs'}
      -- }
    }
  end,
}
