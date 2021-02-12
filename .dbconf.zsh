# Key bindings
# ------------
if [[ $- == *i* ]]; then
# CTRL-X - Paste the selected db.conf spec into the commandline
fzf-dbconf-widget() {
  setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  selected="$(cat $SOLUTE_DEV_ROOT/infrastructure/puppetcfg/modules/packages/files/dbconf/{db.conf,parts/*} | grep '^\[' | tr -d '[]' |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --multi --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd))"
  local ret=$?
  LBUFFER=${LBUFFER}${selected}
  zle reset-prompt
  return $ret
}
zle     -N   fzf-dbconf-widget
bindkey '^X' fzf-dbconf-widget

fi
