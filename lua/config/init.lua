--[[
==============================================================================
======================= READ THIS BEFORE CONTINUING ==========================
==============================================================================

This is my neovim configuration, based on the kickstart template, LazyVim 
distribution, and as well as different resources on the internet

The different set of configurations are loaded in this order
    1. Options
    2. Plugins
    3. Keymaps
    4. Autocmds

--]]

-- [[ Options ]] -------------------------------------------------------------
require("config.options")

-- [[ Plugins ]] -------------------------------------------------------------
-- Install the Lazy Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to set the `mapleader` before loading any plugins
-- Set <space> as the leader key, see `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleaedr = "\\"

-- Load the lazy plugin manager, and your plugins
require("lazy").setup({
	spec = {
		-- Tell lazy from where to load your plugins, and it will load all the modules in that directory
		-- My plugins are found in 'plugins', which is the 'lua/plugins/' directory
		{ import = "plugins" },
		{ import = "plugins.lsp" },
	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		-- version = false, -- always use the latest git commit
		version = "*", -- try installing the latest stable version for plugins that support semver
	},
	install = { colorscheme = { "catppuccin-mocha", "habamax" } },
	checker = {
		-- automatically check for plugin updates
		enabled = false,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 3600, -- check for updates every hour
		check_pinned = false, -- check for pinned packages that can't be updated
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = true, -- get a notification when changes are found
	},
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- [[ Keymaps ]] ------------------------------------------------------------
require("config.keymaps")

-- [[ Autocmds ]] -----------------------------------------------------------
require("config.autocmds")
