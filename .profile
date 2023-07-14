# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# Set PATH so it includes user's private bin directories
PATH="${PATH}:${HOME}/bin"

# Load customized locale
if [ -f "${HOME}/.config/locale.conf" ]; then
    if [ "$(uname)" == 'Darwin' ]; then
        source <(sed 's/^/export /' "${HOME}/.config/locale.conf")
    else
        source "${HOME}/.config/locale.conf"
    fi
fi
