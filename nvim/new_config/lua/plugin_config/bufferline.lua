require('bufferline').setup({
  options = {
    show_buffer_close_icons = false,
    show_close_icon = false
  }
})

vim.keymap.set('n', '<leader>gB', ':BufferLinePick<CR>')
vim.keymap.set('n', '<leader>gC', ':BufferLinePickClose<CR>')
