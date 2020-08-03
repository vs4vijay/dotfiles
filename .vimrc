set nocompatible


" Text Rendering Related Options
syntax enable
set encoding=utf-8
set linebreak
set wrap
set showmatch


" Search Related Options
set hlsearch
set incsearch
set ignorecase


" UI/UX Related Options
set mouse=a
set visualbell
set cursorline
set relativenumber
set clipboard=unnamed,unnamedplus
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set backspace=indent,eol,start
set autoindent
set wildmode=longest,list


" Performance Related Options
set lazyredraw


" Misc
set autoread
" set cc=80


filetype off


let mapleader = ','


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'junegunn/fzf'
Plugin 'preservim/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'vimwiki/vimwiki'

Plugin 'joshdick/onedark.vim' 
Plugin 'arcticicestudio/nord-vim'

" Plugin 'sheerun/vim-polyglot'
Plugin 'prettier/vim-prettier'
Plugin 'pangloss/vim-javascript'
Plugin 'fatih/vim-go'

call vundle#end()


filetype plugin indent on
syntax on


colorscheme nord

if has('nvim')
  colorscheme onedark
endif


let g:airline_theme='luna'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1


map <C-n> :NERDTreeToggle<CR>


" autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
