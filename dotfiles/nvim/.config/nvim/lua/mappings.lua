require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })
