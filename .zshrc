autoload -Uz compinit
compinit
if [ ! -d "$HOME/.antidote" ]
then
    git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
fi
source ~/.antidote/antidote.zsh
antidote load
source ~/dotfiles/l3vi2.zsh-theme

setopt auto_cd interactive_comments promptsubst

unset MAILCHECK

# Aliasses
alias ls='ls --color' alias ll='ls --color -lh' l='ls --color -lah'
alias wow='git status'
alias v=vim vi=vim t=tig
alias livestreamer='livestreamer --http-header Client-ID=jzkbprff40iqj646a697cyrvl0zt2m6 --player /usr/local/bin/mpv'
alias grc='git rebase --continue'
alias rgp='rg -t py'
alias tmux='tmux -2'

# custom functions
srsly(){
    until $*
    do
        sleep 0.1
    done}
compdef srsly='sudo' #autocompletion like sudo
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
lookup() {dig -x `dig +short $*`}
p() {
    if [ -z "$*" ]
    then
        ipython
    else
        python3 -q $*
    fi
}
take() {
    mkdir -p $@ && cd ${@:$#}
}

export MOSH_TITLE_NOPREFIX=1
export MOSH_SERVER_NETWORK_TMOUT=604800
export PYTHONPATH="./.pip:$PYTHONPATH:$HOME"
export FZF_DEFAULT_COMMAND='fd --type f'
export HISTSIZE=1000000
export HISTFILESIZE=10000000
export BETTER_EXCEPTIONS=1
# Fix for Vim's X11 functionality. Otherwise takes about a second to start (with +clipboard)
export SESSION_MANAGER=
export PATH="$HOME/.pyenv/bin:$HOME/.pyenv/shims:$HOME/.poetry/bin:$HOME/.cargo/bin:$PATH:$HOME/bin"
export VIRTUAL_ENV_DISABLE_PROMPT=1
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;
31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'

if [ -f ~/.zshrc.$uname ]; then
    source ~/.zshrc.$uname
fi
if [ -f ~/.zshrc.$hostname ]; then
    source ~/.zshrc.$hostname
fi

[ -f ~/.gitbranch.zsh ] && source ~/.gitbranch.zsh

_evalcache pyenv init -
