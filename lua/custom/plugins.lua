return function(use)
  -- Colorscheme
  use 'ellisonleao/gruvbox.nvim'

  -- Rust
  use 'simrat39/rust-tools.nvim'

  -- Telescope dependencies
  use {'BurntSushi/ripgrep'}
  use {'sharkdp/fd'}
  use {'nvim-tree/nvim-web-devicons'}

  -- Undo tree
  use 'mbbill/undotree'
  
   -- A simple file explorer
  use 'preservim/nerdtree'

  -- comment/uncomment
  use 'terrortylor/nvim-comment'

  -- DAP
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use 'theHamsta/nvim-dap-virtual-text'
  use 'nvim-telescope/telescope-dap.nvim'

  -- go dap
  use 'leoluz/nvim-dap-go'
end
