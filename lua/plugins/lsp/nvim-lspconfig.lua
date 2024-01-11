--[[
==============================================================================
Neovim LSP Configuration
==============================================================================

Steps:
  1. Customize UI
  2. Define servers
  3. Define on_attach function
  4. Define capabilities function
  5. Activate servers

--]]

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "folke/neodev.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- [[ 1. Customize UI ]] -------------------------------------------------
    local icons = require("utils.icons")

    vim.diagnostic.config({
      signs = {
        active = true,
        values = {
          { name = "DiagnosticSignError", text = icons.diagnostics.Error },
          { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
          { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
          { name = "DiagnosticSignInfo",  text = icons.diagnostics.Info },
        }
      },
      virtual_text = true,
      underline = true,
      update_in_insert = false, -- to update diagnostics in insert mode
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        -- header = "",
        -- prefix = "",
      },
    })

    -- change diagnostics symbols in the sign column
    for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end

    -- change hover window border
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"

    -- [[ 2. Define servers ]] -----------------------------------------------
    local servers = {
      -- Add/Remove any LSPs that you want here. They will be automatically be installed.
      -- DO NOT add Linters or Formatters here, add those in the mason config
      bashls = {},                                      -- Bash LSP
      clangd = {},                                      -- C, C++ and Rust LSP
      sqlls = {},                                       -- SQL LSP
      marksman = {},                                    -- Markdown LSP
      tsserver = {},                                    -- TypeScript & JavaScript LSP
      html = { filetypes = { 'html', 'twig', 'hbs' } }, -- HTML LSP
      lua_ls = {                                        -- Lua LSP
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          diagnostics = { disable = { 'missing-fields' } },
        },
      },
      pyright = { -- Python LSP
        python = {
          analysis = {
            diagnosticSeverityOverrides = {
              reportUnboundVariable = "none",
              reportGeneralTypeIssues = "none",
            },
            typeCheckingMode = "basic",   -- off, basic, strict
          },
        },
      },
    }

    -- Setup neovim lua configuration
    require('neodev').setup()

    -- [[ 3. Define on_attach function ]] ------------------------------------
    local on_attach = function(_, bufnr)
      -- Define keymaps
      local nmap = function(keys, func, desc)
        desc = desc and 'LSP: ' .. desc or ""
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      -- Diagnostic keymaps
      nmap('[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
      nmap(']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
      nmap('<leader>gm', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
      nmap('<leader>gl', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

      -- Code keymaps
      nmap('<leader>cr', vim.lsp.buf.rename, 'Code Rename')
      nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

      -- Goto keymaps
      nmap('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
      nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
      nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
      nmap('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
      nmap('<leader>gD', require('telescope.builtin').lsp_type_definitions, 'Goto Type Definition')
      -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
      -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

      -- Documentation keymaps
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Workspace and Document keymaps
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, 'Workspace List Folders')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    -- [[ 4. Define capabilities function ]] ---------------------------------
    -- Use the capabilities from nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- [[ 5. Activate servers ]] ---------------------------------------------
    -- Ensure the servers above are installed
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    -- Activate the servers, using mason-lspconfig advanced feature
    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end,
    }
  end
}
