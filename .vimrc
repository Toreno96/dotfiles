" vim: set shiftwidth=2:

if !has('nvim')
  set nocompatible
endif

" Show (relative) line numbers
let g:netrw_bufsettings='noma nomod nu rnu nobl nowrap ro'
" Inspired by https://github.com/tpope/vim-vinegar:
" > All that annoying crap at the top is turned off, leaving you with nothing
" > but a list of files. This is surprisingly disorienting, but ultimately very
" > liberating. Press I to toggle until you adapt.
let g:netrw_banner=0
" Hide dotfiles by default
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" Display human-readable file sizes (in powers of 1024)
let g:netrw_sizestyle = 'H'
" Enable syntax highlighting for certain file types
let g:netrw_special_syntax=1
" e.g. Sat 1996-12-10 08:00:00 CEST
let g:netrw_timefmt = '%a %F %T %Z'


let g:python_host_prog='/usr/bin/python3'
let g:markdown_fenced_languages = ['sh', 'bash=sh', 'shell=sh', 'python', 'json', 'vim', 'diff', 'toml']
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
  hi DiffAdd      ctermfg=green ctermbg=black
  hi diffAdded    ctermfg=green ctermbg=black
  hi DiffChange   ctermfg=green ctermbg=black
  hi DiffText     ctermfg=black ctermbg=green
  hi DiffDelete   ctermfg=black ctermbg=red
  hi diffRemoved  ctermfg=red ctermbg=black

  " Experiment with undercurl instead of underline
  hi SpellBad ctermfg=red cterm=undercurl
  hi SpellCap ctermfg=blue cterm=undercurl
  hi SpellLocal ctermfg=green cterm=undercurl

  " Highlight the search pattern _while typing_ (e.g. `/IncSearch`).
  " This is separate from the `hi Search`, which highlights the last search
  " pattern (e.g. `/IncSearch<CR>`)
  hi IncSearch ctermfg=red cterm=bold

  hi netrwMarkFile cterm=reverse
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
  hi markdownH1 ctermfg=43 cterm=bold,reverse
  " Headings and code colorization inspired by:
  " https://github.com/charmbracelet/glow
  hi markdownH2 ctermfg=75 cterm=bold
  " Make odd headings a different color than even headings, to make them a bit
  " more distinguishable from each other
  hi markdownH3 ctermfg=43 cterm=bold
  hi markdownH4 ctermfg=75 cterm=bold
  hi markdownH5 ctermfg=43 cterm=bold
  hi markdownH6 ctermfg=75 cterm=bold
  hi markdownHeadingDelimiter ctermfg=75 cterm=bold
  hi markdownCode ctermfg=203
  hi markdownCodeDelimiter ctermfg=203

  " Highlight the current match for the last search pattern to distinguish it
  " from other matches
  hi CurSearch ctermbg=239 cterm=underline

  " Make it more readable than the default red on red
  hi Error cterm=none ctermfg=white ctermbg=red

  " Things like '\e' in '\e[9m', 'SID' in '<SID>goyo_enter()', etc;
  " experimentally borrowed from the more recent version of `codedark`
  hi Special ctermfg=179
endfunction

" To avoid losing my customization after changing colorscheme and changing it back
" Source: https://github.com/junegunn/goyo.vim/blob/7f5d35a65510083ea5c2d0941797244b9963d4a9/README.md#faq
"
" TODO fix "~/.vim/after/syntax/markdown.vim" not beign reloaded after changing
" colorscheme and changing it back
autocmd! ColorScheme * call s:tweak_colors()
autocmd! ColorScheme codedark call s:tweak_codedark_colors()

if $TERM=~'256color'
  colorscheme codedark
else
  " TODO test how `codedark` would work on the terminal without 256 color support;
  " that would simplify syntax highlighting configuration significantly
  colorscheme default
endif

" Check if Vundle plugin manager is installed by checking if the README file
" exists because `filereadable` doesn't handle directories
if filereadable(expand('~/.vim/bundle/Vundle.vim/README.md'))
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

  Plugin 'tpope/vim-repeat'

  Plugin 'junegunn/goyo.vim'
  function! s:goyo_enter()
    " set scrolloff=999
    set number relativenumber
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

  Plugin 'godlygeek/tabular'

  " EXPERIMENT: see if I like it on rare occassions when I need a light
  " background theme.
  Plugin 'NLKNguyen/papercolor-theme'

  call vundle#end()

  filetype plugin indent on
endif

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
let s:scrolloff=3
let &scrolloff=s:scrolloff
set shiftwidth=4
" Redirect STDERR because `uname -o` is an illegal option on macOS
let is_android=substitute(system('uname -o 2>/dev/null || uname -s'), '\n', '', '') == 'Android'
" Do not use `↪` on Android because it is ugly there (or at least on my Samsung
" Galaxy A50)
if !is_android && ($TERM=~'xterm' || $PRESERVED_TERM=~'xterm')
  set showbreak=↪\ "
else
  set showbreak=\\\ "
endif
set showcmd
set splitbelow
set splitright
set statusline=[%n]\ %t\ %<%y[%{&ff}]%m%r%w%=%l/%L:%c%V\ \|\ %{wordcount().words}
" The ruler is shown if laststatus is 0 or 1 (not 2)
set ruler
set rulerformat=%l/%L:%c%V
set tabstop=8
set undofile
" Added `blank` for better handling of ISO dates;
" without it, pressing CTRL-X on `2025-01-07` (with cursor on `7`) results in
" `2025-01-08,` while I want `2025-01-06`
set nrformats=alpha,bin,blank,hex
set updatetime=250

set ignorecase
set tagcase=followscs
set smartcase

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

" `noinsert` is crucial when using `fuzzy` to allow editing the initial string
" if the list of matches is unsatisfying
set completeopt=menu,menuone,preview,noinsert,fuzzy

" Display command-line completion as the popup menu instead of horizontally
set wildoptions=pum
" Complete to the longest common substring, then show wildmenu, then complete
" the next full match
set wildmode=longest:full,full

" Delete trailing whitespaces
nnoremap <leader>d<space> :s/\s\+$//g<enter>
vnoremap <leader>d<space> :s/\s\+$//g<enter>
" Yank current filepath and line number to the + register
nnoremap <leader>yf :let @+ = expand("%:p") . ":" . line(".")<enter>
" Expanded version of `gf`:
" Edit existing _or new file_ whose name is under or after the cursor
nnoremap <leader>gf :e <cfile><CR>
" Enable spellchecking
nnoremap <leader>esp :setlocal spell spelllang=en_us,pl<CR>
nnoremap <leader>ese :setlocal spell spelllang=en_us<CR>
" Disable spellchecking
nnoremap <leader>dsp :setlocal nospell<CR>
" Clear search highlighting
nnoremap <leader>n :noh<CR>
" Insert to do item
nnoremap <leader>iti o<C-D>- [ ]<Space>
" Insert current date
nnoremap <leader>idd "=strftime('%F')<CR>p
" Insert current datetime
nnoremap <leader>idt "=strftime('%F %R')<CR>p
" Insert current timezone-aware datetime
nnoremap <leader>idz "=strftime('%F %R %Z')<CR>p
" Insert line numbering
xnoremap <leader>iln :!nl -s'. '<CR>gv=
" Convert the current file from `dos` to `unix` fileformat
nnoremap <leader>unix :set fileformat=unix<CR>
" Use arrow keys to jump between buffers
" Source: https://github.com/jdavis/dotfiles/blob/62435dc83dd444be605e9ba204a3033e7192f3e4/.vimrc#L278..L280
map <right> :bn<CR>
map <left> :bp<CR>
" Change `'` to `"` globally in the line
nnoremap <leader>' :s/'/"/g<CR>
" Remove parentheses `()`, (square) brackets `[]`
" or braces (curly brackets) `{}` around an entity, e.g.
" `(foo bar baz)` -> `foo bar baz`
" `[foo bar baz]` -> `foo bar baz`
" `{foo bar baz}` -> `foo bar baz`
nnoremap <leader>d) di("_d%P
nnoremap <leader>d] di["_d%P
nnoremap <leader>d} di{"_d%P
" Source vimrc
nnoremap <leader>ss :source $MYVIMRC<CR>
" Search next/previous WORD, see :help WORD
nnoremap <leader>* yiW/\V<C-r>"<CR>
nnoremap <leader># yiW?\V<C-r>"<CR>
" Run inline `curl` command (HTTP request) and put the output (HTTP response)
" below the command, and reformat the output
" - Supports both single-line and multiline `curl` command
" - Assumes that the response is in JSON format
" - External dependencies: `bash` and `jq`
nnoremap <leader>! vipy}o<CR><CR><ESC>Pvip!bash<CR>]]!!jq<CR>
" Grep all markdown headers in the current file;
" Then, use `:cl`, `:copen`, and `:cc [nr]` to navigate through the headers in a
" quicklist
nnoremap <leader>mgh :grep '^\#+ ' %<CR>

" Write all markdown headers in the current file to a new scratch buffer
if !exists(":MarkdownListHeaders")
  command MarkdownListHeaders new
        \ | setlocal filetype=markdown
        \ | setlocal buftype=nofile
        \ | setlocal bufhidden=delete
        \ | setlocal noswapfile
        \ | %!grep '^\#\+ ' #
endif

" Utilize abbreviations for inserting emojis
abbreviate :warn: ⚠️
" Make it easier to remember which is which, because I always confuse the two.
"
" Unfortunately, the patterns `§1st` and `§2nd` that I have configured globally
" in the macOS' settings (which does not work in the terminal) and I'm used to,
" cannot be configured in Vim because it doesn't support such pattern (`§` is
" treated as a non-keyword character; see the explanation of `full-id`, `end-id`
" and `non-id` in `:help abbreviations`)
abbreviate the1st the former
abbreviate the2nd the latter

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

" Below code was copy-pasted from "$VIMRUNTIME/defaults.vim"

" Only do this part when Vim was compiled with the +eval feature.
if 1

  " Put these in an autocmd group, so that you can revert them with:
  " ":autocmd! vimStartup"
  augroup vimStartup
    autocmd!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim), for a commit or rebase message
    " (likely a different one than last time), and when using xxd(1) to filter
    " and edit binary files (it transforms input files back and forth, causing
    " them to have dual nature, so to speak) or when running the new tutor
    autocmd BufReadPost *
          \ let line = line("'\"")
          \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
          \      && index(['xxd', 'gitrebase', 'tutor'], &filetype) == -1
          \      && !&diff
          \ |   execute "normal! g`\""
          \ | endif

  augroup END

endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" I like highlighting strings inside C comments.
" Revert with ":unlet c_comment_strings".
let c_comment_strings=1
