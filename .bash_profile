export ALTERNATE_EDITOR=""
export BROWSER="firefox"
export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode

export HISTCONTROL=ignoredups
export HISTSIZE=-1 #Unlimited history size

export PATH="/home/egor/.local/bin:$PATH"

[[ -f ~/.bashrc ]] && . ~/.bashrc
