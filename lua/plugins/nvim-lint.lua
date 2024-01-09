return {
    "mfussenegger/nvim-lint",
    opts = {
        -- Event to trigger linters
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        linters_by_ft = {
            -- shellcheck is not needed here, mason handles it
            -- sh = { "shellcheck" },
            -- TODO: Add linter for C files
            -- c = { "cpplint" }, -- not a good linter
            python = { "pycodestyle" },
            markdown = { "markdownlint" },
            javascript = { "eslint" },

            -- NOTE: For eslint, you must generate a .eslintrc.js configuration
            -- file at the root of your project. To do this run the command
            -- `npm init @eslint/config` and follow the prompts. If you get an
            -- error saying that the package.json file is missing, you can
            -- create that as well using `npm init` command.

            -- Use the "*" filetype to run linters on all filetypes.
            -- ['*'] = { 'global linter' },
            -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
            -- ['_'] = { 'fallback linter' },
        },
        -- LazyVim extension to easily override linter options
        -- or add custom linters.
        ---@type table<string,table>
        linters = {
            -- -- Example of using selene only when a selene.toml file is present
            -- selene = {
            --   -- `condition` is another LazyVim extension that allows you to
            --   -- dynamically enable/disable linters based on the context.
            --   condition = function(ctx)
            --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
            --   end,
            -- },
            markdownlint = {
                args = {
                    "--disable MD013",
                },
            },
        },
    },
}
