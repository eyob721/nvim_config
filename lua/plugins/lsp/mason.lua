return {
  "williamboman/mason.nvim",
  opts = {
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
}
