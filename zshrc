# Path to oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Look in ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git python command-not-found colored-man-pages)

DISABLE_AUTO_UPDATE="true"

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:~/.gem/ruby/2.6.0/bin:~/.dotnet/tools
export DOTNET_ROOT="/opt/dotnet"

# Time format for ls
export TIME_STYLE=long-iso

# pacman aliases
alias ug='sudo pacman -Syu'
alias ugaur='yaourt -Syu --aur'

pass() {
    [ ! -d /tmp/tc ] && mkdir /tmp/tc
    veracrypt ~/docs/tc_volume /tmp/tc
    cat /tmp/tc/pwd/*$1*
    veracrypt -d
}

export EDITOR=nvim

# Various shortcuts
alias restart='sudo shutdown -r now'
alias poweroff='sudo shutdown -P now'
alias vi=nvim
alias vim=nvim
pk() { ps -ef | sed 1d | fzf -m --header='[kill:process]'| awk '{print $2}' | xargs kill -9 }
alias del='gio trash'
alias o='xdg-open'
alias l='ls'
alias ra=ranger
alias -g grepi='| grep -i'
lt() { ls -ltrsa "$@" | tail; }
psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto; }
fname() { find . -iname "*$@*"; }
remove_lines_from() { grep -F -x -v -f $2 $1; } # removes lines from $1 if they appear in $2
alias pp="ps axuf | pager"
alias sum="xargs | tr ' ' '+' | bc" ## Usage: echo 1 2 3 | sum
alias def=sdcv
alias e="espeak 2>/dev/null"
mcd() { mkdir $1 && cd $1; }
i() { (head -5; tail -5) < "$1"; } #| column -t;
f() { find . -iname "*$1*" 2>/dev/null; }
extract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf $1                        ;;
            *.tar.gz)   tar -zxvf $1                        ;;
            *.bz2)      bunzip2 $1                          ;;
            *.dmg)      hdiutil mount $1                    ;;
            *.gz)       gunzip $1                           ;;
            *.tar)      tar -xvf $1                         ;;
            *.tbz2)     tar -jxvf $1                        ;;
            *.tgz)      tar -zxvf $1                        ;;
            *.zip)      unzip $1                            ;;
            *.ZIP)      unzip $1                            ;;
            *.pax)      cat $1 | pax -r                     ;;
            *.pax.Z)    uncompress $1 --stdout | pax -r     ;;
            *.rar)      unrar x $1                          ;;
            *.Z)        uncompress $1                       ;;
            *)          echo "'$1' cannot be extracted/mounted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Various web
cheat() { curl cht.sh/$1 }
alias weather="curl http://wttr.in/dublin"

# Version Control Systems: SVN, Git, TFS
function svndiff { svn diff "${@}" | colordiff | less; }
alias gti="git"
alias tf=/opt/tee-clc-14.134.0/tf

# Support brace expansion, e.g. {1..9} or {a-z}
setopt BRACE_CCL
zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.beam'

# Turn research PDF articles into PDF readable by Kobo e-reader
function kobo () {
	if [ -f $1 ]; then
		k2pdfopt -x -ui- -w 758p -h 942p -dpi 213 -om 0.2in -o $(basename $1 .pdf)-kobo.pdf $1
	else
		echo "'$1' is not a valid file"
	fi
}

# Fix for Yoga laptop monitor transient color problem
alias recolor="xrandr --output eDP1 --set 'Broadcast RGB' 'Full'"

# Version managers: asdf and nvm
#source $HOME/.asdf/asdf.sh
#source $HOME/.asdf/completions/asdf.bash
#source /usr/share/nvm/init-nvm.sh
#function cd {
#    builtin cd "$@"
#    if [ -f "bin/activate" ] ; then
#        source bin/activate
#    fi
#}

# Text files shortcuts
alias journal="vim ~/docs/notes/journal.md"
alias notes="vim ~/docs/notes"

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
