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
set mouse=n                     " Enable mouse for Normal mode only

" Turn off bell and visual flash when pressing Escape
autocmd GUIEnter * set vb t_vb=
autocmd VimEnter * set vb t_vb=

" Auto-reload buffers which have since changed on disk
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.less set filetype=less
au BufRead,BufNewFile *.ts  set filetype=typescript
au BufRead,BufNewFile *.tsx set filetype=typescript.tsx

" Set local tab spacing and sizes for particular filetypes
au FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType scss setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType typescript.tsx setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType yml setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType lua setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Highlight whitespace
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Spellcheck
" [s, ]s to jump to previous/next mis-spelling
" z= to display list of alternative spellings
nmap <F4> :setlocal spell! spelllang=en_gb<CR>

call plug#begin('~/.local/share/nvim/plugged')

Plug 'arcticicestudio/nord-vim'
Plug 'github/copilot.vim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-emoji'
Plug 'hrsh7th/nvim-cmp'
Plug 'iCyMind/NeoSolarized'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'L3MON4D3/LuaSnip'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'neovim/nvim-lspconfig'
Plug 'nvie/vim-flake8'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'ray-x/lsp_signature.nvim'
Plug 'roxma/nvim-yarp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'

call plug#end()

" Syntax highlighting
colorscheme nord

" NERDTree mappings
nmap <F8> :NERDTreeToggle<CR>

" FZF plugin mappings
nmap <c-p> :Files<CR>
nmap <c-b> :Buffers<CR>

" vim-flake8 -- autorun
autocmd BufWritePost *.py call Flake8()

set completeopt=noinsert,menuone,noselect

" Some servers have issues with backup files, see #649
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

lua <<EOF
require('config')
EOF
