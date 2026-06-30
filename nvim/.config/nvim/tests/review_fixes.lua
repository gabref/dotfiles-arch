local root = vim.fn.getcwd() .. "/nvim/.config/nvim"

local function read(path)
	local file = assert(io.open(root .. "/" .. path, "r"))
	local contents = file:read("*a")
	file:close()
	return contents
end

for _, path in ipairs(vim.fn.glob(root .. '/**/*.lua', false, true)) do
	assert(loadfile(path), 'Lua syntax error in ' .. path)
end

local treesitter = read("lua/gabre/plugins/treesitter.lua")
assert(not treesitter:find("ensure_installed", 1, true), "obsolete Treesitter ensure_installed option remains")
assert(treesitter:find("vim.treesitter.start", 1, true), "Treesitter highlighting is not explicitly enabled")
assert(treesitter:find("require('nvim-treesitter').install", 1, true), "Treesitter parsers are not installed with the rewritten API")

local lsp = read("lua/gabre/lsp.lua")
assert(lsp:find("pylsp =", 1, true), "Python LSP config is not named pylsp")
assert(not lsp:find("pyright =", 1, true), "mismatched pyright configuration remains")
assert(lsp:find("filetypes = { \"toml\" }", 1, true), "Taplo uses the wrong filetypes field")
assert(lsp:find("vim.lsp.enable", 1, true), "custom LSP configurations are not enabled")
assert(not lsp:find("/home/gabre/", 1, true), "stale absolute Vue language-server path remains")

local configs = read("lua/gabre/configs.lua")
assert(not configs:find('M.load("lsp")', 1, true), "LSP configuration still loads on VeryLazy")

local lsp_plugin = read("lua/gabre/plugins/lsp.lua")
local configure_at = assert(lsp_plugin:find("require('gabre.lsp')", 1, true), "LSP module is not loaded by the LSP plugin spec")
local mason_at = assert(lsp_plugin:find("require('mason-lspconfig').setup", 1, true), "mason-lspconfig setup is not explicit")
assert(configure_at < mason_at, "custom LSP configuration must run before mason-lspconfig setup")
assert(lsp_plugin:find("'clangd'", 1, true), "clangd is not managed by Mason")
assert(lsp_plugin:find("'pylsp'", 1, true), "pylsp is not managed by Mason")
assert(lsp_plugin:find("'taplo'", 1, true), "taplo is not managed by Mason")

assert(vim.uv.fs_stat(root .. "/lua/gabre/plugins/obsidian.lua") == nil, "duplicate Markdown plugin spec remains")

local utils = read("lua/gabre/utils.lua")
assert(utils:find('nvim_buf_get_name(0) == ""', 1, true), "IsBufEmpty still has reversed semantics")

local keymaps = read("lua/gabre/keymaps.lua")
assert(keymaps:find('"[q", "<cmd>cprev<CR>zz"', 1, true), "[q does not navigate backward")
assert(keymaps:find('"]q", "<cmd>cnext<CR>zz"', 1, true), "]q does not navigate forward")

local header = read("lua/gabre/plugins/42_header.lua")
assert(not header:find('event = "VeryLazy"', 1, true), "42-header still loads unconditionally")

assert(not lsp_plugin:find("ft = 'lua',\n\t\tlazy = false", 1, true), "lazydev still loads for every filetype")

local git = read("lua/gabre/plugins/git.lua")
assert(not git:find("{ '<leader>gb', '<cmd>BlameToggle", 1, true), "blame.nvim conflicts with the Gitsigns blame mapping")

local harpoon = read("lua/gabre/plugins/harpoon.lua")
assert(not harpoon:find("{ '<leader>hr',", 1, true), "Harpoon conflicts with the Gitsigns reset-hunk mapping")

local lazy = read("lua/gabre/lazy_init.lua")
assert(lazy:find("rocks = { enabled = false }", 1, true), "unused LuaRocks support is still enabled")

local formatting = read("lua/gabre/plugins/formatting.lua")
assert(formatting:find("rust = { 'rustfmt', lsp_format = 'fallback' }", 1, true), "Rust is not configured to use rustfmt")

print("review fixes: ok")
