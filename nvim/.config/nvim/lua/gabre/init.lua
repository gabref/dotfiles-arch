vim.loader.enable()

local lazy = require('gabre.lazy_init')
local configs = require('gabre.configs')

lazy.bootstrap_lazy()
configs.init()
lazy.lazy_setup()
configs.setup()
