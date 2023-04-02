-- [ Setting options ]]

-- Set highlight on search
vim.o.hlsearch = true

-- Show matching brackets
vim.o.showmatch = true

-- Enable "hybrid" line number mode
-- All lines show their relative number except for current line,
-- which will show its absolute line number
vim.wo.number = true
vim.wo.relativenumber = true

-- Disable mouse
vim.o.mouse = ""

-- Enable break indent
vim.o.breakindent = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Show signcolumn (will be filled with info from LSP)
vim.wo.signcolumn = 'yes'

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Enable 24-bit RGB color
vim.o.termguicolors = true
