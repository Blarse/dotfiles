export PROFILE=0

export TERMINAL=alacritty
export ALTERNATE_EDITOR=""
export BROWSER="firefox"
export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode

export HISTCONTROL=ignoredups
export HISTSIZE=-1 #Unlimited history size

export QSYS_ROOTDIR="/home/egor/.local/opt/intelFPGA_lite/20.1/quartus/sopc_builder/bin"

export PATH="/home/egor/.local/bin:$PATH"

# Customizing tty mode
if [ "$TERM" = "linux" ]; then
	/bin/echo -e "\e]P0002b36 \e]P1dc322f \e]P2859900 \e]P3b58900 \e]P4268bd2 \e]P56c71c4 \e]P62aa198 \e]P793a1a1 \e]P8657b83 \e]P9dc322f \e]PA859900 \e]PBb58900 \e]PC268bd2 \e]PD6c71c4 \e]PE2aa198 \e]PFfdf6e3"
	clear
	fbset -a -g 1920 1080 1920 1080 32
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
