vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2

-- hey vim, try to be smart about my indent
vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- vim.opt.expandtab = true

vim.opt.smartindent = true

-- tj said I had to turn this one on https://github.com/tjdevries/config.nvim/blob/master/plugin/options.lua
vim.opt.inccommand = "split"

-- split that makes sense
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

-- no back up file, but undotree keeps track
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
local undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.fn.mkdir(undodir, "p")
vim.opt.undodir = undodir

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- nicer search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

vim.opt.termguicolors = true

vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- remembers stuff when exit neovim
vim.opt.shada = { "'10", "<0", "s10", "h" }

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.cursorline = true

vim.opt.showmode = false      -- mode is usually shown by statusline/plugins; keeps cmdline clean

-- from tjdevries, similar
-- stop the automatic commenting on new line
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25

-- 42 stuff
vim.g.user42 = "galves-f"
vim.g.mail42 = "marvin@42.fr"
vim.opt.smarttab = true

