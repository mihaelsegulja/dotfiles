return {
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    lazy = false,
    cmd = { "ConformInfo" },
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension "lazygit"
    end,
  },
  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup {
        init = function()
          require "hover.providers.lsp"
        end,
        preview_opts = {
          border = "single",
        },
        preview_window = false,
        title = true,
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "c",
        "cpp",
        "bash",
        "markdown",
        "java",
        "c_sharp",
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      padding = true,
    },
  },
}
