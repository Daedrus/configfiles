require('auto-session').setup {
    log_level = "info",
    auto_session_suppress_dirs = { "/", "~/" },
    auto_save_enabled = true,
    auto_restore_enabled = true,
}
