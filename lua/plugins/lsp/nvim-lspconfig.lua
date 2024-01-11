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
          { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
          { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
          { name = "DiagnosticSignInfo", text = icons.diagnostics.Info },
        },
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
    for _, sign in
      ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {})
    do
      vim.fn.sign_define(
        sign.name,
        { texthl = sign.name, text = sign.text, numhl = sign.name }
      )
    end

    -- change hover window border
    vim.lsp.handlers["textDocument/hover"] =
      vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"

    -- [[ 2. Define servers ]] -----------------------------------------------
    local servers = {
      -- Add/Remove any LSPs that you want here. They will be automatically be installed.
      -- DO NOT add Linters or Formatters here, add those in the mason config
      "bashls",
      "clangd",
      "cssls",
      "html",
      "jsonls",
      "lua_ls",
      "marksman",
      "pyright",
      "sqlls",
      "tailwindcss",
      "tsserver",
      "yamlls",
    }

    -- [[ 3. Define on_attach function ]] ------------------------------------
    local function on_attach(_, bufnr)
      -- Define keymaps
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
      nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
      nmap("gm", vim.diagnostic.open_float, "Open floating diagnostic message")
      nmap("gl", vim.diagnostic.setloclist, "Open diagnostics list")

      nmap("<leader>cr", vim.lsp.buf.rename, "Code Rename")
      nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

      nmap("gd", vim.lsp.buf.definition, "Go to definition")
      nmap("gD", vim.lsp.buf.declaration, "Go to declaration")
      nmap("gi", vim.lsp.buf.implementation, "Go to implementation")
      nmap("gr", vim.lsp.buf.references, "Go to references")

      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })

      -- NOTE: for debugging your config, use this
      -- local lazy_util = require("lazy.core.util")
      -- lazy_util.info("Attached")
    end

    -- [[ 4. Define capabilities function ]] ---------------------------------
    -- Use the capabilities from nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- [[ 5. Activate servers ]] ---------------------------------------------
    -- Ensure the servers above are installed
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      ensure_installed = servers,
    })

    -- Activate the servers manually
    local lspconfig = require("lspconfig")
    for _, server in pairs(servers) do
      local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
      }

      local require_ok, settings =
        pcall(require, "plugins.lsp.settings." .. server)
      if require_ok then
        opts = vim.tbl_deep_extend("force", settings, opts)
      end

      if server == "lua_ls" then
        require("neodev").setup({})
      end
      lspconfig[server].setup(opts)
    end
  end,
}
