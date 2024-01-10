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

-- A function to show selected char and line count
local function char_and_line_count()
  local ln_beg = vim.fn.line("v")
  local ln_end = vim.fn.line(".")
  local lines = ln_beg <= ln_end and ln_end - ln_beg + 1 or ln_beg - ln_end + 1
  local chars = vim.fn.wordcount().visual_chars

  -- To check if it is in visual mode use this, which works for all visual modes
  local is_visual_mode = chars ~= nil

  -- I also found this option, but this doesn't work for visual-block mode
  -- local is_visual_mode = vim.fn.mode():find("[vV]")

  if is_visual_mode then
    return tostring(lines) .. "x" .. tostring(chars)
  else
    return ""
  end
end

local signs = {
  Error = "",
  Warn = "󰳦",
  Hint = "",
  Info = "",
}

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
        theme = 'auto',
        globalstatus = false,
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "starter", "neo-tree" }
        },
        always_divide_middle = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      -- TODO: Remember to add macro recordings
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diagnostics'},
        -- TODO: Remember to add diagnostic icons later on
        lualine_c = {
          {'filetype', icon_only = true},
          {'filename'}
        },
        lualine_x = {char_and_line_count, indentation, 'fileformat'},
        lualine_y = {'location'},
        lualine_z = {'progress'}
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
