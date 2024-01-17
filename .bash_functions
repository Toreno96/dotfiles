# Colored `man`
manc() {
    LESS_TERMCAP_md=$'\e[01;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[01;32m' \
        command man "${@}"
}

glowless() {
    PAGER='less -R' glow "${@}" -p
}

groot() {
    GIT_ROOT=$(git rev-parse --show-toplevel)
    cd "${GIT_ROOT}"
}

# Enable `nvm` on demand, to not delay creating a new instance of bash when
# I don't need `nvm` in the instance
activate_nvm() {
    export NVM_DIR="$HOME/.nvm"

    [ -s "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh" ] && source "${HOMEBREW_PREFIX}/opt/nvm/nvm.sh"

    PS1="(nvm) ${PS1:-}"
    export PS1
}
