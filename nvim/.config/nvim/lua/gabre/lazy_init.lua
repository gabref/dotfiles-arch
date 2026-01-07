local M = {}

local has_user_plugins = false

function M.bootstrap_lazy()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
		local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
		if vim.v.shell_error ~= 0 then
			vim.api.nvim_echo({
				{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
				{ out, "WarningMsg" },
				{ "\nPress any key to exit..." },
			}, true, {})
			vim.fn.getchar()
			os.exit(1)
		end
	end
	vim.opt.rtp:prepend(lazypath)
end

function M.lazy_setup()
	-- validate if lua/plugins or lua/plugins.lua exists
	local user_path = vim.fn.stdpath("config") .. "/lua"
	has_user_plugins = vim.uv.fs_stat(user_path .. "/plugins") ~= nil
	or vim.uv.fs_stat(user_path .. "/plugins.lua") ~= nil

	-- Setup lazy.nvim
	require("lazy").setup({
		spec = {
			-- import your plugins
			{ import = "gabre.plugins" },
			has_user_plugins and { import = "plugins" } or nil,
		},
		-- Configure any other settings here. See the documentation for more details.
		-- colorscheme that will be used when installing plugins.
		install = { missing = true, colorscheme = { "habamax" } },
		-- automatically check for plugin updates (async)
		checker = { enabled = true, notify = false },
		concurrency = vim.uv.available_parallelism() * 2,
		defaults = { lazy = true, version = false },
		change_detection = { notify = false },
		diff = { cmd = 'terminal_git' },
		ui = {
			size = { width = 0.8, height = 0.85 },
			border = 'rounded',
			wrap = false,
		},
		performance = {
			rtp = {
				disabled_plugins = {
					"gzip",
					"vimballPlugin",
					"matchit",
					"matchparen",
					"2html_plugin",
					"tarPlugin",
					-- "netrwPlugin",
					"tutor",
					"zipPlugin",
				}
			}
		}

	})
end

return M
