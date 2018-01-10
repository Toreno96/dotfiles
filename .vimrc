if !has('nvim')
  set nocompatible
endif

let g:netrw_bufsettings='noma nomod nu rnu nobl nowrap ro'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" Makes '.' command of tpope/vim-vinegar not working
" let g:netrw_liststyle=3
let g:python_host_prog='/usr/bin/python3'

" set termguicolors
set background=dark
syntax enable
if $TERM=~'256color' || $PRESERVED_TERM=~'256color'
  " let g:gruvbox_bold=0
  " let g:gruvbox_underline=0
  " let g:gruvbox_undercurl=0
  " let g:gruvbox_sign_column='bg0'
  " let g:gruvbox_vert_split='bg0'
  " let g:gruvbox_contrast_dark='hard'
  " " let g:gruvbox_contrast_dark='medium'
  " let g:gruvbox_contrast_light='soft'
  " colorscheme gruvbox
  colorscheme codedark
  hi SpecialKey ctermfg=240
  hi cCustomClassName ctermfg=43
else
  colorscheme default
endif

" Required by Vundle
filetype off
" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'airblade/vim-gitgutter'
if has('nvim')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always=1
endif
if $TERM=~'xterm' || $PRESERVED_TERM=~'xterm'
  let g:gitgutter_sign_added='▌'
  let g:gitgutter_sign_modified='▌'
  let g:gitgutter_sign_removed='▄'
  let g:gitgutter_sign_modified_removed='▛'
endif
hi GitGutterAdd ctermfg=darkgreen
hi GitGutterChange ctermfg=darkblue
hi GitGutterDelete ctermfg=darkred
hi GitGutterChangeDelete ctermfg=darkmagenta
set updatetime=250
Plugin 'hdima/python-syntax'
let python_highlight_all=1
let python_highlight_file_headers_as_comments=1
Plugin 'itchyny/vim-cursorword'
Plugin 'junegunn/fzf'
let g:fzf_layout={ 'down': '~15%' }
Plugin 'octol/vim-cpp-enhanced-highlight'
" Works only with classes, not structures, which introduce inconsistency
let g:cpp_class_decl_highlight=0
let g:cpp_class_scope_highlight=1
let g:cpp_member_variable_highlight=1
" Choose either of the following two:
" " 1. Lag issues
" let g:cpp_experimental_simple_template_highlight=1
" " 2. Highlighting issues with std::cout << '> '
" let g:cpp_experimental_template_highlight=1
Plugin 'Valloric/YouCompleteMe'
let g:ycm_show_diagnostics_ui=1
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_python_binary_path='python3'
let g:ycm_autoclose_preview_window_after_insertion=0
if $TERM=~'xterm' || $PRESERVED_TERM=~'xterm'
  let g:ycm_error_symbol='██'
  let g:ycm_warning_symbol='██'
endif
hi YcmErrorSection ctermfg=red cterm=bold
hi YcmErrorSign ctermfg=red
hi YcmWarningSection ctermfg=green cterm=italic
hi YcmWarningSign ctermfg=green
if has('nvim')
  Plugin 'w0rp/ale'
endif
Plugin 'Yggdroot/indentLine'
let g:indentLine_enabled=0
let g:indentLine_char='│'
let g:indentLine_color_term=239
let g:indentLine_color_dark=2
Plugin 'tpope/vim-commentary'
autocmd FileType vim setlocal commentstring=\"\ %s"
autocmd FileType sh setlocal commentstring=#\ %s"
autocmd FileType cpp setlocal commentstring=//\ %s
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'

call vundle#end()

filetype plugin indent on
if !has('nvim')
  set autoindent
  set autoread
  set backspace=indent,eol,start
  set backupdir=.,~/.vim/backup
  set directory=~/.vim/swap//
  set encoding=utf-8
  set formatoptions=jcroql
  set history=10000
  set hlsearch
  set incsearch
  set langnoremap
  set laststatus=2
  set mouse=a
  set nrformats=bin,hex
  set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize
  set smarttab
  set tabpagemax=50
  set ttyfast
  set undodir=~/.vim/undo
  set viminfo=!,'100,<50,s10,h
  set wildmenu
endif
set breakindent
set cinoptions=j1
set expandtab
set linebreak
set list
if $TERM=~'xterm' || $PRESERVED_TERM=~'xterm'
  set listchars=tab:│\ ,trail:█,extends:›,precedes:‹,nbsp:␣
else
  set listchars=tab:\|\ ,trail:-,extends:>,precedes:<,nbsp:_
endif
set number relativenumber
set previewheight=5
set ruler
set scrolloff=3
set shiftwidth=2
if $TERM=~'xterm' || $PRESERVED_TERM=~'xterm'
  set showbreak=↪\ "
else
  set showbreak=\\\ "
endif
set showcmd
set splitbelow
set splitright
set statusline=%<%f\ %h%m%r%=%-14.(%l/%L:%c%)
set tabstop=2
set undofile
set nrformats=alpha,bin,hex
