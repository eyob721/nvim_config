return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  -- NOTE: For the `catppuccin` plugin the `opts` field is not working for setting up
  --       configuration options, so use require from inside `config` instead.
  --
  -- NOTE: `opts` is used by lazy to set configuration options for a plugin
  --       `config` is a function that gets called every time a plugin is loaded
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = {
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {
        mocha = {
          base = "#191919", -- Background
          mantle = "#161616", -- Explorer, Statusline, ... etc
          crust = "#4dabdd",
        },
      },
      custom_highlights = {},
      integrations = {
        -- TODO: remember to add integration for plugins
        cmp = true,
        mason = false,
        gitsigns = true,
        neotree = true,
        telescope = {
          enabled = false,
          style = "nvchad",
        },
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        indent_blankline = {
          enabled = true,
          scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = true,
        },
      },
    })
    -- colorscheme must be loaded after setup call
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
