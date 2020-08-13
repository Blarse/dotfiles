export PROFILE=0

export TERMINAL=alacritty
export ALTERNATE_EDITOR=""
export BROWSER="firefox"
export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode

(switch-to-buffer "*scratch*")
[[ -f ~/.bashrc ]] && . ~/.bashrc
#[[ -f ~/.scripts/wm_startup.sh ]] && . ~/.scripts/wm_startup.sh

#eval `ssh-agent -s`
#ssh-add ~/.ssh/github

#setxkbmap -model pc104 -layout us,ru -variant ,phonetic -option grp:win_space_toggle
#setxkbmap -model pc140 -layout us,ru -variant colemak, -option grp:win_space_toggle
#setxkbmap -model pc104 -layout us,ru -variant ,phonetic -option grp:win_space_toggle

export QSYS_ROOTDIR="/home/egor/.local/opt/intelFPGA_lite/20.1/quartus/sopc_builder/bin"
