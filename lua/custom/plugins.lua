return function(use)
  -- Colorscheme
  --use 'ellisonleao/gruvbox.nvim'
  use 'sainnhe/gruvbox-material'

  -- Rust
  use 'simrat39/rust-tools.nvim'
  use 'nvim-tree/nvim-tree.lua'

  use 'theprimeagen/harpoon'

  -- Telescope dependencies
  use {'BurntSushi/ripgrep'}
  use {'sharkdp/fd'}
  use {'nvim-tree/nvim-web-devicons'}

  -- Undo tree
  use 'mbbill/undotree'

  -- comment/uncomment
  use 'terrortylor/nvim-comment'

  -- DAP
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use 'theHamsta/nvim-dap-virtual-text'
  use 'nvim-telescope/telescope-dap.nvim'

  -- go dap
  use 'leoluz/nvim-dap-go'

  use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}
end
