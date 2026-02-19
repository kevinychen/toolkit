export HISTCONTROL="ignoredups:ignorespace"
export HISTFILESIZE=999999
export HISTSIZE=999999
export PS1='\[\e[33;1m\]\h \[\e[31m\]\w\[\e[0m\]\$ '
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export PYTHONPATH=~/repos/toolkit/python
alias pu='PYTHONSTARTUP=~/repos/toolkit/python/bootstrap.py p'

alias ..='cd ..'
alias a='fc -s'
alias f='find . -name'
alias p='python3'
alias t='tmux'
alias cl='claude'
alias co='curl -O'
alias ll='ls -la'
alias vb='vim ~/.bashrc'
alias vd='vimdiff'
alias grep='grep --color=auto'
alias load='source ~/.bashrc'
alias binextract='binwalk --dd=".*"'

alias db='docker build .'
alias ddown='docker-compose stop'
alias di='docker images'
alias dl='docker logs'
alias dps='docker ps'
alias dr='docker run -i -t --rm --privileged'
alias drm='docker rm'
alias drmall='docker rm $(docker ps -a -q)'
alias drmi='docker image rm'
alias dsall='docker stop $(docker ps -a -q)'
alias dup='docker-compose up'

source ~/repos/toolkit/git-completion.bash
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
alias gf='git fetch --tags'
alias gg='git grep'
alias gh='git rev-parse HEAD' # (h)ash
alias gi='git init'
alias gk='gitk --all'
alias gl='git log'
alias gm='git merge'
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

alias gw='./gradlew'
alias gwc='./gradlew compileJava'

function gap() {
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
__git_complete glab _git_branch

function gron() {
    git rebase --onto $1 HEAD~1 `git rev-parse --abbrev-ref HEAD`
}
__git_complete gron _git_rebase

function ged() {
    git rebase -i HEAD~$1
}

function gll() {
    git log -L $2,$2:$1
}

function greplace() {
    git grep -l "$1" | xargs sed -i '' -e "s/$1/$2/g"
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
__git_complete gup _git_branch

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

function mcd() {
    mkdir $1 && cd $1
}

function seek() {
    grep $1 * -r
}

function seekreplace() {
    find . -type f -exec sed -i '' -e "s/$1/$2/" {} \;
}

function c() {
    cat $1 | pbcopy
}

function v() {
    ext=${1#*.}
    if [ "$ext" = "jks" ]
    then
        keytool -list -v -keystore $1 | less
    elif [ "$ext" = "cer" ] || [ "$ext" = "pem" ]
    then
        openssl x509 -in $1 -noout -text | less
    else
        vim $1
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

# find 20 most recently updated files in this directory (recursive)
function recent() {
    time find . -xdev -type f -print0 | xargs -0 stat -f "%m%t%Sm %N" | sort -rn | head -n 20 | cut -f2-
}

# convert a mov file to gif
# change the scale (width) and delay (delay between frames, larger value gives a slower gif) as appropriate
# requires brew install ffmpeg gifsicle
function gif() {
    ffmpeg -i $1 -vf "fps=10,scale=800:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 -f gif - | gifsicle --optimize=3 --delay=4 -o $2
}

# generate a product dependency graph of a Gradle project
# should be executed in the root directory of the Gradle project
# requires brew install graphviz
# to view the graph: open project-dependencies.png
function depgraph() {
    echo "apply from: System.getProperty('user.home') + '/repos/toolkit/dependency-report.gradle'" >> build.gradle
    ./gradlew moduleDependencyReport
    cat build.gradle | tail -r | tail -n +2 | tail -r > build.gradle.tmp && mv build.gradle.tmp build.gradle
    dot -Tpng project-dependencies.dot -o project-dependencies.png
    rm project-dependencies.dot
}

function java_use() {
    export JAVA_HOME=$(/usr/libexec/java_home -v $1)
    export PATH=$JAVA_HOME/bin:$PATH
    java -version
}

function acpoet() {
    source $(poetry env info --path)/bin/activate
}

# "datamuse lc ice" returns words that follow ice
function datamuse() {
    curl "https://api.datamuse.com/words?$1=$2&sp=*" | jq -r '.[].word' | less
}

# Run `docker build .` and then `docker images` to get the arg
function dr() {
    docker run -i -t $1 /bin/bash
}

# Continuously sync the current directory to remote server $1, ssh there, and start tmux session
function moveto() {
    rsync -a . root@$1:/root/${PWD##*/}/;
    fswatch --recursive --one-per-batch . | while read line; do rsync -a . root@$1:/root/${PWD##*/}/; done &
    ssh -t root@$1 "tmux new 'bash --init-file <(echo \"source ~/.bashrc; source venv/bin/activate; cd ${PWD##*/}\")';"
    fg
}

# Returns bytes [start, end) of the file
function bincarve() {
    local file="$1"
    local start="$2"
    local end="$3"

    if [[ -z "$end" ]]; then
        # No end: extract from $start to EOF
        dd if="$file" bs=1 skip="$start" status=none
    else
        # End provided: extract from $start to ($end - 1)
        local count=$((end - start))
        dd if="$file" bs=1 skip="$start" count="$count" status=none
    fi
}

# vim keybindings with selected ones from emacs
set -o vi
bind -m vi-command ".":insert-last-argument
bind -m vi-insert "\C-l.":clear-screen
bind -m vi-insert "\C-a.":beginning-of-line
bind -m vi-insert "\C-e.":end-of-line
bind -m vi-insert "\C-w.":backward-kill-word
bind -m vi-insert "\C-u.":kill-line

if command -v sage > /dev/null 2>&1; then
    alias sagep=$(sage -python -c "import sys; print(sys.executable)")
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.gitignore'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

