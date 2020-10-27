#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.config/git-prompt.sh

# Aliases
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

alias diff='diff --color=auto'
alias grep='grep --color=auto'

alias ls='exa -bhF --group-directories-first'
alias lsa='exa -Fl -a -s name --group-directories-first -bhg --git'
alias ll='exa -Fl -s name --group-directories-first -bhg --git'
alias la='exa -Fl -a -s name --group-directories-first -bghHiS --git'

alias mkdir='mkdir -pv'

alias sl='ls'
alias dc='cd'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'

alias em='/usr/local/bin/emacs'
alias emacs="emacsclient -c --alternate-editor=''"

alias snano='sudo nano'

alias g='git'
alias gs='git status'

if [ "$TERM" = "linux" ]; then
	export PS1='\[$(tput sgr0)\][\[$(tput setaf 2)\]\u@\h\[$(tput sgr0)\]]:\[$(tput setaf 1)\]\w\[$(tput setaf 3)\]\[$(__git_ps1 " (%s)")\]\[$(tput sgr0)\]\n\\$\[$(tput sgr0)\]'
else
	export PS1='\[$(tput sgr0)\]╭[\[$(tput setaf 2)\]\u@\h\[$(tput sgr0)\]]:\[$(tput setaf 1)\]\w\[$(tput setaf 3)\]\[$(__git_ps1 " (%s)")\]\[$(tput sgr0)\]\n╰\\$\[$(tput sgr0)\]'
fi
