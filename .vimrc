" This is Yifeng's .vimrc file


"""""""""""""""""""""""
" Bundle plugin session.
"""""""""""""""""""""""
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'altercation/vim-colors-solarized'
Plugin 'wincent/command-t'
Plugin 'taglist.vim'
Plugin 'python.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='luna'
let g:airline_powerline_fonts = 1
function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
endfunction
autocmd VimEnter * call AirlineInit()
Plugin 'scrooloose/nerdtree'
" Fireup nerdtree when vim with no args
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""
" Basic Editing Configuration
"""""""""""""""""""""""""""""
set nocompatible
" allow unsaved background buffers and remember marks/undo for them
set hidden
" Remember number of commands as history
set history=1000
" insert space characters whenever the tab key is pressed
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" show matched bracket
set showmatch
" refine search pattern when typing
set incsearch
" search with highlight
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" command line window height
set cmdheight=1
" buffer management...
set switchbuf=useopen
set showtabline=2
set winwidth=79
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=5
" make no backups at all
set nobackup
set nowritebackup
" group all .swp files in one location
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display command while typing
set showcmd
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
" Fix slow O inserts
set timeout timeoutlen=1000 ttimeoutlen=100
" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1
" Turn on folding
set foldmethod=syntax
set foldlevel=99
" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces
" If a file is changed outside of vim, automatically reload it without asking
set autoread
" set line number.
set number

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " remove trailing whitespaces triggered by pre buffer write event
  autocmd BufWritePre * :%s/\s\+$//e
  autocmd FileType python nnoremap <buffer> <leader>c I#<esc>
  " recover last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " language indentation & softtabstops & expandtab
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,java,scala set ai sw=2 sts=2 et
  autocmd FileType python set ai sw=4 sts=4 et
augroup END

""""""""
" Status
""""""""
" set status line
" Commented out because of plugin 'vim-airline'
"set statusline=%<%F%h%m%r%h%w%y\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ %l\/%L\,%c%V\ %P
set laststatus=2

""""""""""""
" Syntax
"""""""""""
syntax on
syntax enable

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR & Scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
"colorscheme base16-ocean
"let base16colorspace=256

""""""""""""""""""
" Mapping & Leader
""""""""""""""""""
let mapleader=","

:nmap <space> viw
:imap <c-d> <esc>ddi

" Plugin taglist.vim. Toggle Tag list.
nnoremap <leader><leader>t :TlistToggle<CR>
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Disable arrow keys in normal mode.
let noarrowkeys="Arrow keys not allowed in normal mode motherfucker!"
noremap <Up> :echo noarrowkeys<CR>
noremap <Down> :echo noarrowkeys<CR>
noremap <Left> :echo noarrowkeys<CR>
noremap <Right> :echo noarrowkeys<CR>

" Insert a hash rocket with <c-l>
inoremap <c-l> <space>=><space>
" Insert a left rocket with <c-k>
inoremap <c-k> <space><-<space>
" Can't be bothered to understand ESC vs <c-c> in insert mode
" inoremap <c-c> <esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    echom "debug: " . col
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    echom 'old: ' . old_name
    call inputsave()
    let new_name = input('New file name: ')
    " to avoid Vim typeahead mechanism.
    call inputrestore()

    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RemoveFancyCharacters COMMAND
" Remove smart quotes, etc.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RemoveFancyCharacters()
    let typo = {}
    let typo["“"] = '"'
    let typo["”"] = '"'
    let typo["‘"] = "'"
    let typo["’"] = "'"
    let typo["–"] = '--'
    let typo["—"] = '---'
    let typo["…"] = '...'
    :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! RemoveFancyCharacters :call RemoveFancyCharacters()

"""""""""""""""""""""""""""""""""""""""
" Python boilerlate generator
" 1. to generater function signature
" 2. to generator class and init method
" 3.
"""""""""""""""""""""""""""""""""""""""
function! PutByLines(lines)
    for line in a:lines
        put =line
    endfor
endfunction

function! GenDocString(args, indentation)
    " cancate indentation prefix.
    let indentation = a:indentation
    let prefix = ''
    while indentation > 0
        let indentation -= 1
        let prefix .= ' '
    endwhile
    echom strlen(prefix)

    let doc_string_line = []
    let docstring = prefix . '"""docstring'
    if len(a:args) > 0
        call add(doc_string_line, docstring)
        call add(doc_string_line, '')
        for arg in a:args
            call add(doc_string_line, prefix . ':param ' . arg . ':')
        endfor
        call add(doc_string_line, prefix . '"""')
    else
        " no args, keep docstring as one line.
        let docstring .= '"""'
        call add(doc_string_line, docstring)
    endif

    call PutByLines(doc_string_line)
endfunction

"""""""""""""""""""""""
" CreatePythonFunction
"""""""""""""""""""""""
function! CreatePythonFunction()
    let function_name = input('Function name: ')
    let args = split(input('Arguments: '), ',')
    let lines = []
    let indentation = '    '

    " gen function declaration.
    let declaration = 'def ' . function_name . '('
    for arg in args
        let declaration .= arg . ', '
    endfor
    if len(args) > 0
        let declaration = declaration[:-3]
    endif
    let declaration .= '):'
    call add(lines, declaration)
    call PutByLines(lines)

    call GenDocString(args, 4)

    " gen function body
    let lines = [indentation . 'return']
    call PutByLines(lines)

endfunction

noremap <leader>cf :call CreatePythonFunction()<cr>

"""""""""""""""""""
" CreatePythonClass
""""""""""""""""""
function! CreatePythonClass()
    let class_name = input('Class name: ')
    let args = split(input('Arguments: '), ',')
    let lines = []
    let indentation = '    '

    " gen class declaration and class doc string.
    let declaration = 'class ' . class_name . '(object):'
    call add(lines, declaration)
    call add(lines, '')
    let docstring = indentation . '"""Class docstring"""'
    call add(lines, docstring)
    call add(lines, '')

    " gen initialize method.
    let init_func = indentation . 'def __init__(self, '
    for arg in args
        let init_func .= arg . ', '
    endfor

    let init_func = init_func[:-3]
    let init_func .= '):'
    call add(lines, init_func)
    call PutByLines(lines)

    call GenDocString(args, 8)

    " gen attribute assignment.
    let lines = []
    let indentation .= indentation
    if len(args) > 0
        for arg in args
            call add(lines, indentation . 'self.' . arg . ' = ' . arg)
        endfor
    else
        call add(lines, indentation . 'pass')
    endif
    call PutByLines(lines)
endfunction

noremap <leader>cc :call CreatePythonClass()<cr>

"""""""""""""""""""
" CreateClassMethod
"""""""""""""""""""
function! CreateClassMethod()
    let method_name = input('Method name:')
    let args = split(input('Arguments: '), ',')
    let lines = []
    let indentation = '    '

    " gen method signature.
    let declaration = indentation . 'def ' . method_name . '(self, '
    for arg in args
        let declaration .= arg . ', '
    endfor

    let declaration = declaration[:-3] . '):'
    call add(lines, declaration)
    call PutByLines(lines)

    call GenDocString(args, 8)
    let lines = [indentation . indentation . 'return']
    call PutByLines(lines)
endfunction

noremap <leader>cm :call CreateClassMethod()<cr>

""""""""""""""""""""
" CreateMainEntrance
""""""""""""""""""""
function! CreateMainEntrance()
    let lines = []
    let indentation = '    '
    call add(lines, 'def main():')
    call add(lines, indentation . 'pass')
    call add(lines, '')
    call add(lines, 'if __name__ == "__main__":')
    call add(lines, indentation . 'main()')
    call PutByLines(lines)
endfunction

noremap <leader>cv :call CreateMainEntrance()<cr>
