# ~/.bashrc
# The individual per-interactive-shell startup file.


# Exit if not interactive
[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth
export IGNOREEOF=64


# Completion and prompt
[ -e /etc/bashrc.d/bash_completion.sh ] && source /etc/bashrc.d/bash_completion.sh
[ -e ~/.config/git-prompt.sh ] && source ~/.config/git-prompt.sh

if [ "$TERM" = "linux" ]; then
	export PS1='\[$(tput sgr0)\][\[$(tput setaf 2)\]\u@\h\[$(tput sgr0)\]]:\[$(tput setaf 1)\]\w\[$(tput setaf 3)\]\[$(__git_ps1 " (%s)")\]\[$(tput sgr0)\]\n\\$\[$(tput sgr0)\]'
else
	export PS1='\[$(tput sgr0)\]╭[\[$(tput setaf 2)\]\u@\h\[$(tput sgr0)\]]:\[$(tput setaf 1)\]\w\[$(tput setaf 3)\]\[$(__git_ps1 " (%s)")\]\[$(tput sgr0)\]\n╰\$\[$(tput sgr0)\]'
fi

# Aliases

# System
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
_xfunc git __git_complete dots git

alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias dmesg='dmesg --color=always'
alias ip='ip --color=auto'
alias ssh='TERM=xterm ssh'
alias snano='sudo nano'

alias pydoc='pydoc3'

if which exa &>/dev/null; then
	alias ls='exa -bhF --group-directories-first'
	alias lsa='exa -Fl -a -s name --group-directories-first -bhg --git'
	alias ll='exa -Fl -s name --group-directories-first -bhg --git'
	alias la='exa -Fl -a -s name --group-directories-first -bghHiS --git'
else
	alias ls='ls -hXF --color=auto --group-directories-first'
	alias ll='ls -l'
	alias lsa='ls -Al'
	alias la='lsa -i'
fi

alias cal='cal -m'

alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias rm='rm -I'


# Init ksi before zoxide
# BEGIN_KITTY_SHELL_INTEGRATION
#if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

alias icat='kitty +kitten icat'
alias s='kitty +kitten ssh'
. /usr/share/bash-completion/completions/ssh
complete -F _ssh s

# Use zoxide as cd
which zoxide &>/dev/null && eval "$(zoxide init bash --cmd cd)"

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias p='cd -'

alias du='du -h'
alias df='df -h'

# (-_-)
alias sl='ls'
alias dc='cd'
alias suod='sudo'
alias usdo='sudo'
alias usod='sudo'

alias hibernate="sudo systemctl hibernate"

# fzf
export FZF_DEFAULT_OPTS='--height 50% --reverse --border
						--bind=ctrl-k:kill-line
                        --bind=alt-n:preview-down
                        --bind=ctrl-alt-n:preview-half-page-down
                        --bind=alt-p:preview-up
                        --bind=ctrl-alt-p:preview-half-page-up
                        '

# Git
alias g='git'
alias gs='git status'
# enable comletion for g alias
_xfunc git __git_complete g git

# Emacs
if which devour >/dev/null 2>&1; then
    alias emacs='devour emacsclient -c -a "echo emacs daemon is not running"'
    alias dired='devour emacsclient -c -e "(dired \"$PWD\")"'
    alias magit="git rev-parse --git-dir >/dev/null 2>&1 && devour emacsclient -c -e '(progn (magit-status) (delete-other-windows))' || echo not a git repository"
fi

[ ${WITH_FUNCTIONS:-0} -ne 0 ] && source ~/.bash_functions
[ ${WITH_ALT:-0} -ne 0 ] && source ~/.bash_alt

#Keychain gpg agent setup
if [ ${WITH_GPG_AGENT:-0} -ne 0 ]; then
	unset SSH_AGENT_PID
	if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
		export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
	fi

	eval $(keychain --agents gpg --eval --noask --quiet --nogui basealt 2> /dev/null)

	export GPG_TTY=$(tty)
	gpg-connect-agent updatestartuptty /bye >/dev/null
fi
