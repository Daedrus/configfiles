-- Show help for keybinds
return {
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    opts = {},
    config = function ()
      require('which-key').add({
        {'<leader>c', group = '[C]ode' },
        {'<leader>d', group = '[D]ebugger' },
        {'<leader>g', group = '[G]it' },
        {'<leader>r', group = '[R]ename' },
        {'<leader>s', group = '[S]earch' },
        {'<leader>w', group = '[W]orkspace' },
      })
    end
  }
}
