---- WSL: use Windows clipboard for + and * registers
--if vim.fn.has("wsl") == 1 then
--	print("hello from wsl")
--  vim.g.clipboard = {
--    name = "WslClipboard",
--    copy = {
--      ["+"] = "clip.exe",
--      ["*"] = "clip.exe",
--    },
--    paste = {
--      ["+"] = 'powershell.exe -NoProfile -Command Get-Clipboard',
--      ["*"] = 'powershell.exe -NoProfile -Command Get-Clipboard',
--    },
--    cache_enabled = 0,
--  }
--end
--
---- Leader-based system clipboard y/p
--vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to Windows clipboard" })
--vim.keymap.set("n", "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank line to Windows clipboard" })
--
--vim.keymap.set("n", "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from Windows clipboard" })
--vim.keymap.set("v", "<leader>p", '"+p', { noremap = true, silent = true, desc = "Paste from Windows clipboard" })

require("gabre")

