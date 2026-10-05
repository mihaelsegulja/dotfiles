local map = vim.keymap.set

map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })


map("n", "K", require("hover").hover, { desc = "hover.nvim" })
map("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })

map({ "n", "v" }, "<leader>-", "<cmd>Yazi<cr>", { desc = "Open yazi at current file" })
map("n", "<leader>cw", "<cmd>Yazi cwd<cr>", { desc = "Open yazi in cwd" })
map("n", "<C-Up>", "<cmd>Yazi toggle<cr>", { desc = "Resume yazi session" })

map("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true, desc = "Codeium accept" })
