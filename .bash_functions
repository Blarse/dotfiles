rpmprog () {
	rpm -qf $(which "$1")
}

calc () {
	echo "scale=5; $@" | bc
}

ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *.rpm)       rpm2cpio $1 | cpio -ivd ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


# 1. put killring top to X11 secondary sel
# 2. yank from X11 secondary sel
_xdiscard() {
    echo -n "${READLINE_LINE:0:$READLINE_POINT}" | xclip -i -sel secondary
    READLINE_LINE="${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=0
}
_xkill() {
    echo -n "${READLINE_LINE:$READLINE_POINT}" | xclip -i -sel secondary
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}"
}
_xyank() {
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$(xclip -o -sel secondary)${READLINE_LINE:$READLINE_POINT}"
}

#bind -m emacs -x '"\C-u": _xdiscard'
#bind -m emacs -x '"\C-k": _xkill'
#bind -m emacs -x '"\C-y": _xyank'
