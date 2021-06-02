# update {{{1
rbenvupdate(){
    rbenv update
}

packageupdate(){
    sudo apt -o Acquire::ForceIPv4=true update && \
        sudo apt -o Acquire::ForceIPv4=true dist-upgrade -y
}

wemuxupdate(){
    echo updating wemux...
    cd /usr/local/share/wemux && \
        sudo git pull
}

repoupdate(){
    for i in $REPO_DIR/*
    do
        if [ -d $i ]; then
            cd $i
            if [ -d .git ]; then
                echo updating $(basename $i)...
                gf
            fi
        fi
    done
}

allupdate(){
    originalDir=$(pwd)
    #type rbenv >/dev/null 2>&1 && rbenvupdate
    type apt > /dev/null 2>&1 && packageupdate
    [ -d "/usr/local/share/wemux" ] && wemuxupdate
    [ -d "$REPO_DIR" ] && repoupdate
    cd $originalDir
}
# git {{{1
gsa(){
    git status
}

gl(){
    git branch -avv
}

gtree(){
    git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"
}

ghis(){
    git log --branches --remotes --tags --graph --oneline --decorate
}

gup(){
    git rebase
}

gch(){
    git checkout
}

gf(){
    git fetch --prune --all && \
        git fetch --prune --all --tags
}

gcomp() {
    base=${1-master}
    head=$(git rev-parse --abbrev-ref HEAD)
    git diff "${base}..${head}"
}

gwip(){
    git commit -am wip
}
gamend(){
  git commit --amend --no-edit
}
# docker {{{1
rmdock(){
    cid=$(docker container ps | grep $1 | head -n1 | cut -f1 -d' ')
    docker container stop $cid
    docker container rm $cid
}

docksh(){
    docker exec -it $(docker ps | grep $1 | cut -f1 -d' ') /bin/bash
}

dockbuild() {
    idock build && \
    idock pull --local
}

dockpush() {
    docker push development-docker1:5000/development
}

dockrun() {
    idock run -c ~/git -n
}

run_container() {
    docker stop test_container; docker rm test_container; docker run --name test_container -it -v /var/run/docker.sock:/var/run/docker.sock $1 /bin/bash
}

jenkinsdockbuild() {
    docker build -t development-docker1:5000/jenkins-slave $REPO_DIR/docker/jenkins-slave
}

docc() {
    docker-compose -f /home/djtreder/git/docker/local_orchestration/docker-compose.yml $*
}

doccf() {
    docc up -d --force-recreate --no-deps $*
}
composedb() {
  docker exec -it tokumx mongo ascent_production_$1
}
# Misc {{{1
op(){
    xdg-open "$@"
}

psql(){
    /usr/lib/postgresql/9.4/bin/psql -h localhost "$@"
}

editaliases(){
    vim ~/.bash_aliases
    . ~/.bash_aliases
}

rrepl(){
    racket -i -t ~/.racket/.rc.rkt
}

p(){
    \ps -ef | grep -v --color=always grep | grep --color=always -e PPID -e "$@"
}

realias() {
    source ~/.bash_aliases
}

gemkill() {
    gem uninstall -I -x --all
}

# Empire
empqa2() {
    EMPIRE_API_URL=https://empire.ascentquality.net emp "$@"
}

#alias ls='ls --color=always --group-directories-first -AohF'
alias ls='ls -AohF'
alias sm='emacs -nw'
alias ec='emacsclient'
alias less='less -R'
alias grep='grep --color=always'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ps='ps -efH'
alias mkdir='mkdir -vp'
alias ^l=clear
alias calc="bc -l"
