return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        roslyn = {
          mason = false,
          cmd = {
            vim.fn.expand(vim.fn.stdpath "data" .. "/mason/packages/roslyn/roslyn"),
            "--stdio",
            "--logLevel=Information",
            "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
          },
          filetypes = { "cs", "cshtml", "razor" },
          settings = {
            ["csharp|inlay_hints"] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_lambda_parameter_types = true,
              csharp_enable_inlay_hints_for_types = true,
              dotnet_enable_inlay_hints_for_parameters = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            },
          },
        },
      },
    },
  },
}
