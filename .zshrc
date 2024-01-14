if [ ! -d "$HOME/.zplug" ]
then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"  # zplugception
zplug "~/dotfiles/.oh-my-zsh/themes", from:local, as:theme
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/zshmarks", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
zplug "L3viathan/fzf", use:"shell/*.zsh"
zplug "junegunn/fzf", from:gh-r, as:command, use:"*"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "robbyrussell/oh-my-zsh", use:"lib/{directories.zsh,key-bindings.zsh,history.zsh}"
zstyle ":zplug:tag" depth 1
# if ! zplug check; then
#         zplug install
# fi
zplug load
source ~/.zplug/repos/L3viathan/fzf/shell/key-bindings.zsh
source ~/.zplug/repos/L3viathan/fzf/shell/completion.zsh

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
