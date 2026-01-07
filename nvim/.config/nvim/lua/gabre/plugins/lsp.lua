return {
	{ 'b0o/SchemaStore.nvim' },
	{
		'folke/lazydev.nvim',
		ft = 'lua',
		lazy = false,
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
			},
		},
	},
	{
		'williamboman/mason-lspconfig.nvim',
		lazy = false,
		opts = {
			ensure_installed = {
				'astro',
				'lua_ls',
				'bashls',
				'templ',
				'gopls',
				'prismals',
				'rust_analyzer',
				'cssls',
				'jsonls',
				'tailwindcss',
				'ts_ls',
				'marksman',
				'yamlls',
			},
		},
		dependencies = {
			{
				'williamboman/mason.nvim',
				lazy = false,
				opts = {},
				config = function()
					require('mason').setup({
						ui = {
							border = 'rounded',
							icons = {
								package_installed = '✓',
								package_pending = '➜',
								package_uninstalled = '✗',
							},
						},
					})
				end,
			},
			'neovim/nvim-lspconfig',
		},
	},
}
