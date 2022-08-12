# ~/.bash_profile
# The personal initialization file, executed for login shells.

#bash features:
export WITH_ALT=1
export WITH_FUNCTIONS=1
export WITH_GPG_AGENT=1

export LANG=C
export TERMINAL=kitty
export EDITOR=nano
#export EDITOR='emacsclient -t -a emacs'
#export VISUAL='emacsclient -c -a emacs'
export PATH="/home/egori/.scripts:$PATH:$HOME/.local/bin:/opt/riscv/bin"

if which bat &>/dev/null; then
	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

[ -f ~/.bashrc ] && source ~/.bashrc

export QSYS_ROOTDIR="/home/egori/.local/share/quartus/quartus/sopc_builder/bin"
