vim.keymap.set("n", "<leader>dc", ":lua require('dap').continue()<CR>")
vim.keymap.set("n", "<leader>do", ":lua require('dap').step_over()<CR>")
vim.keymap.set("n", "<leader>di", ":lua require('dap').step_into()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require('dap').toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<leader>bc", ":lua require('dap').countinue()<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require('dap').repl.open()<CR>")
