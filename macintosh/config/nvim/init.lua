-- Yifeng's nvim config.

-- `vim.g` is a Lua table which contains the global variables of the NeoVim environment.
-- `vim.o` is another Lua table for options, I guess...?
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins and local modules.
require("options")
require("lazy").setup("plugins")

-- Schedule require `mappings` to be invoded soon by the main event-loop to avoid textlock.
vim.schedule(function()
  require "mappings"
end)

-- Set colorschema.
vim.cmd.colorscheme "catppuccin-frappe"
