--[[
==============================================================================
Auto completion
==============================================================================
nvim-cmp: a completion plugin for neovim coded in Lua.

When adding sources:
  1. first include the source plugin repo in the `dependencies` key
  2. then include the source name in the `sources` key
--]]

local icons = require("utils.cmp_util").kind_icons
local window_opts = require("utils.cmp_util").window_opts

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-emoji",
  },
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    return {
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item({}),
        ["<C-k>"] = cmp.mapping.select_prev_item({}),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
      }, {
        { name = "buffer" },
        { name = "emoji" },
      }),
      -- My formatting
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          -- Kind icons
          item.kind = string.format("%s", icons[item.kind])
          item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
          return item
        end,
      },
      window = {
        completion = cmp.config.window.bordered(window_opts),
        documentation = cmp.config.window.bordered(window_opts),
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
      sorting = defaults.sorting,
    }
  end,
}
