# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Homebrew-specific logic
if [ "$(uname)" == 'Darwin' ]; then
    # Something similar is added to `~/.bash_profile` when installing Homebrew:
    # https://github.com/Homebrew/install/blob/96362c02f64bc1270645f6cd1698dda5a4790619/install.sh#L1010
    # via `brew shellenv bash` command, however, the output of that hardcodes
    # all values, e.g.:
    # ```
    # export HOMEBREW_PREFIX='/opt/homebrew'
    # export HOMEBREW_CELLAR='/opt/homebrew/Cellar'
    # …
    # ```
    # I've modified it to check if the prefix directory exists, used
    # `HOMEBREW_PREFIX` to evaluate further variables and moved it here to the
    # `~/.bashrc`
    export HOMEBREW_PREFIX='/opt/homebrew'
    if [ -d "${HOMEBREW_PREFIX}" ]; then
        export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
        export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}";
        export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}";
        export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:";
        export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}";

        # It seems to be safe to load completion, `autojump`, `nvm`, etc as
        # early in the `~/.bashrc` because none of those relies on environment
        # variables like `EDITOR`, `PAGER`, `BROWSER`, etc (checked with
        # recursive `grep` in those directories and by analyzing full output of
        # `bash -x`)

        # Based on:
        # https://docs.brew.sh/Shell-Completion#configuring-completions-in-bash
        if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
            # Won't run if `bash-completion` is not installed
            source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
        else
            for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
                # Enable only selected completions to not delay creating a new
                # instance of bash with things I'm not using or need a
                # completion for, or I do but they have a significant impact on
                # performance (e.g. completion for Docker)
                if \
                    # [ "$(basename "${COMPLETION}")" = "aws-vault.bash" ] || \
                    # [ "$(basename "${COMPLETION}")" = "aws_bash_completer" ] || \
                    [ "$(basename "${COMPLETION}")" = "git-completion.bash" ] || \
                    [ "$(basename "${COMPLETION}")" = "tmux" ] || \
                    [ "$(basename "${COMPLETION}")" = "yadm" ]; then
                        [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
                fi
            done
        fi

        [ -f "${HOMEBREW_PREFIX}/etc/profile.d/autojump.sh" ] && source "${HOMEBREW_PREFIX}/etc/profile.d/autojump.sh"
    else
        echo "${HOMEBREW_PREFIX}: No such file or directory; check if and where Homebrew is installed" >&2
    fi
fi

# Prompt
ANSI_BOLD='\[\e[01m\]'
ANSI_RED='\[\e[31m\]'
ANSI_GREEN='\[\e[32m\]'
ANSI_YELLOW='\[\e[33m\]'
ANSI_BLUE='\[\e[34m\]'
ANSI_MAGENTA='\[\e[35m\]'
ANSI_CYAN='\[\e[36m\]'
ANSI_RESET='\[\e[0m\]'
_exit_status() {
    STATUS="${?}"
    if [ ${STATUS} -ne 0 ]; then
        echo "${STATUS} "
    fi
}
_current_git_branch() {
    if command -v git &>/dev/null && git status &>/dev/null; then
        BRANCH=$(git branch | grep -F '*' | cut -d' ' -f2-)
        GIT_ROOT=$(git rev-parse --show-toplevel)
        # Indicate if a merge is in progress
        # https://stackoverflow.com/a/30783114/5875021
        if [ -e "$GIT_ROOT/.git/MERGE_HEAD" ]; then
            MERGE_FLAG="!"
        fi
        echo "${MERGE_FLAG}${BRANCH} "
    fi
}
_current_aws_vault() {
    if ! [ -z ${AWS_VAULT+x} ]; then
        echo "${AWS_VAULT} "
    fi
}
_ssh_enabled() {
    # On some systems (e.g. macOS), if ssh-agent is enabled in one instance of
    # a shell, it is not available in other instances, which sometimes results
    # in me trying to e.g. `git pull` new changes, just to get the `Permission
    # denied` because I forgot this is not the shell in which I've enabled the
    # ssh-agent and added a private key.
    #
    # This part of the prompt is supposed to inform me which of my currently
    # opened shells have the ssh-agent enabled/disabled.
    if ! [ -z ${SSH_AGENT_PID+x} ]; then
        echo 'ssh '
    fi
}
PS1=''
PS1+="${ANSI_BOLD}${ANSI_RED}\$(_exit_status)${ANSI_RESET}"
PS1+="${ANSI_BOLD}${ANSI_CYAN}\$(_ssh_enabled)${ANSI_RESET}"
PS1+="${ANSI_BOLD}${ANSI_MAGENTA}\$(_current_aws_vault)${ANSI_RESET}"
PS1+="${ANSI_BOLD}${ANSI_YELLOW}\$(_current_git_branch)${ANSI_RESET}"
# Redirect STDERR because `uname -o` is an illegal option on macOS
if [ "$(uname -o 2>/dev/null)" == 'Android' ]; then
    # In Termux on Android, neither username nor hostname can be customized.
    # As a workaround, I decided to hard-code it.
    #
    # > Android applications are sandboxed and have their own Linux user id and
    # > SELinux label. Termux is no exception and everything within Termux is
    # > executed with the same user id as the Termux application itself. The
    # > username may look like `u0_a231` and cannot be changed as it is derived
    # > from the user id by Bionic libc.
    # > —https://wiki.termux.com/wiki/Differences_from_Linux#Termux_is_single-user
    #
    # ```
    # $ hostname
    # localhost
    # $ hostname aeaea
    # Bad system call
    # $ echo $?
    # 159
    # ```
    PS1+="${ANSI_BOLD}${ANSI_GREEN}dstasczak@aeaea${ANSI_RESET}:"
else
    PS1+="${ANSI_BOLD}${ANSI_GREEN}\u@\h${ANSI_RESET}:"
fi
PS1+="${ANSI_BOLD}${ANSI_BLUE}\w${ANSI_RESET}\$ "

# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary, update the
# values of LINES and COLUMNS
shopt -s checkwinsize

# The pattern "**" used in a pathname expansion context will match all
# files and zero or more directories and subdirectories.
shopt -s globstar

# gpg: signing failed: Inappropriate ioctl for device
export GPG_TTY=$(tty)

# Use custom terminfo database entries compiled into the home directory
# (https://gpanders.com/blog/the-definitive-guide-to-using-tmux-256color-on-macos)
export TERMINFO_DIRS=$TERMINFO_DIRS:$HOME/.local/share/terminfo

# Etc
export PAGER='less -FR'
export MANPAGER='less -s'
command -v brave &>/dev/null && export BROWSER=brave
command -v vim &>/dev/null && export EDITOR=vim
export PYTHONSTARTUP=$HOME/.pythonrc.py
export PROMPT_DIRTRIM=3
# > Numeric values less than zero result in every command being saved on the
# > history list (there is no limit)
# > —https://man.archlinux.org/man/bash.1#HISTSIZE
export HISTSIZE=-1
# > If HISTFILESIZE is unset, or set to null, a non-numeric value, or a numeric
# > value less than zero, the history file is not truncated.
# > —https://man.archlinux.org/man/bash.1#HISTORY
export HISTFILESIZE=-1
export HISTTIMEFORMAT='%F %T '
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bash_functions ] && source ~/.bash_functions
if [ "$(uname)" == 'Darwin' ]; then
    # If this fails with
    # ```
    # -bash: gdircolors: command not found
    # ```
    # it means something went wrong while loading Homebrew
    [ -f ~/.dircolors ] && eval "$(gdircolors -b ~/.dircolors)"
else
    [ -f ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)"

    [ -f /usr/share/autojump/autojump.bash ] && source /usr/share/autojump/autojump.bash
fi

if command -v fzf &>/dev/null; then
    # Integrate fzf;
    # disable ALT-C binding (`cd` into the selected directory) because I
    # prefer `autojump`
    FZF_ALT_C_COMMAND= eval "$(fzf --bash)"
fi

export LS_COLORS="${LS_COLORS}ow=01;34:"
