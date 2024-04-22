local lsp = {}

lsp.setup = function ()
  require("mason").setup()

  require("mason-lspconfig").setup({
    ensure_installed = {
      "clangd",
      "cmake",
      "pyright",
      "lua_ls",
      "bashls",
    },
  })

  local lspconfig = require('lspconfig')

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      require("lspconfig")[server_name].setup {}
    end,
    -- Next, you can provide targeted overrides for specific servers.
    ['rust_analyzer'] = function() end,
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      }
    end,
  })
end

return lsp

