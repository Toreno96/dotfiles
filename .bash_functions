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
