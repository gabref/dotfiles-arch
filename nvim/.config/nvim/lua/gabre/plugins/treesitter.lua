local parsers = {
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
	'tsx',
	'typescript',
	'vim',
	'vimdoc',
	'vue',
	'xml',
	'yaml',
	'zig',
}

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
		config = function()
			local treesitter = require('nvim-treesitter')
			treesitter.setup({})

			vim.api.nvim_create_autocmd('FileType', {
				group = vim.api.nvim_create_augroup('gabu_treesitter', { clear = true }),
				callback = function(event)
					if require('gabre.utils').IsBigBuff(event.buf) then
						return
					end

					if pcall(vim.treesitter.start, event.buf) then
						vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})

			if vim.fn.executable('tree-sitter') == 1 then
				vim.schedule(function()
					require('nvim-treesitter').install(parsers)
				end)
			end
		end
	}
}
