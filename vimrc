set nocompatible        " Use Vim defaults (much better!)
set bs=2                " Allow backspacing over everything in insert mode
"set backup             " Keep a backup file
set viminfo='20,\"500   " read/write a .viminfo file -- limit regs to 500 lines
set history=50          " keep 50 lines of command history
set ruler               " Show the cursor position all the time
set autoindent
set number

" Turn autoindent/smartindent on or off for copy/paste
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O><F2>
set pastetoggle=<F2>
" End

map <F3> :set nonumber<CR>:set nolist<CR>
map <F4> :set number<CR>:set list<CR>

if !has("gui_running")
	set so=9999
endif

set nomodeline

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
  set fileencodings=utf-8,latin1
endif

" add cscope tags
"set tags+=

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
"DM  color tango
  set hlsearch
endif

" font for gui to use
if has("gui_running")
  set gfn=Monospace\ 10
endif

function DiffD()
   let opt = ""
   if &diffopt =~ "icase"
     let opt = opt . "-i "
   endif
   if &diffopt =~ "iwhite"
     let opt = opt . "-b "
   endif
   silent execute "!diff -d " . opt . v:fname_in . " " . v:fname_new .
	\  " > " . v:fname_out
endfunction

function GotoLine(l)
    normal m'
    call cursor(a:l, 0)
    keepjumps normal ^
endfunction

function PythonUpSection()
    let l = line(".")
    let ind = indent(l)
    while l && (indent(l) >= ind || getline(l) =~ "^\s*#")
        let l = prevnonblank(l-1)
    endwhile
    call GotoLine(l)
endfunction

function PythonPrevSection()
    let l = line(".")
    let ind = indent(l)
    let l = prevnonblank(l-1)
    while l && (indent(l) > ind || getline(l) =~ "^\s*#")
        let l = prevnonblank(l-1)
    endwhile
    call GotoLine(l)
endfunction

function PythonNextSection()
    let l = line(".")
    let ind = indent(l)
    let l = nextnonblank(l+1)
    while l < line("$") && (indent(l) > ind || getline(l) =~ "^\s*#")
        let l = nextnonblank(l+1)
    endwhile
    call GotoLine(l)
endfunction

function SetupPython()
    filetype indent on
    set formatoptions=tcq
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    set showmatch
    set background=dark
    map [{ :call PythonUpSection()<CR>
    map [[ :call PythonPrevSection()<CR>
    map ]] :call PythonNextSection()<CR>
endfunction

function SetupTmpl()
    filetype indent on
    set formatoptions=tcq
    set autoindent
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set expandtab
    set showmatch
endfunction

function SetupHtml()
    filetype indent on
    set formatoptions=tcq
    set autoindent
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set expandtab
    set showmatch
endfunction

function SetupJava()
    filetype indent on
    "set formatoptions=tcq
    set autoindent
    set si
    set tabstop=4
    set softtabstop=2 "When you type tab
    set shiftwidth=2 "When you type enter then dentation it gives.
    "set expandtab
    "set showmatch
    "Java anonymous classes. Sometimes, you have to use them.
    set cinoptions+=j1
    let java_comment_strings=1
    let java_highlight_java_lang_ids=1
endfunction

function SetupScala()
    "Scala setup
    syntax on
    set showmatch

    "colorscheme delek

    filetype indent on
    filetype on
    set autoindent
    set si

    set expandtab
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
endfunction


autocmd BufRead,BufNewFile *.py call SetupPython()
autocmd BufRead,BufNewFile *.tmpl call SetupTmpl()
autocmd BufRead,BufNewFile *.html call SetupHtml()
autocmd BufRead,BufNewFile *.java call SetupJava()
autocmd BufRead,BufNewFile *.scala call SetupScala()

"set diffexpr=DiffD()
"diffupdate
