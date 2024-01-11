local opt = vim.opt

-- [[ General ]]
opt.spelllang = { "en" }

-- [[ Tabs / Indentation ]]
opt.tabstop = 4 -- Number of spaces a <Tab> counts for
opt.shiftwidth = 0 -- Number of spaces to use for each space of autoindent
opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations
opt.expandtab = true -- Expand tabs to spaces
opt.shiftround = true -- Rounds indent to multiple of `shiftwidth`, applies to > and <
opt.smartindent = true -- automatic indenting

-- [[ Appearance ]]
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers
opt.list = true -- Show some invisible characters (tabs...
---@diagnostic disable-next-line: assign-type-mismatch
opt.listchars = "tab:➛ ,trail:·" -- or "tab:»\ ,trail:·"
opt.showmode = true -- Dont show mode since we have a statusline
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.termguicolors = true -- True color support
opt.completeopt = "menu,menuone,noinsert,noselect" -- completion menu options

-- [[ Behavior ]]
opt.clipboard:append("unnamedplus") -- Sync with system clipboard
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.mouse = "a" -- Enable mouse mode
opt.autowrite = true -- Enable auto write
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
  "help",
  "globals",
  "skiprtp",
  "folds",
}
opt.undofile = true
opt.undolevels = 10000
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.timeoutlen = 300
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.winminwidth = 5 -- Minimum window width

-- [[ Search ]]
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals
opt.inccommand = "nosplit" -- preview incremental substitute
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode

-- [[ Navigation ]]
opt.scrolloff = 7 -- Lines of context
opt.sidescrolloff = 5 -- Columns of context

-- [[ Screen ]]
opt.splitright = true -- Put new windows right of current
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"

-- [[ Folding ]]
vim.opt.foldlevel = 99

-- [[ Formatting ]]
opt.wrap = false -- Disable line wrap
opt.textwidth = 79
opt.colorcolumn = "+1"
