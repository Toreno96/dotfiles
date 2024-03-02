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

" Customizes all colorschemes
function! s:tweak_colors()
  hi DiffAdd ctermfg=black ctermbg=green
  hi diffAdded ctermfg=green ctermbg=black
  hi DiffChange ctermfg=black ctermbg=yellow
  hi DiffDelete ctermfg=black ctermbg=red
  hi diffRemoved ctermfg=red ctermbg=black

  hi SpellBad ctermfg=red
  hi SpellCap ctermfg=blue

  " Highlight the search pattern _while typing_ (e.g. `/IncSearch`).
  " This is separate from the `hi Search`, which highlights the last search
  " pattern (e.g. `/IncSearch<CR>`)
  hi IncSearch ctermfg=red cterm=bold
endfunction

" Customizes `codedark` scheme
" TODO consider moving it to the `codedark`'s file?
" that would remove the need for this autocmd function and I could define colors
" for 256colorless terminal easily
function! s:tweak_codedark_colors()
  hi SpecialKey ctermfg=240
  " From 'octol/vim-cpp-enhanced-highlight'
  hi cCustomClassName ctermfg=43

  " Make H1 distinguishable from H2-6 to make it easier to catch if it's
  " incorrectly in the middle of higher-level headings;
  " also, wanted the opportunity to use the beautiful `ctermfg=43` for something
  hi markdownH1 ctermfg=43 cterm=bold
  " hi markdownH1 ctermfg=75 cterm=bold,reverse
  " Headings and code colorization inspired by:
  " https://github.com/charmbracelet/glow
  hi markdownH2 ctermfg=75 cterm=bold
  hi markdownH3 ctermfg=75 cterm=bold
  hi markdownH4 ctermfg=75 cterm=bold
  hi markdownH5 ctermfg=75 cterm=bold
  hi markdownH6 ctermfg=75 cterm=bold
  hi markdownHeadingDelimiter ctermfg=75 cterm=bold
  hi markdownCode ctermfg=203
  hi markdownCodeDelimiter ctermfg=203

  " Highlight the current match for the last search pattern to distinguish it
  " from other matches
  hi CurSearch ctermbg=239 cterm=underline
endfunction

" To avoid losing my customization after changing colorscheme and changing it back
" Source: https://github.com/junegunn/goyo.vim/blob/7f5d35a65510083ea5c2d0941797244b9963d4a9/README.md#faq
autocmd! ColorScheme * call s:tweak_colors()
autocmd! ColorScheme codedark call s:tweak_codedark_colors()

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
else
  " TODO test how `codedark` would work on the terminal without 256 color support;
  " that would simplify syntax highlighting configuration significantly
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
function! s:goyo_enter()
    set scrolloff=999
endfunction

function! s:goyo_leave()
    let &scrolloff=s:scrolloff
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

Plugin 'tpope/vim-fugitive'
" Support for GitHub in `:GBrowse`
Plugin 'tpope/vim-rhubarb'

Plugin 'whiteinge/diffconflicts'

" For instructions how to install the latest supported version of LanguageTool
" (5.9), see:
" https://github.com/dpelle/vim-LanguageTool/issues/33#issuecomment-1873818550
" https://stackoverflow.com/a/46306176/5875021
Plugin 'dpelle/vim-LanguageTool'
let g:languagetool_cmd='languagetool'
hi link LanguageToolGrammarError SpellCap
hi link LanguageToolSpellingError SpellBad

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
  " `nbsp` is using a common Unicode representation
  " Source: https://en.wikipedia.org/w/index.php?title=Whitespace_character&oldid=1122350113#Substitute_images
  " `tab` was using it too (the '⪫' character), but while my macOS machine
  " renders it correctly, my Linux machine does not
  set listchars=tab:▸\ ,trail:█,extends:›,precedes:‹,nbsp:⍽
else
  set listchars=tab:\|\ ,trail:#,extends:>,precedes:<,nbsp:!
endif
set number relativenumber
set previewheight=5
set ruler
let s:scrolloff=3
let &scrolloff=s:scrolloff
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

" EXPERIMENT: see if it causes lines to be auto-formatted on the 80 column (if
" yes and I don't like it, rollback this setting or customize `formatoptions`
" setting)
set textwidth=80
" If `formatoptions` is updated via the plain:
" ```
" set formatoptions-=…
" ```
" it is overidden by `/usr/share/vim/…/ftplugin/*.vim` files.
" One way to address that is to use `autocmd` as below
" Source: https://vi.stackexchange.com/a/26130
augroup FormatOptions
  autocmd!
  autocmd FileType * setlocal formatoptions-=c
  autocmd FileType * setlocal formatoptions-=t
augroup end
" 80 and 120 are the most common line lengths I've encountered in my daily work,
" while 88 is the Black's default[^1].
" This is set to +1 value (instead of 80,88,120), to show the color column right
" _after_ each length (similar to how visual guides in PyCharm are displayed).
"
" [^1]: https://black.readthedocs.io/en/stable/the_black_code_style/current_style.html#line-length
set colorcolumn=81,89,121

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

" If available, use `ripgrep` as vim's external grep
if executable('rg')
    set grepprg=rg\ --vimgrep
endif
