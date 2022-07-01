syn match markdownPriority '+priority' contained
syn match markdownTodoUndoneMarker '\s\+\[ \]\s\+' contained
syn match markdownTodoDoneMarker '\s\+\[x\]\s\+' contained
syn region markdownTodoUndone start='\%(\t\| \{0,4\}\)[-*+]\s\+\[ \]\s\+' end='$' contains=markdownListMarker,markdownTodoUndoneMarker,markdownPriority
syn region markdownTodoDone start='\%(\t\| \{0,4\}\)[-*+]\s\+\[x\]\s\+' end='$' contains=markdownListMarker,markdownTodoDoneMarker

hi markdownTodoDone ctermfg=grey cterm=strikethrough
hi markdownPriority ctermfg=203 cterm=bold
hi markdownTodoDoneMarker ctermfg=grey
