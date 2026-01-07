local M = {}

local lazy_clipboard
local group = vim.api.nvim_create_augroup("GabuVim", { clear = true })

-- load lua/gabre/* files
-- @param name 'autocmds' | 'options' | 'keymaps' | 'terminal' | 'lsp'
function M.load(name)
	require('gabre.' .. name)
	if vim.bo.filetype == 'lazy' then
		vim.cmd([[do VimResized]])
	end
	local pattern = 'GabuVim' .. name:sub(1, 1):upper() .. name:sub(2)
	vim.api.nvim_exec_autocmds('User', {
		pattern = pattern,
		modeline = false,
	})
end

function M.init()
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
	-- vim.uv = vim.uv or vim.loop

	lazy_clipboard = vim.opt.clipboard
	vim.opt.clipboard = ""  -- avoid provider cost on startup (WSL)
	require('gabre.options')
end

-- LATE: after lazy.nvim finished
function M.setup()

	local lazy_autocmds = vim.fn.argc(-1) == 0

	if not lazy_autocmds then
		M.load('autocmds')
	end

	vim.api.nvim_create_autocmd("User", {
		group = group,
		pattern = "VeryLazy",
		callback = function()
			if lazy_autocmds then
				M.load('autocmds')
			end
			M.load("keymaps")
			M.load("terminal")
			M.load("lsp")
			M.clipboard()
			if lazy_clipboard ~= nil then
				vim.opt.clipboard = lazy_clipboard
			end
		end,
	})

end

function M.clipboard()
	if vim.fn.has("wsl") == 1 then
		-- Provide +/* registers via Windows clipboard
		vim.g.clipboard = {
			name = "WslClipboard",
			copy = {
				["+"] = "clip.exe",
				["*"] = "clip.exe",
			},
			paste = {
				["+"] = 'powershell.exe -NoProfile -Command Get-Clipboard',
				["*"] = 'powershell.exe -NoProfile -Command Get-Clipboard',
			},
			cache_enabled = 0,
		}
	end
end

return M
