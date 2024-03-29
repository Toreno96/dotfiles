# Handle `diff` not supporting color (e.g. macOS without `diffutils` installed)
if diff --help | grep -Fq -- '--color'; then
    alias diff='diff --color=auto'
    alias diffc='diff --color=always'
    alias diffn='diff --color=never'
fi

if [ "$(uname)" == 'Linux' ]; then
    source ~/.bash_aliases_linux
elif [ "$(uname)" == 'Darwin' ]; then
    source ~/.bash_aliases_macos
fi

if command -v jq &>/dev/null; then
    alias jql='jq -C | less -R'
fi

if command -v docker &>/dev/null; then
    alias dockerstopa="docker ps | tail -n +2 | cut -d ' ' -f 1 | xargs -p docker stop"
fi

if command -v aws &>/dev/null; then
    alias awslocal='aws --endpoint-url=http://localhost:4566'
fi

if command -v delta &>/dev/null; then
    alias delta="delta --max-line-length=0 --syntax-theme 'Visual Studio Dark+'"
    alias diff-highlight='delta --diff-highlight --keep-plus-minus-markers --paging=never'
    alias ddiff='delta --line-numbers --navigate --paging=auto'
fi
