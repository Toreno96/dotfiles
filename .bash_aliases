# An "alert" alias for long running commands.  Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias ls='ls -F --group-directories-first --color=auto'
alias ll="ls -hl --time-style='+%F %T'"
alias lo="ls -ho --time-style='+%F %T'"
alias lgo='lo -g'
alias lhat='ll -hat'

alias grep='grep --color=auto'
alias grepc='grep --color=always'
alias grepn='grep --color=never'

alias cd='cd -L'

alias treec='tree -C'
alias treen='tree -n'

which git &>/dev/null && alias chardiff='git --no-pager diff --no-index --word-diff=color --word-diff-regex=.'
