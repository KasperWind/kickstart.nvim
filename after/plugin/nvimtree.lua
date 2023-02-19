-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1

  if data.file == "" then
    return
  end

  if directory then
    vim.cmd.cd(data.file)
  end

  require("nvim-tree.api").tree.open()

  if not directory then
    local windows = vim.api.nvim_list_wins()
    if #windows > 1 then
      vim.api.nvim_set_current_win(windows[2])
    end
  end
end


-- auto startup
vim.api.nvim_create_autocmd({"VimEnter"}, { callback = open_nvim_tree})


