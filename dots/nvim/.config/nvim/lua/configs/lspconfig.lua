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
  "jdtls",
  "asm_lsp"
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

lspconfig.asm_lsp.setup {
  cmd = { "asm-lsp" },
  filetypes = { "asm", "vmasm", "nasm" },
  root_dir = lspconfig.util.root_pattern(".asm-lsp.toml", ".", ".git")
}
