--[[
==============================================================================
Auto completion
==============================================================================

nvim-cmp: a completion plugin for neovim coded in Lua. 

NOTE: when adding sources
        1. first include the source plugin repo in the `dependencies` key
        2. then include the source name in the `sources` key
-]]

local kind_icons = require("utils.icons").kind_icons

local completion_opts = {
  border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  winhighlight = "Normal:NormalFloat,FloatBorder:Normal,CursorLine:Visual,Search:None",
  zindex = 1001,
  scrolloff = 0,
  col_offset = 0,
  side_padding = 1,
}

local documentation_opts = {
  -- border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
  border = "rounded",
  winhighlight = "Normal:NormalFloat,FloatBorder:Normal,CursorLine:Visual,Search:None",
  zindex = 1001,
  scrolloff = 0,
  col_offset = 0,
  side_padding = 1,
}

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",

  -- source repos
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- lsp completions
    "saadparwaiz1/cmp_luasnip", -- snippets
    "hrsh7th/cmp-buffer",       -- buffer completions
    "hrsh7th/cmp-path",         -- path completions
    "hrsh7th/cmp-emoji",        -- markdown emojis
    "hrsh7th/cmp-nvim-lua",     -- neovim's lua api
    "paopaol/cmp-doxygen",      -- doxygen completions
    {
      "L3MON4D3/LuaSnip",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
    },
    -- "hrsh7th/cmp-cmdline",       -- command line completions [NOT GOOD]
    -- "garyhurtz/cmp_bulma.nvim",  -- css completions
    -- "Jezda1337/nvim-html-css",   -- css intellisense for HTML
  },

  opts = function()
    -- Set up nvim-cmp
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup()

    -- Highlight for ghost texts
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    local defaults = require("cmp.config.default")()

    return {
      -- Completion menu behavior
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },

      -- REQUIRED - you must specify a snippet engine
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- Source names
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "path" },
        { name = "doxygen" },
        { name = "emoji" },
        -- { name = "cmdline" },
      }),

      -- My mappings
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          -- Accept currently selected item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          select = false,
        }), 
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,

        -- Super tab settings
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with
            -- expand_or_locally_jumpable() 
            -- that way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      -- My formatting
      formatting = {
        -- fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          -- Kind icons
          item.kind = string.format("%s", kind_icons[item.kind])
          item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
            nvim_lua = "[Lua]",
          })[entry.source.name]
          return item
        end,
      },

      -- Window options
      window = {
        completion = cmp.config.window.bordered(completion_opts),
        documentation = cmp.config.window.bordered(documentation_opts),
      },

      -- Experimental options
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
    }
  end,

  config = function(_, opts)
    for _, source in ipairs(opts.sources) do
      source.group_index = source.group_index or 1
    end
    require("cmp").setup(opts)
  end,
}
