local nvlsp = require "nvchad.configs.lspconfig"
nvlsp.defaults()

vim.lsp.enable {
  "clangd",
  "html",
  "cssls",
  "ts_ls",
  "bashls",
  "sqlls",
  "marksman",
  "jdtls",
}

local mason_path = vim.fn.stdpath "data" .. "/mason/packages"

local rzls_path = mason_path .. "/rzls/libexec"
local roslyn_cmd = {
  vim.fn.expand(mason_path .. "/roslyn/roslyn"),
  "--stdio",
  "--logLevel=Information",
  "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
  "--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
  "--razorDesignTimePath=" .. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
  "--extension",
  vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
}

vim.lsp.config("roslyn", {
  cmd = roslyn_cmd,
  settings = {
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_lambda_parameter_types = true,
      csharp_enable_inlay_hints_for_types = true,
      dotnet_enable_inlay_hints_for_parameters = true,
      dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
    },
  },
})

vim.lsp.enable "roslyn"

vim.diagnostic.config {
  underline = true,
  virtual_text = false,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
}
