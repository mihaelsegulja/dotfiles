-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "gruvbox",
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

local gray = "#7c6f64"
local dark_gray = "#3c3836"
local aqua = "#689d6a"
vim.cmd(string.format("highlight Gray guifg=%s gui=NONE guibg=NONE", gray))
vim.cmd(string.format("highlight DarkGray guifg=%s gui=NONE guibg=NONE", dark_gray))
vim.cmd(string.format("highlight Aqua guifg=%s gui=NONE guibg=NONE", aqua))

M.ui = {
  number = true,
  relativenumber = true,
  telescope = { style = "bordered" },
  hl_override = {
    CursorLine = { bg = "one_bg" },
  },
  statusline = {
    separator_style = "block",
    theme = "default",
    order = {
      "mode",
      "file",
      "git",
      "%=",
      "lsp_msg",
      "%=",
      "diagnostics",
      "lsp",
      "filetype",
      "encoding",
      "indent",
      -- "file_size",
      "cwd",
      "cursor",
    },
    modules = {
      sep = function()
        return "%#DarkGray#|%* "
      end,
      encoding = function()
        local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
        local ff = vim.bo.fileformat
        return string.format("%%#Gray#%s[%s] %%*", enc:lower(), ff:lower())
      end,
      filetype = function()
        return string.format("%%#Aqua#%s %%*", vim.bo.filetype)
      end,
      indent = function()
        if vim.bo.expandtab then
          return string.format("%%#Gray#Spcs:%d %%*", vim.bo.shiftwidth)
        else
          return string.format("%%#Gray#Tbsz:%d %%*", vim.bo.tabstop)
        end
      end,
      file_size = function()
        local file = vim.fn.expand "%:p "
        local size

        --Don't show size if empty buffer
        if file == "" or vim.fn.getfsize(file) < 0 then
          return ""
        end

        local fsize = vim.fn.getfsize(file)
        local kib = 1024
        local mib = kib * 1024
        local gib = mib * 1024

        if fsize < kib then
          size = string.format("%%#Gray#%dB %%*", fsize)
        elseif fsize < mib then
          size = string.format("%%#Gray#%.1f KiB %%*", fsize / kib)
        elseif fsize < gib then
          size = string.format("%%#Gray#%.1f MiB %%*", fsize / mib)
        else
          size = string.format("%%#Gray#%.1f GiB %%*", fsize / gib)
        end

        return size
      end,
    },
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    "                                                                   ",
    "      ████ ██████           █████      ██                    ",
    "     ███████████             █████                            ",
    "     █████████ ███████████████████ ███   ███████████  ",
    "    █████████  ███    █████████████ █████ ██████████████  ",
    "   █████████ ██████████ █████████ █████ █████ ████ █████  ",
    " ███████████ ███    ███ █████████ █████ █████ ████ █████ ",
    "██████  █████████████████████ ████ █████ █████ ████ ██████",
    " ",
    " ",
    " ",
    " ",
    " ",
  },
}

return M
