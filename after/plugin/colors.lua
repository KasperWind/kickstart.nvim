
vim.o.termguicolors = true
vim.cmd [[colorscheme gruvbox-material]]
--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox-material',
  },
}
