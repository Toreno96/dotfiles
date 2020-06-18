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

if [ $(uname) == 'linux' ]; then
    source ~/.bash_aliases_linux
elif [ $(uname) == 'Darwin' ]; then
    source ~/.bash_aliases_macos
fi
