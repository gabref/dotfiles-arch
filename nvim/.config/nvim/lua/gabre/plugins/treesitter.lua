return {

	-- accurate syntax hightlighting
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
		dependencies = {
			-- modern matchit and matchparen
			{
				'andymass/vim-matchup',
				init = function()
					vim.g.matchup_matchparen_offscreen = {}
				end,
			},
		},
		opts = {
			highlight = {
				enable = true,
				disable = function(_, buf)
					local max_filesize = 1024 * 1024 -- 1 mb
					local ok, stats =
					pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
			indent = { enable = true },
			refactor = {
				highlight_definitions = { enable = true },
				highlight_current_scope = { enable = true },
			},

			-- See: https://github.com/andymass/vim-matchup
			matchup = {
				enable = true,
				include_match_words = true,
			},
			-- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
			ensure_installed = {
				'astro',
				'bash',
				'c',
				'comment',
				'css',
				'csv',
				'cue',
				'diff',
				'dtd',
				'editorconfig',
				'fish',
				'git_config',
				'git_rebase',
				'gitattributes',
				'gitcommit',
				'gitignore',
				'graphql',
				'html',
				'http',
				'javascript',
				'jsdoc',
				'json5',
				'just',
				'lua',
				'luadoc',
				'luap',
				'make',
				'markdown',
				'markdown_inline',
				'printf',
				'python',
				'query',
				'readline',
				'regex',
				'rust',
				'scss',
				'sql',
				'ssh_config',
				'svelte',
				'toml',
				'vim',
				'vimdoc',
				'xml',
				'yaml',
				'zig',
			},
		},
		---@param opts TSConfig
		config = function(_, opts)
			require('nvim-treesitter').setup(opts)
		end
	}
}
