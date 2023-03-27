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
alias c="crun" rf="rm -rf" v="vim" s="ssh" t="tig" m="make"
alias :q="exit"
alias youtube-dl='youtube-dl -o "%(title)s.%(ext)s" --restrict-filenames'
alias livestreamer='livestreamer --http-header Client-ID=jzkbprff40iqj646a697cyrvl0zt2m6 --player /usr/local/bin/mpv'
alias lg='ls -l| egrep --color=never'
alias ly='ls| egrep --color=never "(mp4|webm|flv|m4v|3gp|mkv|avi)$"'
alias lm='ls| egrep --color=never "(mp3|ogg|flac|wav|m4a|wma)$"'
alias lsd='ls -F| grep /'
alias oneline='while read -r line;do;echo -n "\r$line";done;echo'
alias ccat='pygmentize -g'
alias l3vi='mosh l3vi -- tmux attach -d'
alias mplayer=mpv vi=vim
alias -g °='~/.zshrc' √='~/.vimrc'
alias gs="(cd ~/git && git standup -sm 3)"
alias wr="wormhole receive" ws="wormhole send"
alias arm="exec arch -arm64 $SHELL --login"
alias intel="exec arch -x86_64 $SHELL --login"

# custom functions
+(){while true; do; say "ping" && ping -oc 100000 8.8.8.8 > /dev/null && say "pong"; done}
srsly(){
    until $*
    do
        sleep 0.1
    done}
shutup(){$* >/dev/null 2>&1}
maybe(){if [ $(($RANDOM%2)) -eq 1 ]
then
    $*
fi}
mkcd() {echo "Use take instead"}
alias unzero='perl -pe ''s/\0/\t/\'' | sed -e \''$a\'''
compdef srsly='sudo' #autocompletion like sudo
compdef shutup='sudo' #autocompletion like sudo
compdef maybe='sudo' #autocompletion like sudo
export MOSH_TITLE_NOPREFIX=1
export MOSH_SERVER_NETWORK_TMOUT=604800
lookup() {dig -x `dig +short $*`}
export PYTHONPATH="./.pip:$PYTHONPATH:$HOME"

#global aliases (substitution within command)
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L='| less'
alias -g NE="2>/dev/null"
alias -g NUL=">/dev/null 2>&1"
alias -g EO="2>&1"

#What to do when "executing" filenames:

alias -s pdf="open"
#list archive contents
alias -s zip="unzip -l"
alias -s tar="tar tf"
alias -s tar.gz="tar tfz"
alias -s tgz="tar tfz"
alias -s mid="timidity"

avaliable(){whois $* |grep AVAILABLE }
alias please='sudo $(fc -ln -1)'
alias crep='grep --color=yes'
alias gdm='git diff master'
alias grc='git rebase --continue'
alias rgp='rg -t py'
alias rgi='rg --no-ignore'
alias rgip='rg --no-ignore -t py'
alias rgpi='rg --no-ignore -t py'
alias V='. venv/bin/activate'
alias C='asciinema play cast.cast'

alias tmux='tmux -2'

alias whendidirunthelastcommand='date -r$(tail -n 2 ~/.zsh_history|head -n 1 | cut -d ":" -f 2 | tr -d " ")'

p() {
    if [ -z "$*" ]
    then
        ipython
    else
        python3 -q $*
    fi
}

function twitch() {streamlink --http-header Client-ID=jzkbprff40iqj646a697cyrvl0zt2m6 --player /usr/local/bin/mpv --twitch-disable-ads "https://www.twitch.tv/$1" 720p60}

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
