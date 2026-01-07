return {
	{
		'windwp/nvim-ts-autotag',
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-ts-autotag").setup()
		end
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	}
}
