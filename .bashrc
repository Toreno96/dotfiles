# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt
ANSI_BOLD='\[\e[01m\]'
ANSI_GREEN='\[\e[32m\]'
ANSI_BLUE='\[\e[34m\]'
ANSI_RESET='\[\e[0m\]'
PS1="${ANSI_BOLD}${ANSI_GREEN}\u@\h${ANSI_RESET}:${ANSI_BOLD}${ANSI_BLUE}\w${ANSI_RESET}\$ "

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
command -v opera &>/dev/null && export BROWSER=opera
command -v vim &>/dev/null && export EDITOR=vim
export PYTHONSTARTUP=$HOME/.pythonrc.py
export PROMPT_DIRTRIM=3
export HISTSIZE=5000
export HISTFILESIZE=$((HISTSIZE * 2))
export HISTTIMEFORMAT='%F %T '
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bash_functions ] && source ~/.bash_functions
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.local/bin/tmuxinator.bash ] && source ~/.local/bin/tmuxinator.bash
[ -f ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)"
export LS_COLORS="${LS_COLORS}ow=01;34:"
