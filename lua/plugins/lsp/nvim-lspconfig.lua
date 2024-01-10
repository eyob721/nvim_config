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
    { "folke/neodev.nvim", opts = {} },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
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
    vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
    vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded" })
    require("lspconfig.ui.windows").default_options.border = "rounded"

    -- [[ 2. Define servers ]] -----------------------------------------------

    -- Add/Remove any LSPs that you want here. They will automatically be installed.
    -- Supported LSPs can be found here https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/mason-lspconfig-mapping.txt
    -- DO NOT add Linters or Formatters, add those in mason config
    local servers = {
      bashls = {}, -- Bash LSP
      clangd = {}, -- C, C++ and Rust LSP
      sqlls = {}, -- SQL LSP
      marksman = {}, -- Markdown LSP
      tsserver = {}, -- TypeScript & JavaScript LSP
      html = { filetypes = { 'html', 'twig', 'hbs'} },
      lua_ls = { -- Lua LSP
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        }
      },
      pyright = { -- Python LSP
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
        }
      },
    }

    -- Setup neovim lua configuration
    require('neodev').setup()

    -- [[ 3. Define on_attach function ]] ------------------------------------

    local on_attach = function(_, bufnr)
      -- NOTE: Remember that lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself
      -- many times.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    -- [[ 4. Define capabilities function ]] ---------------------------------

    -- nvim-cmp supports additional completion capabilities
    -- so broadcast that to the servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- [[ 5. Activate servers ]] ---------------------------------------------

    -- NOTE: Use this if manual setup is required
    --
    -- -- First get all the servers that are available through mason-lspconfig
    -- local all_mslp_servers = {}
    -- all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
    --
    -- local function manual_setup(server)
    --   local server_opts = vim.tbl_deep_extend("force", {
    --     capabilities = vim.deepcopy(capabilities),
    --   }, servers[server] or {})
    --   require("lspconfig")[server].setup(server_opts)
    -- end
    --
    -- -- Next check if servers in the servers table are supported
    -- -- If a server is not supported, use manual setup
    -- -- If a server is supported, and not installed add it to ensure_installed
    -- local ensure_installed = {}
    -- for server, server_opts in pairs(servers) do
    --   if server_opts then
    --     server_opts = server_opts == true and {} or server_opts
    --     -- run manual setup if this is a server that cannot be installed with mason-lspconfig
    --     if not vim.tbl_contains(all_mslp_servers, server) then
    --       manual_setup(server)
    --     -- otherwise add it to the ensure_installed table
    --     else
    --       ensure_installed[#ensure_installed + 1] = server
    --     end
    --   end
    -- end

    -- Ensure the servers above are installed
    local mason_lspconfig = require("mason-lspconfig")

    -- Install servers
    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    -- Activate the servers - using mason-lspconfig advanced feature
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
