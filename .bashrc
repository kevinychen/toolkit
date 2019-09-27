export HISTFILESIZE=999999
export HISTSIZE=999999
export PS1='\[\e[33;1m\]\u@\h: \[\e[31m\]\W\[\e[0m\]\$ '
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export PYTHONPATH=~/repos/snap2/snap-python
alias puz='PYTHONSTARTUP=~/repos/snap2/snap-python/bootstrap.py python'

alias ..='cd ..'
alias d='docker'
alias f='find . -name'
alias k='kill -9'
alias l='ls -a'
alias n='terminal-notifier -message done'
alias p='python'
alias ll='ls -la'
alias vb='vim ~/.bashrc'
alias vd='vimdiff'
alias grep='grep --color=auto'
alias load='source ~/.bashrc'

alias ga='git add'
alias gam='git commit --amend'
alias gb='git branch'
alias gbl='git blame'
alias gc='git commit'
alias gch='git checkout'
alias gcl='git clone'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gd='git diff'
alias gde='git describe --tags'
alias gdh='git diff HEAD'
alias gdo='git diff HEAD~1'
alias gds='git diff --stat'
alias ge='git config --global user.email'
alias gf='git fetch --tags'
alias gg='git grep'
alias gh='git rev-parse HEAD' # (h)ash
alias gi='git init'
alias gk='gitk --all'
alias gl='git log'
alias gm='git merge'
alias gn='git config --global user.name'
alias gp='git pull'
alias gpu='git push -u origin HEAD'
alias gpuf='git push -u origin HEAD --force'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias grd='git commit --amend --date="$(date)"'
alias grs='git reset HEAD~1'
alias grsh='git reset HEAD --hard'
alias grso='git reset HEAD~1 --hard'
alias grv='git revert'
alias grvc='git revert --continue'
alias gs='git status; git log | head'
alias gsh='git show'
alias gshs='git show --stat'
alias gt='git tag'
alias gx='git branch -D'

alias gw='./gradlew'
alias gwe='./gradlew eclipse'
alias gwc='./gradlew compileJava'

alias dc='docker-compose'
alias dcp='docker cp'
alias di='docker images'
alias dps='docker ps'
alias dsall='docker stop $(docker ps -a -q)'
alias drmall='docker rm $(docker ps -a -q)'
alias drmi='docker rmi'
alias dup='docker-compose up -d'

function gap {
    if [ -e $1 ]
    then
        git apply $1
    else
        git cherry-pick --no-commit $1
    fi
}

function glab() {
    git branch -D $1
    git checkout -b $1
}

function gon() {
    git checkout $1
    git rebase --onto $2 $1~1 $1
}

function ged() {
    git rebase -i HEAD~$1
}

function ggr() {
    git grep -l $1 | xargs sed -i '' -e "s/$1/$2/g"
}

function gll() {
    git log -L $2,$2:$1
}

function gsq() {
    git reset --soft HEAD~`expr $1 - 1`
    git commit --amend
}

function gup() {
    currBranch=`git rev-parse --abbrev-ref HEAD`
    git checkout $1
    git pull
    git checkout $currBranch
}

function kexport() {
    keytool -export -keystore $1 -alias $2 -file $3
}

function kimport() {
    keytool -import -file $1 -alias $2 -keystore $3
}

function kchpass() {
    keytool -storepasswd -keystore $1
}

function kchalias() {
    keytool -changealias -keystore $1 -alias $2 -destalias $3
}

function cd() {
    # Show ls after every cd
    new_directory="$*";
    if [ $# -eq 0 ]; then
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}" && ls
}

function seek() {
    grep $1 * -r
}

function c() {
    cat $1 | pbcopy
}

function v() {
    ext=${1#*.}
    if [ "$ext" = "jks" ]
    then
        keytool -list -v -keystore $1 | less
    elif [ "$ext" = "cer" ]
    then
        openssl x509 -in $1 -noout -text
    elif [ "$ext" = "jpg" ] || [ "$ext" = "png" ] || [ "$ext" = "gif" ]
    then
        imgcat $1
    elif [ "$ext" = "pdf" ]
    then
        open $1
    else
        vi $1
    fi
}

function r() {
    ext=${1#*.}
    if [ $ext = "java" ]
    then
        javac $1
        java ${1%.*}
    elif [ $ext = "scala" ]
    then
        scalac $1
        scala ${1%.*}
    fi
}

function xfind() {
    for file in `find . -name "*.$1"`; do grep $2 $file /dev/null; done
}

function port() {
    lsof -n -i:$1 | grep LISTEN
}

function gif() {
    ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3
}

# vim keybindings with selected ones from emacs
set -o vi
bind -m vi-command ".":insert-last-argument
bind -m vi-insert "\C-l.":clear-screen
bind -m vi-insert "\C-a.":beginning-of-line
bind -m vi-insert "\C-e.":end-of-line
bind -m vi-insert "\C-w.":backward-kill-word
bind -m vi-insert "\C-u.":kill-line

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -a ~/.bashrc.mine ]
then
    source ~/.bashrc.mine
fi

