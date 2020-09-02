#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

neofetch

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

alias ccat='highlight -O ansi --force'

alias sl='ls'
alias dc='cd'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'

alias ec='emacsclient'
alias emm='emacs -q -l $HOME/work/config/.emacs.d/init.el'
alias emacs="emacsclient -c --alternate-editor=''"

alias snano='sudo nano'

alias g='git'
alias gs='git status'

# Customizing tty mode
if [ "$TERM" = "linux" ]; then
	/bin/echo -e "\e]P0002b36 \e]P1dc322f \e]P2859900 \e]P3b58900 \e]P4268bd2 \e]P56c71c4 \e]P62aa198 \e]P793a1a1 \e]P8657b83 \e]P9dc322f \e]PA859900 \e]PBb58900 \e]PC268bd2 \e]PD6c71c4 \e]PE2aa198 \e]PFfdf6e3"
	clear
	fbset -a -g 1920 1080 1920 1080 32
fi

#Keychain setup
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
eval $(keychain --agents gpg,ssh --eval --quiet github)
