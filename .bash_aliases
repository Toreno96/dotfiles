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

# Handle `diff` not supporting color (e.g. macOS without `diffutils` installed)
if diff --help | grep -Fq -- '--color'; then
    alias diff='diff --color=auto'
    alias diffc='diff --color=always'
    alias diffn='diff --color=never'
fi

alias cd='cd -L'

if command -v tree &>/dev/null; then
    alias treec='tree -C'
    alias treen='tree -n'
fi

alias cal='LC_TIME=C cal -m'
