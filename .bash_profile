export PROFILE=0

export TERMINAL=alacritty
export ALTERNATE_EDITOR=""
export BROWSER="firefox"
export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode

export QSYS_ROOTDIR="/home/egor/.local/opt/intelFPGA_lite/20.1/quartus/sopc_builder/bin"

export PS1='\[$(tput sgr0)\]╭[\[$(tput setaf 2)\]\u@\h\[$(tput sgr0)\]]:\[$(tput setaf 1)\]\w\[$(tput setaf 3)\]\[$(__git_ps1 " (%s)")\]\[$(tput sgr0)\]\n╰\\$\[$(tput sgr0)\]'


[[ -f ~/.bashrc ]] && . ~/.bashrc
