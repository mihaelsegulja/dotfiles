-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = {
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

local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"

if not configs.roslyn then
  configs.roslyn = {
    default_config = {
      cmd = {
        "roslyn",
        "--logLevel", "information",
        "--extensionLogDirectory", vim.fn.stdpath("cache") .. "/roslynLspLogs",
        "--stdio",
      },
      filetypes = { "cs", "vb" },
      root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
      single_file_support = true,
    },
  }
end

lspconfig.roslyn.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

lspconfig.asm_lsp.setup {
  cmd = { "asm-lsp" },
  filetypes = { "asm", "vmasm", "nasm" },
  root_dir = lspconfig.util.root_pattern(".asm-lsp.toml", ".", ".git")
}
