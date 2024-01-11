return {

  "williamboman/mason.nvim",
  cmd = "Mason",
  build = ":MasonUpdate",
  opts = {
    ui = {
      border = "rounded",
    },
    ensure_installed = {
      -- Linters
      "shellcheck", -- Bash Linter
      "markdownlint", -- Markdown Linter
      "eslint-lsp", --TypeScript & JavaScript Linter

      -- Formatters
      "shfmt", -- Bash Formatter
      "clang-format", -- C and C++ Formatter
      "pydocstyle", -- Python Formatter for doctrings
      "isort", -- Python Formatter for import statements
      "black", -- Python Formatter
      "prettier", -- Formatter for HTML, CSS, JS, Markdown, ... etc.
      "stylua", -- Lua Formatter
      "sql-formatter", -- SQL Formatter
    },
  },
  config = function(_, opts)
    -- NOTE: Mason installing packages
    require("mason").setup(opts)
    local mr = require("mason-registry")
    mr:on("package:install:success", function()
      vim.defer_fn(function()
        -- trigger FileType event to possibly load this newly installed LSP server
        require("lazy.core.handler.event").trigger({
          event = "FileType",
          buf = vim.api.nvim_get_current_buf(),
        })
      end, 100)
    end)

    local function ensure_installed()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end

    if mr.refresh then
      mr.refresh(ensure_installed)
    else
      ensure_installed()
    end
  end,
}
