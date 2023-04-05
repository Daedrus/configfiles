require('auto-session').setup {
    log_level = "info",
    auto_session_suppress_dirs = { "/", "~/" },
    auto_session_create_enable = false,
}

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
