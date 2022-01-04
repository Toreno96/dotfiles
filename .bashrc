# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
PS1=''
PS1+="${ANSI_BOLD}${ANSI_RED}\$(_exit_status)${ANSI_RESET}"
PS1+="${ANSI_BOLD}${ANSI_MAGENTA}\$(_current_aws_vault)${ANSI_RESET}"
PS1+="${ANSI_BOLD}${ANSI_YELLOW}\$(_current_git_branch)${ANSI_RESET}"
PS1+="${ANSI_BOLD}${ANSI_GREEN}\u@\h${ANSI_RESET}:"
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

# Etc
export PAGER=less
command -v brave &>/dev/null && export BROWSER=brave
command -v vim &>/dev/null && export EDITOR=vim
export PYTHONSTARTUP=$HOME/.pythonrc.py
export PROMPT_DIRTRIM=3
export HISTSIZE=5000
export HISTFILESIZE=$((HISTSIZE * 2))
export HISTTIMEFORMAT='%F %T '
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bash_functions ] && source ~/.bash_functions
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
[ -f ~/.local/bin/tmuxinator.bash ] && source ~/.local/bin/tmuxinator.bash
[ -f ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)"
[ -f /usr/share/autojump/autojump.bash ] && source /usr/share/autojump/autojump.bash
export LS_COLORS="${LS_COLORS}ow=01;34:"
