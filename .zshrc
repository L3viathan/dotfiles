#<oh-my-zsh_stuff>
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
CASE_SENSITIVE="true"
export EDITOR="vim"
export VISUAL="vim"
COMPLETION_WAITING_DOTS="true"
unsetopt correct_all #disable auto correction
plugins=(git zsh-syntax-highlighting pip mosh zshmarks dirhistory fzf-zsh z)
source $ZSH/oh-my-zsh.sh
#</oh-my-zsh_stuff>

# PATH adjustments: add scripts and wd
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_102.jdk/Contents/Home"

unset MAILCHECK

# Aliasses and custom functions
alias ls='exa' ll='ls -lh --git' l='ls -lah --git'
alias such='git' very='git' many='git' so='git' much='git' wow='git status'
alias yolo='git commit -am "DEAL WITH IT" && git push -f origin master'
alias -9="kill -9" c="crun" rf="rm -rf" v="vim" s="ssh" o="open" t="tig" m="make"
alias :q="exit"
alias ≤="git pull" ≥="git push"
alias youtube-dl='youtube-dl -o "%(title)s.%(ext)s" --restrict-filenames'
alias livestreamer='livestreamer --http-header Client-ID=jzkbprff40iqj646a697cyrvl0zt2m6 --player /usr/local/bin/mpv'
alias lg='ls -l| egrep --color=never'
alias ly='ls| egrep --color=never "(mp4|webm|flv|m4v|3gp|mkv|avi)$"'
alias lm='ls| egrep --color=never "(mp3|ogg|flac|wav|m4a|wma)$"'
alias lsd='ls -F| grep /'
alias howami="curl -L api.l3vi.de/mood.json 2>/dev/null | jq -r '.mood'"
alias lati="curl -L api.l3vi.de/location.json 2>/dev/null | jq .lat"
alias lon="curl -L api.l3vi.de/location.json 2>/dev/null | jq .lon"
alias whereami="curl -L http://api.l3vi.de/location.json 2>/dev/null| jq -r '.address'"
alias oneline='while read -r line;do;echo -n "\r$line";done'
alias ccat='pygmentize -g'
alias l3vi='mosh l3vi -- tmux attach -d'
alias mplayer=mpv vi=vim
alias -g °='~/.zshrc' √='~/.vimrc'
alias gs="(cd ~/GIT/solute && git standup -sm 3)"
alias wr="wormhole receive" ws="wormhole send"

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

alias tmux='tmux -2'

alias whendidirunthelastcommand='date -r$(tail -n 2 ~/.zsh_history|head -n 1 | cut -d ":" -f 2 | tr -d " ")'

p() {
    if [ -z "$*" ]
    then
        ipython3
    else
        python3 -q $*
    fi
}

export FZF_DEFAULT_COMMAND='fd --type f'

export hostname=$(hostname)
export uname=$(uname)

if [ -f ~/.zshrc.$uname ]; then
    source ~/.zshrc.$uname
fi
if [ -f ~/.zshrc.$hostname ]; then
    source ~/.zshrc.$hostname
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.gitbranch.zsh ] && source ~/.gitbranch.zsh
