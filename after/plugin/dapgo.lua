local dapgo = require('dap-go')

dapgo.setup()

vim.keymap.set("n", "<leader>dt", ":lua dap-go.debug_test()<CR>")


