local opt = vim.opt

-- Disable nvim intro
opt.shortmess:append "sI"
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"


local o = vim.o
o.laststatus = 3
o.showmode = false

------------------------------
-- Basic Editing Configuration
------------------------------
-- Allow unsaved background buffers and remember marks/undo for them.
o.hidden = true
-- Remember number of commands as history
o.history = 1000
-- Insert space characters whenever the tab key is pressed
o.expandtab = true
-- Be smart when using tabs lol
o.smarttab = true
-- Indenting.
o.smartindent = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
-- Bracket match.
o.showmatch = true

o.clipboard = "unnamedplus"
-- Hightlight the line where current cursor sits with # of number.
o.cursorline = true
o.cursorlineopt = "number"
o.guicursor = "n-v-i-c:block-Cursor"  -- Use block cursor for all modes.
-- Refine search pattern when typing.
o.incsearch = true
-- Search with highlight.
o.hlsearch = true
-- Make searches case-sensitive only if they contain upper-case characters
o.ignorecase = true
o.smartcase = true
-- Command line window height.
o.cmdheight = 1
-- Buffer management.
o.switchbuf = "useopen"
o.showtabline = 2
o.winwidth = 79
-- Keep more context when scrolling off the end of a buffer.
o.scrolloff = 5
-- Make no backups at all
o.backup = false
o.writebackup = false
-- Group all .swp files in one location
o.backupdir = "~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp"
o.directory = "/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp"
-- Allow backspacing over everything in insert mode
o.backspace = "indent,eol,start"
-- Display command while typing.
o.showcmd = true
-- Use emacs-style tab completion when selecting files, etc
o.wildmode = "longest,list"
-- Make tab completion for files/buffers act like bash
o.wildmenu = true
-- Fix slow O inserts.
o.timeout = true
o.timeoutlen = 1000
o.ttimeoutlen = 100
-- Turn on folding
o.foldmethod = syntax
o.foldlevel = 99
-- Insert only one space when joining lines that contain sentence-terminating
-- punctuation like `.`.
o.joinspaces = false
-- If a file is changed outside of vim, automatically reload it without asking
o.autoread = true

---------
-- Syntax
---------
o.syntax = "on"

-- Set line number.
o.number = true
o.relativenumber = true
o.numberwidth = 2
o.ruler = false

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.undofile = true

-- Interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

local g = vim.g
-- Disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
