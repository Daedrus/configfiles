-- Session management
return {
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = "error",
        auto_session_suppress_dirs = { "/", "~/" },
        auto_session_create_enabled = false,
      }

      vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end
  }
}
