-- [ Options ]]

-- Set highlight on search but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Show matching brackets
vim.opt.showmatch = true

-- Enable "hybrid" line number mode
-- All lines show their relative number except for current line,
-- which will show its absolute line number
vim.wo.number = true
vim.wo.relativenumber = true

-- Disable mouse
vim.opt.mouse = ""

-- Enable break indent
vim.opt.breakindent = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- Show signcolumn (will be filled with info from LSP)
vim.wo.signcolumn = 'yes'

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Enable 24-bit RGB color
vim.opt.termguicolors = true

-- Always use system clipboard
vim.opt.clipboard = 'unnamedplus'

--- Highlight tabs, trailing whitespaces and non-breaking spaces
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Show which line the cursor is on
vim.opt.cursorline = true

-- Don't show the mode since it's already in the status line
vim.opt.showmode = false
