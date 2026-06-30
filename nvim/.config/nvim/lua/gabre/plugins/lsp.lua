return {
	{ 'b0o/SchemaStore.nvim' },
	{
		'folke/lazydev.nvim',
		ft = 'lua',
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
				'bashls',
				'clangd',
				'cssls',
				'docker_compose_language_service',
				'gopls',
				'jsonls',
				'lua_ls',
				'marksman',
				'prismals',
				'pylsp',
				'rust_analyzer',
				'svelte',
				'tailwindcss',
				'taplo',
				'templ',
				'ts_ls',
				'vue_ls',
				'yamlls',
			},
			automatic_enable = false,
		},
		config = function(_, opts)
			require('gabre.lsp')
			require('mason-lspconfig').setup(opts)
		end,
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
