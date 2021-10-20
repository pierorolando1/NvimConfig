-- generic LSP settings
lvim.format_on_save = false
lvim.lsp.automatic_servers_installation = true

lvim.lsp.diagnostics.signs = {
  active = true,
  values = {
    { name = "LspDiagnosticsSignError", text = "" },
    { name = "LspDiagnosticsSignWarning", text = "" },
    { name = "LspDiagnosticsSignHint", text = "" },
    { name = "LspDiagnosticsSignInformation", text = "" }
  }
}

lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.diagnostics.update_in_insert = false
lvim.lsp.diagnostics.underline = true
lvim.lsp.diagnostics.severity_sort = true

-- Don't show diagnostics in tree
lvim.builtin.nvimtree.setup.diagnostics.enable = false

-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>

-- There is no setting in lvim to disable numhl atm
lvim.lsp.on_attach_callback = function(client, bufnr)
  local function disable_numhl()
    for _, sign in ipairs(lvim.lsp.diagnostics.signs.values) do
      vim.fn.sign_define(sign.name,
                         { texthl = sign.name, text = sign.text, numhl = "" })
    end
  end
  disable_numhl()
end

-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- More information: https://www.lunarvim.org/languages
lvim.lang.python.formatters = { { exe = "black" } }

lvim.lang.lua.formatters = {
  {
    exe = "lua-format",
    args = {
      "--indent-width", lvim.custom.tab, "--spaces-inside-table-braces",
      "--no-chop-down-table", "--no-keep-simple-function-one-line",
      "--no-keep-simple-control-block-one-line",
      "--single-quote-to-double-quote"
    }
  }
}

-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--   }
-- }