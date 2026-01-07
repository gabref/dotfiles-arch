return {
	'nvim-lualine/lualine.nvim',
	event = 'VeryLazy',
	dependencies = {
		'linrongbin16/lsp-progress.nvim',
		---@diagnostic disable-next-line
		config = function() require('lsp-progress').setup() end
	},
	-- TODO: make it faster with rafi stuff
	config = function()
		local status, lualine = pcall(require, 'lualine')
		if not status then
			return
		end
		lualine.setup({
			options = {
				theme = 'auto',
				icons_enabled = true,
				section_separators = { left = '', right = '' },
				component_separators = { left = '', right = '' },
				disabled_filetypes = {},
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch' },
				lualine_c = {
					{
						'filename',
						file_status = true, -- displays file status (readonly status, modified status)
						path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
					},
				},
				lualine_x = {
					{
						'diagnostics',
						sources = { 'nvim_diagnostic' },
						symbols = {
							error = ' ',
							warn = ' ',
							info = ' ',
							hint = ' ',
						},
					},
					'encoding',
					'filetype',
				},
				lualine_y = {
					function()
						return require('lsp-progress').progress()
					end,
				},
				lualine_z = { 'location' },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					{
						'filename',
						file_status = true, -- displays file status (readonly status, modified status)
						path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
					},
				},
				lualine_x = { 'location' },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { 'fugitive' },
		})

		local group =
			vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
		vim.api.nvim_create_autocmd('User', {
			group = group,
			pattern = 'LspProgressStatusUpdated',
			---@diagnostic disable-next-line
			callback = require('lualine').refresh,
		})
	end,
}
