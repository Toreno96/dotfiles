if !has('nvim')
  set nocompatible
endif

let g:netrw_bufsettings='noma nomod nu rnu nobl nowrap ro'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" Makes '.' command of tpope/vim-vinegar not working
" let g:netrw_liststyle=3
let g:python_host_prog='/usr/bin/python3'
let g:markdown_fenced_languages = ['sh', 'bash=sh', 'shell=sh', 'python', 'json', 'vim', 'diff']
" Support strikethrough
let &t_Ts = "\e[9m"
let &t_Te = "\e[29m"
" Support undercurl
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" set termguicolors
" set background=light
set background=dark
syntax enable
if $TERM=~'256color'
  " let g:gruvbox_bold=0
  " let g:gruvbox_underline=0
  " let g:gruvbox_undercurl=0
  " let g:gruvbox_sign_column='bg0'
  " let g:gruvbox_vert_split='bg0'
  " let g:gruvbox_contrast_dark='hard'
  " let g:gruvbox_contrast_light='hard'
  " colorscheme gruvbox
  colorscheme codedark
  hi SpecialKey ctermfg=240
  hi cCustomClassName ctermfg=43

  hi DiffAdd ctermfg=black ctermbg=green
  hi diffAdded ctermfg=green ctermbg=black
  hi DiffChange ctermfg=black ctermbg=yellow
  hi DiffDelete ctermfg=black ctermbg=red
  hi diffRemoved ctermfg=red ctermbg=black

  hi SpellBad ctermfg=red
  hi SpellCap ctermfg=blue

  hi markdownH1 ctermfg=75 cterm=bold
  hi markdownH2 ctermfg=75 cterm=bold
  hi markdownH3 ctermfg=75 cterm=bold
  hi markdownH4 ctermfg=75 cterm=bold
  hi markdownH5 ctermfg=75 cterm=bold
  hi markdownH6 ctermfg=75 cterm=bold
  hi markdownHeadingDelimiter ctermfg=75 cterm=bold
  hi markdownCode ctermfg=203
  hi markdownCodeDelimiter ctermfg=203

  " Highlight the search pattern _while typing_ (e.g. `/IncSearch`).
  " This is separate from the `hi Search`, which highlights the last search
  " pattern (e.g. `/IncSearch<CR>`)
  hi IncSearch ctermfg=red cterm=bold
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
if has('nvim') || v:version > 800
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always=1
endif
if $TERM=~'xterm' || $PRESERVED_TERM=~'xterm'
  let g:gitgutter_sign_added='▌'
  let g:gitgutter_sign_modified='▌'
  let g:gitgutter_sign_removed='▂'
  let g:gitgutter_sign_removed_first_line='▔'
  let g:gitgutter_sign_removed_above_and_below='▞'
  let g:gitgutter_sign_modified_removed='▛'
endif
hi GitGutterAdd ctermfg=darkgreen
hi GitGutterChange ctermfg=darkblue
hi GitGutterDelete ctermfg=darkred
hi GitGutterChangeDelete ctermfg=darkmagenta

Plugin 'hdima/python-syntax'
let python_highlight_all=1
let python_highlight_file_headers_as_comments=1

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

Plugin 'tpope/vim-commentary'
autocmd FileType vim setlocal commentstring=\"\ %s"
autocmd FileType sh setlocal commentstring=#\ %s"
autocmd FileType cpp setlocal commentstring=//\ %s
autocmd FileType cmake setlocal commentstring=#\ %s

Plugin 'tpope/vim-repeat'

Plugin 'tpope/vim-vinegar'
" By default, the plugin overrides `-` which (in normal mode outside the
" Netrw) allows to go [count] lines upward, on the first non-blank character
" (complementary to `+`).
" As opposed to the `+`, however, the `-` does _not_ have the alternative
" keybindings, so the plugin removes possibility to use it altogether.
" Therefore, we bring back the original behavior of `-` by remapping the
" plugin's behavior to another keybinding.
noremap <leader>- <Plug>VinegarUp

Plugin 'raimon49/requirements.txt.vim'

Plugin 'junegunn/goyo.vim'

Plugin 'tpope/vim-fugitive'

call vundle#end()

filetype plugin indent on
if !has('nvim')
  set autoindent
  set autoread
  set backspace=indent,eol,start
  set backupdir=~/.vim/backup
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
  " `tab` and `nbsp` are using a common Unicode representation
  " Source: https://en.wikipedia.org/w/index.php?title=Whitespace_character&oldid=1122350113#Substitute_images
  set listchars=tab:⪫\ ,trail:█,extends:›,precedes:‹,nbsp:⍽
else
  set listchars=tab:\|\ ,trail:-,extends:>,precedes:<,nbsp:!
endif
set number relativenumber
set previewheight=5
set ruler
set scrolloff=3
set shiftwidth=4
if $TERM=~'xterm' || $PRESERVED_TERM=~'xterm'
  set showbreak=↪\ "
else
  set showbreak=\\\ "
endif
set showcmd
set splitbelow
set splitright
set statusline=[%n]\ %f\ %<%y[%{&ff}]%m%r%w%=%l/%L:%c%V\ \|\ %{strftime(\"%F\ %T\",getftime(expand(\"%:p\")))}
set tabstop=4
set undofile
set nrformats=alpha,bin,hex
set updatetime=250

set ignorecase
set tagcase=followscs
set smartcase

" Delete trailing whitespaces
nnoremap <leader>d<space> :%s/\s\+$//g<enter>
" Remap to remove collision with the above
nnoremap <leader>D :YcmShowDetailedDiagnostic<enter>
" Run pylint on the current file
nnoremap <leader>pyl :silent !pylint -f colorized % \| less -R<enter>:redraw!<enter>
" Run pylint-django on the current file
nnoremap <leader>pydl :silent !pylint -f colorized --load-plugins pylint_django % \| less -R<enter>:redraw!<enter>
" Run autopep8 on the current file (print the diff)
nnoremap <leader>pyad :!autopep8 --diff % \| colordiff \| less -R<enter>:redraw!<enter>
" Run autopep8 on the current file (in-place changes)
nnoremap <leader>pyai :!autopep8 -i %<enter>:redraw!<enter>
" Run shellcheck on the current file
nnoremap <leader>shl :!shellcheck -Calways % \| less -R<enter>:redraw!<enter>
" Swap paragraphs marked by 'n' and 'm'
nnoremap <leader>sp 'nvipy'mvipp'nvipp
" Yank current filepath and line number to the + register
nnoremap <leader>yf :let @+ = expand("%:p") . ":" . line(".")<enter>
" Expanded version of `gf`:
" Edit existing _or new file_ whose name is under or after the cursor
nnoremap <leader>gf :e <cfile><CR>
" Enable spellchecking
nnoremap <leader>esp :setlocal spell spelllang=pl,en<CR>
" Disable spellchecking
nnoremap <leader>dsp :setlocal nospell<CR>
" Clear search highlighting
nnoremap <leader>n :noh<CR>
" Insert to do item
nnoremap <leader>iti o<C-D>- [ ]<Space>
" Insert current date
nnoremap <leader>idd :r !date +'\%F'<CR>kJ
" Insert current datetime
nnoremap <leader>idt :r !date +'\%F \%H:\%M'<CR>kJ
" Insert line numbering
xnoremap <leader>iln :!nl -s'. '<CR>gv=
" Convert the current file from `dos` to `unix` fileformat
nnoremap <leader>unix :set fileformat=unix<CR>
" Insert a line below cursor
nnoremap <leader>o o<esc>
" Insert a line above cursor
nnoremap <leader>O O<esc>
" Use arrow keys to jump between buffers
" Source: https://github.com/jdavis/dotfiles/blob/62435dc83dd444be605e9ba204a3033e7192f3e4/.vimrc#L278..L280
map <right> :bn<CR>
map <left> :bp<CR>
" Change `'` to `"` globally in the line
nnoremap <leader>c'" :s/'/"/g<CR>
" Remove parentheses `()`, (square) brackets `[]`
" or braces (curly brackets) `{}` around an entity, e.g.
" `(foo bar baz)` -> `foo bar baz`
" `[foo bar baz]` -> `foo bar baz`
" `{foo bar baz}` -> `foo bar baz`
nnoremap <leader>d) di("_d%P
nnoremap <leader>d] di["_d%P
nnoremap <leader>d} di{"_d%P

" Digraph 'ː', IPA phonetic symbol that indicates a long vowel or consonant
digr p: 720

if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif

if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
    " Better mouse support, see  :help 'ttymouse'
    set ttymouse=sgr

    " Enable bracketed paste mode, see  :help xterm-bracketed-paste
    let &t_BE = "\<Esc>[?2004h"
    let &t_BD = "\<Esc>[?2004l"
    let &t_PS = "\<Esc>[200~"
    let &t_PE = "\<Esc>[201~"

    " Enable focus event tracking, see  :help xterm-focus-event
    let &t_fe = "\<Esc>[?1004h"
    let &t_fd = "\<Esc>[?1004l"
    execute "set <FocusGained>=\<Esc>[I"
    execute "set <FocusLost>=\<Esc>[O"

    " Enable modified arrow keys, see  :help arrow_modifiers
    execute "silent! set <xUp>=\<Esc>[@;*A"
    execute "silent! set <xDown>=\<Esc>[@;*B"
    execute "silent! set <xRight>=\<Esc>[@;*C"
    execute "silent! set <xLeft>=\<Esc>[@;*D"
endif
