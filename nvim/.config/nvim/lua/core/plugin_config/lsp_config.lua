require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "angularls",
        "arduino_language_server",
        "bashls",
        "csharp_ls",
        "clangd",
        "cssls",
        "emmet_ls",
        "html",
        "eslint",
        "lua_ls",
        "marksman",
        "phpactor",
        "sqlls"
    }
})

require("lspconfig").angularls.setup {}
require("lspconfig").arduino_language_server.setup {}
require("lspconfig").bashls.setup {}
require("lspconfig").csharp_ls.setup {}
require("lspconfig").clangd.setup {}
require("lspconfig").cssls.setup {}
require("lspconfig").emmet_ls.setup {}
require("lspconfig").html.setup {}
require("lspconfig").eslint.setup {}
require("lspconfig").lua_ls.setup {}
require("lspconfig").marksman.setup {}
require("lspconfig").phpactor.setup {}
require("lspconfig").sqlls.setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

