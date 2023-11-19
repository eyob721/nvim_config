return {
    "stevearc/conform.nvim",
    opts = function()
        ---@class ConformOpts
        local opts = {
            -- LazyVim will use these options when formatting with the conform.nvim formatter
            format = {
                timeout_ms = 3000,
                async = false, -- not recommended to change
                quiet = false, -- not recommended to change
            },
            ---@type table<string, conform.FormatterUnit[]>
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
                ["markdown"] = { "prettier" },
                ["markdown.mdx"] = { "prettier" },
                ["graphql"] = { "prettier" },
                ["handlebars"] = { "prettier" },
                ["sql"] = { "sqlfmt" },
                ["_"] = { "trim_whitespace" },
            },
            -- The options you set here will be merged with the builtin formatters.
            -- You can also define any custom formatters here.
            ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
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
                        "--tab-width=4",
                        "--use-tabs=false",
                    },
                },
            },
        }
        return opts
    end,
}
