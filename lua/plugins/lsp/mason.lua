return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- Linters
      "eslint-lsp", --TypeScript & JavaScript
      "markdownlint", -- Markdown
      "shellcheck", -- Bash

      -- Formatters
      "black", -- Python
      "isort", -- Python imports
      "pydocstyle", -- Python docstrings
      "clang-format", -- C and C++
      "prettier", -- HTML, CSS, and JS
      "mdformat", -- Markdown
      "shfmt", -- Bash
      "sql-formatter", -- SQL
      "stylua", -- Lua
    },
  },
}
