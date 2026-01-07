return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ '<leader>hm', function()
			local harpoon = require('harpoon')
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, desc = 'List locations' },
		{ '<leader>ha', function() require('harpoon'):list():add() end, desc = 'Add Location' },
		{ '<leader>hr', function() require('harpoon'):list():remove() end, desc = 'Remove Location' },
		{ '<localleader>1', function() require('harpoon'):list():select(1) end, desc = 'Harpoon to File 1' },
		{ '<localleader>2', function() require('harpoon'):list():select(2) end, desc = 'Harpoon to File 2' },
		{ '<localleader>3', function() require('harpoon'):list():select(3) end, desc = 'Harpoon to File 3' },
		{ '<localleader>4', function() require('harpoon'):list():select(4) end, desc = 'Harpoon to File 4' },
		{ '<localleader>5', function() require('harpoon'):list():select(5) end, desc = 'Harpoon to File 5' },
	},
}
