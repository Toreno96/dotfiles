# Colored `man`
manc() {
    LESS_TERMCAP_md=$'\e[01;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[01;32m' \
        command man "${@}"
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

# Filters the result of Python unittest run into a concise summary.
# Requires redirecting stderr into stdout.
#
# Mnemonic: [f]ilter [u]nitest [r]esult
#
# Example usage:
# $ python manage.py test -v 0 2>&1 | fur
#
# Advanced flow:
# $ python manage.py test -v 0 2>&1 | tee /tmp/unittest | fur
# $ # See the full output if details are needed
# $ vim /tmp/unittest
# <CTRL-Z>
# $ # Another test run
# $ python manage.py test -v 0 2>&1 | tee /tmp/unittest | fur
# $ # Go back to refreshed full output
# $ fg
fur() {
    grep --color=always 'ERROR:\|FAIL:\|Ran \d\+ tests\|FAILED\|OK'
}
