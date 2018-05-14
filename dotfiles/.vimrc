" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible

" Editing behaviour
set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
"set gdefault                    " search/replace "globally" (on a line) by default
"set wrap                        " wrap lines

set nolist                      " don't show invisible characters by default
set fileformats="unix,dos,mac"

set termencoding=utf-8
set encoding=utf-8
set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell VIM to always put a status line in, even if there is only one window
set cmdheight=1                 " use a status bar that is 2 rows high

set hidden                      " hide buffers instead of closing them
set switchbuf=useopen           " reveal already opened files from the quickfix window instead of opening new buffers
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
if v:version >= 730
    set undofile                " keep a persistent backup file
    set undodir=~/.vim/.undo,~/tmp,/tmp
endif
set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete first full match
set title                       " change the terminal's title
set visualbell                  " don't beep
set noerrorbells                " don't beep
set showcmd                     " show (partial) command in the last line of the screen this also shows visual selection info
set nomodeline                  " disable mode lines (security measure)
set cursorline                  " underline the current line, for quick orientation
set autochdir                   " Set auto change directory
set mouse=n                     " Enable mouse for Normal mode only

" Turn off bell and visual flash when pressing Escape
autocmd GUIEnter * set vb t_vb=
autocmd VimEnter * set vb t_vb=

au BufRead,BufNewFile *.md set filetype=markdown " Recognise .md files as .markdown files for syntax highlighting
au BufRead,BufNewFile *.less set filetype=less " Recognise .less files as .less files for syntax highlighting

" Autoformat XML documents
" Be sure to set the environment variable $XMLLINT_INDENT="    "
" ... preferably in your .exports file
" au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" Set local tab spacing and sizes for particular filetypes
au FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType scss setlocal shiftwidth=2 tabstop=2 softtabstop=2

command! -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction

" Highlight character on 80th column only
" http://is.gd/IBV2013
highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%80v', 100)

" Highlight whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Spellcheck
" [s, ]s to jump to previous/next mis-spelling
" z= to display list of alternative spellings
nmap <F4> :setlocal spell! spelllang=en_gb<CR>

" JSHint2 plugin mappings
nnoremap <silent><F6> :JSHint<CR>
inoremap <silent><F6> <C-O>:JSHint<CR>
vnoremap <silent><F6> :JSHint<CR>

" NERDTree mappings
nmap <F8> :NERDTreeToggle<CR>

" Tagbar plugin mappings
nmap <F9> :TagbarToggle<CR>

" vim-flake8 -- autorun
autocmd BufWritePost *.py call Flake8()

" vim instant markdown
let g:instant_markdown_slow = 1

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
" let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Plugin stuff
call pathogen#infect()       " Enable pathogen
:command NE NERDTree         " Shortcut for NERDTree
filetype plugin indent on

syntax enable
set background=dark
colorscheme solarized
syntax on                    " switch syntax highlighting on, when the terminal has colors
