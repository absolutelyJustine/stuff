#   -------------------------------
#   ENVIRONMENT CONFIGURATION
#   -------------------------------

export PATH=$PATH:~/bin
export NODE_ENV='dev'
export GOPATH=$HOME/go

function dmclean1 {
  if [ $(docker ps -a -q -f status=exited | wc -l) -gt 1 ] ; then
    docker rm -v $(docker ps -a -q -f status=exited);
  fi
}

function dmclean2 {
  if [ $(docker images -f 'dangling=true' -q | wc -l) -gt 1 ] ; then
    docker rmi $(docker images -f 'dangling=true' -q);
  fi
}

function dmclean3 {
  if [ $(docker volume ls -qf dangling=true | wc -l) -gt 1 ] ; then
    docker volume rm $(docker volume ls -qf dangling=true);
  fi
}

#   -----------------------------
#   VIM EDITOR
#   -----------------------------

alias vi=vim
alias svi='sudo vi'
alias vis='vim "+set si"'
alias edit='vim'

#   -----------------------------
#   ALIASES
#   -----------------------------

alias rs='source ~/.bashrc' 
alias chrome='open -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args -remote-debugging-port=9222'
alias binfix='find ~/bin -type f | xargs chmod +x'
alias dmclean="dmclean1 && dmclean2 && dmclean3"

alias devupdate="ecr-login && docker pull 287054460789.dkr.ecr.us-east-1.amazonaws.com/polaris/devenv-nodejs-polarisplatform:latest && docker run --rm -it -v \"$HOME\"/://userhome -v \"$HOME/bin/\"://hostbin --entrypoint=bash '287054460789.dkr.ecr.us-east-1.amazonaws.com/polaris/devenv-nodejs-polarisplatform' //app/install && binfix"
alias appupdate="ecr-login && docker pull 287054460789.dkr.ecr.us-east-1.amazonaws.com/polaris/appenv-angular2-polarisplatform:latest && docker run --rm -it -v \"$HOME/bin/\"://hostbin --entrypoint=bash '287054460789.dkr.ecr.us-east-1.amazonaws.com/polaris/appenv-angular2-polarisplatform' //app/install && binfix"
alias policyupdate="adgpupdate"
alias appbash="docker run -it -v '/`pwd`':'//code' -v $HOME'/.npmrc':'//root/.npmrc' --rm --volumes-from npmcachervol:rw --volumes-from ${PWD##*/}-npm:rw --entrypoint=bash 287054460789.dkr.ecr.us-east-1.amazonaws.com/polaris/appenv-angular2-polarisplatform"
alias devbash="docker run -it -v '/`pwd`':'//code' -v $HOME'/.npmrc':'//root/.npmrc' --rm --volumes-from npmcachervol:rw --volumes-from ${PWD##*/}-npm:rw --entrypoint=bash 287054460789.dkr.ecr.us-east-1.amazonaws.com/polaris/devenv-nodejs-polarisplatform"

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ..'                            # Go back 1 directory level
alias ...='cd ../..'                        # Go back 2 directory levels
alias .3='cd ../../..'                      # Go back 3 directory levels
alias .4='cd ../../../..'                   # Go back 4 directory levels
alias .5='cd ../../../../..'                # Go back 5 directory levels
alias .6='cd ../../../../../..'             # Go back 6 directory levels
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias histg='history | grep'                # Search history with a grep of the history command's output
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside

#   -------------------------------
#   DOCKER MANAGEMENT
#   -------------------------------

alias dkpsa='docker ps -a'                  # List all containers (default lists just running)
alias dkcls='docker container ls'           # List containers
alias dkcps='docker-compose ps'             # List docker-compose containers
alias dkils='docker image ls'               # List images
alias dkvls='docker volume ls'              # List volumes
alias dkmls='docker-machine ls'             # List docker-machines


alias dkstoprm='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Clean up exited containers (docker < 1.13)
alias dkrmC='docker rm $(docker ps -qaf status=exited)'

# Clean up dangling images (docker < 1.13)
alias dkrmI='docker rmi $(docker images -qf dangling=true)'

# Pull all tagged images
alias dkplI='docker images --format "{{ .Repository }}" | grep -v "^<none>$" | xargs -L1 docker pull'

# Clean up dangling volumes (docker < 1.13)
alias dkrmV='docker volume rm $(docker volume ls -qf dangling=true)'

startover() {
  echo 'Killing everything'
  docker stop $(docker ps -a -q)
  docker rm -f $(docker ps -a -q)
  docker rmi -f $(docker images -q)
  echo 'Everything killed, my lord'
}


#   -------------------------------
#   FILE AND FOLDER MANAGEMENT
#   -------------------------------

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<EOT
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }


#   dev:  travel to dev directory
#   ---------------------------------------------------------
    dev () {
      printf "\n\nMoving to ~/dev directory\n\n"
      cd ~/dev
    }

#   ---------------------------------------
#   WEB DEVELOPMENT
#   ---------------------------------------

alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/httpd/error_log'              # herr:             Tails HTTP error logs
