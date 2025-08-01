local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    cpp = { "clang_format" },
    c = { "clang_format" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },
    c_sharp = { "csharpier" },
  },
  formatters = {
    clang_format = {
      command = "clang-format",
      args = { "--assume-filename", "$FILENAME" },
    },
    prettier = {
      command = "prettier",
      args = { "--stdin-filepath", "$FILENAME" },
    },
    csharpier = {
      command = "csharpier",
      args = { "--write-stdout", "--fast", "$FILENAME" },
    },
  },
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
}

return options
