-- LSP Configuration & Plugins
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'mason-org/mason.nvim', config = true },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- Create a function that lets us more easily define mappings specific for LSP related
          -- items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

        end,
      })

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. They will be passed to
      --  the `settings` field of the server config. You must look up that documentation yourself.
      --
      --  Note that while linters and formatters _can_ be installed through Mason's menu, they can't
      --  be hardcoded in the config in same way as LSPs can below. For that, an alternative plugin
      --  such as jose-elias-alvarez/null-ls.nvim needs to be used. Not sure if there is a reasoning
      --  behind this or if the functionality will eventually be added to Mason.
      local servers = {
        bashls = {},
        clangd = {},
        dockerls = {},
        docker_compose_language_service = {},
        lua_ls = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
          },
        },
        pyright = {},
        rust_analyzer = {
          ['rust-analyzer'] = {
            check = {
              allTargets = false,
            },
            inlayHints = {
              lifetimeElisionHints = {
                enable = true,
                useParameterNames = true,
              },
              reborrowHints = {
                enable = true,
              },
              implicitDrops = {
                enable = true,
              }
            }
          }
        },
        yamlls = {
          yaml = {
            keyOrdering = false,
            customTags = "!reference sequence"
          }
        },
      }

      -- Only add the nix LSP on machines that have nix
      if vim.fn.executable('nix') == 1 then
        servers["nil_ls"] = {}
      end

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            local config = servers[server_name] or {}
            vim.lsp.config(server_name, config)
            vim.lsp.enable(server_name)
          end,
        },
      }
    end,
  },
}
