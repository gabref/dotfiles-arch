local map = require('gabre.utils').map
local group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	desc = 'LSP Actions',
	callback = function(event)
		local opts = { buffer = event.buf, silent = true, remap = false }

		map('n', 'K', vim.lsp.buf.hover, opts)
		map('n', 'gd', vim.lsp.buf.definition, opts)
		map('n', 'gD', vim.lsp.buf.declaration, opts)
		map('n', 'gr', vim.lsp.buf.references, opts)
		map('n', 'gi', vim.lsp.buf.implementation, opts)
		map('n', 'gt', vim.lsp.buf.type_definition, opts)
		map('i', '<c-s>', vim.lsp.buf.signature_help, opts)
		map('n', '<leader>cr', vim.lsp.buf.rename, opts)
		map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
		map('n', '<leader>vd', vim.diagnostic.open_float, opts)
		map('n', '<leader>vD', '<cmd>Telescope diagnostics bufrn=0<cr>', opts)
		map('n', 'gT', '<cmd>Telescope lsp_type_definitions<cr>', opts)
		map('n', 'gI', '<cmd>Telescope lsp_implementations<cr>', opts)
		map('n', 'gR', '<cmd>Telescope lsp_references<cr>', opts)
		vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end
})

vim.o.winborder = 'rounded'

local severity = vim.diagnostic.severity

vim.diagnostic.config({
	signs = {
		text = {
			[severity.ERROR] = '',
			[severity.WARN] = ' ',
			[severity.HINT] = ' ',
			[severity.INFO] = ' ',
		}
	},
	underline = true,
	severity_sort = true,
	update_in_insert = false,
	virtual_text = {
		spacing = 4,
		severity = nil,
		source = "if_many",
		format = nil,
		prefix = "●",
	},
	float = {
		source = "if_many",
		wrap_at = 64,
		format = function(d)
			if not d.code and not d.user_data then
				return d.message
			end
			local t = vim.deepcopy(d)
			local code = d.code
			if not code then
				if not d.user_data.lsp then
					return d.message
				end
				code = d.user_data.lsp.code
			end
			if code then
				t.message = string.format("%s [%s]", t.message, code):gsub("1. ", "")
			end
			return t.message
		end,
		border = "rounded",
	},
})

-- could get inspiration from here: https://github.com/Rishabh672003/Neovim/blob/main/lua%2Frj%2Flsp.lua
local servers = {
	gopls = {
		settings = {
			gopls = {
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
	},

	ts_ls = {
		-- from my old config, maybe there better solution nowadays
		filetypes = {
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"vue",
			"svelte",
			-- "astro",
		},
		cmd = { "typescript-language-server", "--stdio" },
		init_options = {
			name = "@vue/typescript-plugin",
			location = "/home/gabre/n/lib/node_modules/@vue/language-server",
			languages = { "vue" },
		},
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "literal",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	},

	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},


	clangd = {
		-- TODO: Could include cmd, but not sure those were all relevant flags.
		--    looks like something i would have added while i was floundering
		init_options = { clangdFileStatus = true },
		cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
		filetypes = { "c", "h", "cpp", "chh", "objc", "objcpp", "cuda", "proto" },
		root_markers = {
			".clangd",
			".clang-tidy",
			".clang-format",
			"compile_commands.json",
			"compile_flags.txt",
			"configure.ac",
			".git"
		},
		single_file_support = true,
	},

	docker_compose_language_service = {
		filetypes = { "yaml.docker-compose" },
		root_markers = {
			"docker-compose.yaml",
			"docker-compose.yml",
			"compose.yaml",
			"compose.yml",
			".git"
		},
		cmd = { "docker-compose-langserver", "--stdio" },
		single_file_support = true,
	},

	taplo = {
		filetype = { "toml" },
	},

	pyright = {
		filetypes = { "python" },
		root_markers = {
			"*.py",
			"__init__.py",
			".git",
			"ruff.toml",
			"pyproject.toml"
		},
		settings = {
			pylsp = {
				plugins = {
					autopep8 = { enabled = false },
					flake8 = { enabled = false },
					yapf = { enabled = false },
					mccabe = { enabled = false },
					pycodestyle = { enabled = false },
					pyflakes = { enabled = false },
					pylint = { enabled = false },
				},
			},
		},
		cmd = { "pylsp" },
		single_file_support = true,
	},
}


for server, config in pairs(servers) do
	vim.lsp.config[server] = config
end
