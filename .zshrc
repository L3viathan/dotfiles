#<oh-my-zsh_stuff>
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="l3vi2"
CASE_SENSITIVE="true"
export EDITOR="vim"
export VISUAL="vim"
COMPLETION_WAITING_DOTS="true"
unsetopt correct_all #disable auto correction
plugins=(git python osx battery zsh-syntax-highlighting tmux pip mosh sublime zshmarks dirhistory)
source $ZSH/oh-my-zsh.sh
#</oh-my-zsh_stuff>

# PATH adjustments: add scripts and wd
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/bin:/usr/sbin:/sbin:/usr/bin:/usr/local/git/bin:/opt/local/bin:.
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_102.jdk/Contents/Home"

unset MAILCHECK

# Aliasses and custom functions
alias such='git' very='git' many='git' so='git' wow='git status' ql="quick-look"
alias yolo='git commit -am "DEAL WITH IT" && git push -f origin master'
alias -9="kill -9" c="cat" rf="rm -rf" v="vim" s="ssh" o="open"
alias :q="exit"
alias ≤="git pull" ≥="git push"
alias youtube-dl='youtube-dl -o "%(title)s.%(ext)s" --restrict-filenames'
alias livestreamer='livestreamer --http-header Client-ID=jzkbprff40iqj646a697cyrvl0zt2m6 --player /usr/local/bin/mpv'
alias ls='ls -F'
alias lg='ls -l| egrep --color=never'
alias ly='ls| egrep --color=never "(mp4|webm|flv|m4v|3gp|mkv|avi)$"'
alias lm='ls| egrep --color=never "(mp3|ogg|flac|wav|m4a|wma)$"'
alias lsd='ls -F| grep /'
alias howami="curl -L api.l3vi.de/mood.json 2>/dev/null | jq -r '.mood'"
alias lati="curl -L api.l3vi.de/location.json 2>/dev/null | jq .lat"
alias lon="curl -L api.l3vi.de/location.json 2>/dev/null | jq .lon"
alias whereami="curl -L http://api.l3vi.de/location.json 2>/dev/null| jq -r '.address'"
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc'
alias play="osascript -e 'tell application \"iTunes\"' -e \"play\" -e \"end tell\"" pause="osascript -e 'tell application \"iTunes\"' -e \"pause\" -e \"end tell\"" next="osascript -e 'tell application \"iTunes\"' -e \"next\" -e \"end tell\"" prev="osascript -e 'tell application \"iTunes\"' -e \"prev\" -e \"end tell\""
alias wifi-on="networksetup -setairportpower en0 on" wifi-off="networksetup -setairportpower en0 off" wifi-fix="networksetup -setairportpower en0 off && sleep 5 && networksetup -setairportpower en0 on" wifi-brechstange="while true;do;networksetup -setairportpower en0 on;networksetup -setairportpower en0 off;sleep 1;done"
alias oneline='while read -r line;do;echo -n "\r$line";done'
alias ccat='pygmentize -g'
alias l3vi='mosh l3vi -- tmux attach -d'
alias rosay='say -v Ioana' uksay='say -v Daniel' desay='say -v Anna'
alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'
alias mplayer=mpv vi=vim
alias -g °='~/.zshrc' √='~/.vimrc'

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
vol() {osascript -e "set volume $1"}
show() {osascript -e "tell application \"$1\" to activate"}
mkcd() {mkdir $1 && cd $1}
compdef srsly='sudo' #autocompletion like sudo
compdef shutup='sudo' #autocompletion like sudo
compdef maybe='sudo' #autocompletion like sudo
export MOSH_TITLE_NOPREFIX=1
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

avaliable(){whois $* |grep AVAILABLE }
alias please='sudo $(fc -ln -1)'

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
alias whendidirunthelastcommand='date -r$(tail -n 2 ~/.zsh_history|head -n 1 | cut -d ":" -f 2 | tr -d " ")'
it2prof() { echo -e "\033]50;SetProfile=$1\a" }
focus() { echo -e "\033]50;StealFocus\a" }
alias crep='grep --color=yes'
alias T='it2prof Tagsüber' N='it2prof Nachts'
alias a='open -a'

p() {
    if [ -z "$*" ]
    then
        ptpython3
    else
        python3 -q $*
    fi
}

alias google="googler --np -n 3 -lang en"
