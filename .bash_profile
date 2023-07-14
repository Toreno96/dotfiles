# Normally, `~/.profile` is not read by bash if `~/.bash_profile` exists.
# I've changed that, so the `~/.profile` can keep the general POSIX-compliant
# configuration, without any bash-specific settings, while `~/.bash_profile`
# sources `~/.profile`, to not require duplicating a content of `~/.profile` in
# `~/.bash_profile`
[ -f "${HOME}/.profile" ] && source "${HOME}/.profile"

# Without this, `~/bashrc` would not be sourced in login shells (e.g. in
# terminal apps on macOS)
[ -f "${HOME}/.bashrc" ] && source "${HOME}/.bashrc"

