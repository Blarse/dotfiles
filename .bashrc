#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PS1='\[$(tput sgr0)\]╭[\[$(tput setaf 2)\]\u@\h\[$(tput sgr0)\]]:\[$(tput setaf 1)\]\w\[$(tput setaf 3)\]\[$(__git_ps1 " (%s)")\]\[$(tput sgr0)\]\n╰\\$\[$(tput sgr0)\]'

neofetch

. ~/.config/git-prompt.sh

alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'


alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ls='ls -hXF --color=auto --group-directories-first'

alias ll='ls -l'
alias lsa='ls -Al'

alias mkdir='mkdir -pv'


alias ccat='highlight -O ansi --force'

alias sl='ls'
alias dc='cd'
alias cd..='cd ..'

alias ec='emacsclient'
alias emm='emacs -q -l $HOME/work/config/.emacs.d/init.el'


alias snano='sudo nano'

alias g='git'
alias gs='git status'

export QSYS_ROOTDIR="/home/egor/.local/opt/intelFPGA_lite/20.1/quartus/sopc_builder/bin"
