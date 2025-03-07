
vim.o.termguicolors = true
-- use command line :set background=light 


local temp = os.date("*t", os.time())
local h = tonumber(temp.hour)
if h > 8 and h < 17 then
  vim.o.background = "light"
else
  vim.o.background = "dark"
end

vim.g.gruvbox_material_better_performance = 1

vim.cmd [[colorscheme gruvbox-material]]
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox-material',
  },
}
