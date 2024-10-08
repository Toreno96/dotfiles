" Custom tag
syn match markdownMust '+must'
syn match markdownShould '+should'
syn match markdownCould '+could'

" Support for GFM's task list items:
" https://github.github.com/gfm/#task-list-items-extension-
syn match markdownTodoDoneMarker '\s\+\[x\]\s\+' contained
syn region markdownTodoDone start='\%(\t\| \{0,4\}\)[-*+]\s\+\[x\]\s\+' end='$' contains=markdownListMarker,markdownTodoDoneMarker

" Support for GFM's strikethrough:
" https://github.github.com/gfm/#strikethrough-extension-
" Copied from:
" https://github.com/gabrielelana/vim-markdown/blob/dd0a7d5d05c0d136b9644f591b222176f3c51996/syntax/markdown.vim
syn match markdownStrike /\%(\\\)\@<!\~\~\%(\S\)\@=\_.\{-}\%(\S\)\@<=\~\~/ contains=markdownStrikeDelimiter,@markdownInline
syn match markdownStrikeDelimiter /\~\~/ contained conceal

hi def link markdownStrike htmlStrike

hi markdownMust ctermfg=203 cterm=bold
hi markdownShould ctermfg=173 cterm=bold
hi markdownCould ctermfg=green cterm=bold
hi markdownTodoDone ctermfg=grey cterm=strikethrough
hi markdownTodoDoneMarker ctermfg=grey

" EXPERIMENT: see if I like it;
" Change bold to underline, just for fun;
" Inspired by: Tony's letter in The Ultimates (2024) #1
hi markdownBold cterm=underline
hi markdownBoldItalic cterm=underline,italic
