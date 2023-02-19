
vim.o.termguicolors = true
-- use command line :set background=light 
--vim.o.background = light
vim.g.gruvbox_material_better_performance = 1
vim.cmd [[colorscheme gruvbox-material]]

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox-material',
  },
}
