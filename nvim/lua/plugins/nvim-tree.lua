-- Tree file navigator
return {
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
      }
    end
  }
}
