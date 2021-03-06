# Key bindings
# ------------
if [[ $- == *i* ]]; then
# CTRL-B - Paste the selected branch into the command line
fzf-branch-widget() {
  setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
  if [ -d .git ] || git rev-parse 2>/dev/null ; then
      selected="$(git branch -a | perl -pe 's;remotes/origin/;;' | tr -d '* ' |
        FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --multi --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd))"
      local ret=$?
      LBUFFER=${LBUFFER}${selected}
      zle reset-prompt
      return $ret
   fi
   return 0
}
zle     -N   fzf-branch-widget
bindkey '^B' fzf-branch-widget

fi
