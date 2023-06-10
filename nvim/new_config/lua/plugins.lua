-- Packer bootstrap, useful when porting this configuration to
-- another machine where Packer is not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Plugin manager
  use 'wbthomason/packer.nvim'

  -- Run git commands without leaving neovim
  use 'tpope/vim-fugitive'

  -- Pretty icons
  use 'kyazdani42/nvim-web-devicons'

  -- catppuccin theme
  use {
    'catppuccin/nvim',
    as = 'catppuccin'
  }

  -- Detect tabstop and shift width automatically
  use 'tpope/vim-sleuth'

  -- UUID generator
  use 'kburdett/vim-nuuid'

  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'

  -- Markdown preview
  use 'ellisonleao/glow.nvim'

  -- Tree file navigator
  use {
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons',
  }

  -- LSP Configuration & Plugins
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {}, tag = 'legacy' },

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  }

  -- "gc" to comment visual regions/lines
  use 'numToStr/Comment.nvim'

  -- Show help for keybinds
  use 'folke/which-key.nvim'

  -- Highlight, edit, and navigate code
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  -- Additional text objects via treesitter
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- First line in buffer is contextual
  use {
    'nvim-treesitter/nvim-treesitter-context',
    after = 'nvim-treesitter',
  }

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    cond = vim.fn.executable 'make' == 1
  }

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- Session management
  use 'rmagatti/auto-session'


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
