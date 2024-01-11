return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    -- Add your LSPs (only) here, add linter and formatters in mason config
    servers = {
      -- Bash
      bashls = {},

      -- C, C++ and Rust
      clangd = {},

      -- CSS
      cssls = {},

      -- HTML
      html = {},

      -- Json
      jsonls = {},

      -- Markdown
      marksman = {},

      -- SQL
      sqlls = {},

      -- Javascript and Typescript
      tsserver = {},

      -- Lua
      lua_ls = {
        -- mason = false, -- set to false if you don't want this server to be installed with mason
        -- Use this to add any additional keymaps
        -- for specific lsp servers
        -- @type LazyKeysSpec[]
        -- keys = {},
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
            telemetry = { enable = false },
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      },

      -- Python
      pyright = {
        capabilities = (function()
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
          return capabilities
        end)(),
        settings = {
          python = {
            analysis = {
              diagnosticSeverityOverrides = {
                reportUnboundVariable = "none",
                reportGeneralTypeIssues = "none",
              },
              typeCheckingMode = "basic", -- off, basic, strict
            },
          },
        },
      },
    },
  },
}
