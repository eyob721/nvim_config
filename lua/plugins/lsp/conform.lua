--[[
==============================================================================
Fomratter plugin
==============================================================================
--]]

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      async = false, -- not recommended to change
      quiet = false, -- not recommended to change
    },
    formatters_by_ft = {
      ["lua"] = { "stylua" },
      ["sh"] = { "shfmt" },
      ["c"] = { "clang-format" },
      ["python"] = { "isort", "black" },
      ["javascript"] = { "prettier" },
      ["javascriptreact"] = { "prettier" },
      ["typescript"] = { "prettier" },
      ["typescriptreact"] = { "prettier" },
      ["vue"] = { "prettier" },
      ["css"] = { "prettier" },
      ["scss"] = { "prettier" },
      ["less"] = { "prettier" },
      ["html"] = { "prettier" },
      ["json"] = { "prettier" },
      ["jsonc"] = { "prettier" },
      ["yaml"] = { "prettier" },
      -- ["markdown"] = { "prettier" },
      -- ["markdown.mdx"] = { "prettier" },
      ["graphql"] = { "prettier" },
      ["handlebars"] = { "prettier" },
      ["sql"] = { "sql_formatter" },
      ["*"] = { "trim_whitespace" },
      ["_"] = { "trim_whitespace" },
    },
    -- The options you set here will be merged with the builtin formatters.
    -- You can also define any custom formatters here.
    formatters = {
      injected = { options = { ignore_errors = true } },
      -- # Example of using dprint only when a dprint.json file is present
      -- dprint = {
      --   condition = function(ctx)
      --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
      --
      -- # Example of using shfmt with extra args
      -- shfmt = {
      --   prepend_args = { "-i", "2", "-ci" },
      -- },
      black = {
        prepend_args = { "--line-length=80" },
      },
      prettier = {
        prepend_args = {
          "--tab-width=2", -- default: 2
          "--use-tabs=false", -- default: false
          "--print-width=80", -- default: 80
          "--no-semi=true", -- default: true
          "--single-quote=true", -- default: false
          "--trailing-comma=none", -- default: all
        },
      },
      sql_formatter = {
        prepend_args = {
          vim.fn.expand("--config=$HOME/.config/nvim/.sql-format.json"),
        },
      },
    },
  },
}
