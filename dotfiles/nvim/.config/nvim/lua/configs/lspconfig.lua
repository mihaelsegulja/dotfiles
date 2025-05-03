-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = {
  "omnisharp",
  "clangd",
  "html",
  "cssls",
  "ts_ls",
  "bashls",
  "sqlls",
  "marksman",
  "jdtls"
}

local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.omnisharp.setup {
  cmd = {
    vim.fn.stdpath("data") .. "/mason/packages/omnisharp/omnisharp",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid())
  }
}
