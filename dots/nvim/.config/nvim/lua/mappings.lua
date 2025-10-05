require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Lazygit
map("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })

-- hover.nvim
map("n", "K", require("hover").hover, { desc = "hover.nvim" })
map("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
