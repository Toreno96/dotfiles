syn match markdownPriority '+priority' contained
syn match markdownTodoUndoneMarker '\s\+\[ \]\s\+' contained
syn match markdownTodoDoneMarker '\s\+\[x\]\s\+' contained
syn region markdownTodoUndone start='\%(\t\| \{0,4\}\)[-*+]\s\+\[ \]\s\+' end='$' contains=markdownListMarker,markdownTodoUndoneMarker,markdownPriority
syn region markdownTodoDone start='\%(\t\| \{0,4\}\)[-*+]\s\+\[x\]\s\+' end='$' contains=markdownListMarker,markdownTodoDoneMarker

" Copied from
" https://github.com/gabrielelana/vim-markdown/blob/dd0a7d5d05c0d136b9644f591b222176f3c51996/syntax/markdown.vim
syn match markdownStrike /\%(\\\)\@<!\~\~\%(\S\)\@=\_.\{-}\%(\S\)\@<=\~\~/ contains=markdownStrikeDelimiter,@markdownInline
syn match markdownStrikeDelimiter /\~\~/ contained

hi markdownTodoDone ctermfg=grey cterm=strikethrough
hi markdownPriority ctermfg=203 cterm=bold
hi markdownTodoDoneMarker ctermfg=grey
hi def link markdownStrike htmlStrike
