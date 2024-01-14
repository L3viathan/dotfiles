autoload -Uz compinit
compinit
if [ ! -d "$HOME/.antidote" ]
then
    git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
fi
source ~/.antidote/antidote.zsh
antidote load

source dotfiles/l3vi2.zsh-theme
setopt promptsubst
setopt auto_cd

function take() {
    mkdir -p $@ && cd ${@:$#}
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
unset MAILCHECK

# Aliasses and custom functions
which exa >/dev/null && alias ls='exa' ll='ls -lh --git' l='ls -lah --git'
which exa >/dev/null || alias ll='ls -lh' l='ls -lah'
alias wow='git status'
alias v="vim" t="tig"
alias livestreamer='livestreamer --http-header Client-ID=jzkbprff40iqj646a697cyrvl0zt2m6 --player /usr/local/bin/mpv'
alias vi=vim

# custom functions
srsly(){
    until $*
    do
        sleep 0.1
    done}
compdef srsly='sudo' #autocompletion like sudo
export MOSH_TITLE_NOPREFIX=1
export MOSH_SERVER_NETWORK_TMOUT=604800
lookup() {dig -x `dig +short $*`}
export PYTHONPATH="./.pip:$PYTHONPATH:$HOME"

alias grc='git rebase --continue'
alias rgp='rg -t py'
alias tmux='tmux -2'

p() {
    if [ -z "$*" ]
    then
        ipython
    else
        python3 -q $*
    fi
}

export FZF_DEFAULT_COMMAND='fd --type f'

export hostname=$(hostname)
export uname=$(uname)
export HISTSIZE=1000000
export HISTFILESIZE=10000000

if [ -f ~/.zshrc.$uname ]; then
    source ~/.zshrc.$uname
fi
if [ -f ~/.zshrc.$hostname ]; then
    source ~/.zshrc.$hostname
fi

[ -f ~/.gitbranch.zsh ] && source ~/.gitbranch.zsh

export BETTER_EXCEPTIONS=1
# Fix for Vim's X11 functionality. Otherwise takes about a second to start (with +clipboard)
export SESSION_MANAGER=

export PATH="$(pyenv root)/shims:$HOME/.poetry/bin:$HOME/.cargo/bin:$PATH:$HOME/bin"

# copied from https://codeberg.org/scy/dotfiles/commit/2931e367611d4d79590dcf01433291e881791b89:
# ssh doesn't allow setting the TERM variable via SetEnv (in .ssh/config), see
# <https://serverfault.com/q/986847/50937>. However, some of the machines I'm
# connecting to don't have alacritty in their terminfo files. This is the
# workaround I came up with: Set TERM to xterm for the ssh command invocation.
ssh() {
    case "$TERM" in
        alacritty)
            TERM=xterm-256color command ssh "$@"
            ;;
        *)
            command ssh "$@"
            ;;
    esac
}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(pyenv init -)"
