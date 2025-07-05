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
plugins=(git command-not-found colored-man-pages sudo)

DISABLE_AUTO_UPDATE="true"

# Fix tab completion bug with UTF special characters in prompt - https://stackoverflow.com/a/22779469
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

source $ZSH/oh-my-zsh.sh

source <(fzf --zsh)

[ -f /usr/share/z/z.sh ] && source /usr/share/z/z.sh

export DOTNET_ROOT="/usr/share/dotnet"
export GOPATH="$HOME/.go"
export GOBIN="$HOME/.go/bin"
export GOROOT="/usr/lib/go"
export PATH="$PATH:~/.gem/ruby/2.7.0/bin:~/.dotnet/tools:~/.local/bin:$GOBIN"

# Time format for ls
export TIME_STYLE=long-iso

# pacman aliases
alias pacman-cleanup='paru -Rns $(paru -Qdtq)'
alias ugfw='fwupdmgr refresh && fwupdmgr update'

# Security
alias checkrootkits="sudo rkhunter --update; sudo rkhunter --propupd; sudo rkhunter --check"
alias checkvirus="clamscan --recursive=yes --infected /home"
alias updateantivirus="sudo freshclam"

export EDITOR=nvim

# Suffix aliases
alias -s {ape,avi,flv,m4a,mkv,mov,mp3,mp4,mpeg,mpg,ogg,ogm,wav,webm}=mpv

# Various shortcuts
alias restart='sudo shutdown -r now'
alias poweroff='sudo shutdown -P now'
alias reload='exec zsh -l'
alias ss='kitty +kitten ssh'
alias vi=nvim
alias vim=nvim
alias :q=exit
pk() { ps -ef | sed 1d | fzf -m --header='[kill:process]'| awk '{print $2}' | xargs kill -9 }
alias del='gio trash'
alias o='xdg-open'
alias l='ls --group-directories-first'
alias fz='nvim `find . | fzf --height=10`'
alias ra=ranger
alias y=yazi
alias cal='python -m calendar'
alias -g grepi='| grep -i'
lt() { ls -ltrsa "$@" | tail; }
psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto; }
remove_lines_from() { grep -F -x -v -f $2 $1; } # removes lines from $1 if they appear in $2
alias pp="ps axuf | pager"
alias sum="xargs | tr ' ' '+' | bc" ## Usage: echo 1 2 3 | sum
def() { sdcv $@ | fold }
e() { sayit "$@" 2>/dev/null }
mcd() { mkdir $1 && cd $1; }
i() { (head -5; tail -5) < "$1"; } #| column -t;
f() { find . -iname "*$1*" 2>/dev/null; }
extract () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf $1                        ;;
            *.tar.xz)   tar -xvf $1                        ;;
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

# Various web tools
cheat() { curl cht.sh/$1 }
alias weather="curl http://wttr.in/dublin"
alias meme="wget -L -O - -q reddit.com/r/memes.json | jq '.data.children[2] |.data.url' | xargs kitty +kitten icat"

# Version Control Systems
function svndiff { svn diff "${@}" | colordiff | less; }
alias gti="git"
#alias tf=/opt/tee-clc-14.134.0/tf

# Support brace expansion, e.g. {1..9} or {a-z}
setopt BRACE_CCL
zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.beam'

# Turn research PDF articles into PDF readable by Kobo e-reader
function kobo () {
	if [ -f $1 ]; then
		k2pdfopt -x -ui- -w 1264p -h 1680p -dpi 300 -om 0.2in -o $(basename $1 .pdf)-kobo.pdf $1
	else
		echo "'$1' is not a valid file"
	fi
}

# Compress an mp4 video
function videocompress () {
	if [ -f $1 ]; then
		ffmpeg -i $1 -vcodec libx265 -crf 28 $2
	else
		echo "'$1' is not a valid file"
	fi
}

function videocompress-folder () {
    mkdir -p compressed
    for f in $(ls *.mp4)
    do
        videocompress $f compressed/$f
    done
}

# Reset USB - sometimes USB-C Hub gets unresponsive and external
# keyboard and mouse stop working (see:
# dmesg and
# https://askubuntu.com/a/290519  and
# https://blog.wesleyac.com/posts/linux-reset-usb )
function usb-reset () {
    for i in /sys/bus/pci/drivers/[uoex]hci_hcd/*:*; do
        [ -e "$i" ] || continue
        echo "${i##*/}" | sudo tee "${i%/*}/unbind"
        echo "${i##*/}" | sudo tee "${i%/*}/bind"
    done
}

vi_mode=false
if [ "$vi_mode" = true ] ; then
    # vi mode (bindkey -l - to check key bindings)
    bindkey -v
    export KEYTIMEOUT=1

    # Use vim keys in tab complete menu:
    bindkey -M menuselect 'h' vi-backward-char
    bindkey -M menuselect 'k' vi-up-line-or-history
    bindkey -M menuselect 'l' vi-forward-char
    bindkey -M menuselect 'j' vi-down-line-or-history
    # Reverse history search (not active by default in vi mode)
    bindkey "^R" history-incremental-search-backward
    # Delete key
    bindkey -a '^[[3~' delete-char
    bindkey '^[[3~' delete-char

    # Change cursor shape for different vi modes.
    function zle-keymap-select {
      if [[ ${KEYMAP} == vicmd ]] ||
         [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
      elif [[ ${KEYMAP} == main ]] ||
           [[ ${KEYMAP} == viins ]] ||
           [[ ${KEYMAP} = '' ]] ||
           [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
      fi
    }
    zle -N zle-keymap-select
    zle-line-init() {
        zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
        echo -ne "\e[5 q"
    }
    zle -N zle-line-init
    echo -ne '\e[5 q' # Use beam shape cursor on startup.
    preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

    # Edit line in vim with ctrl-e:
    autoload edit-command-line; zle -N edit-command-line
    bindkey '^e' edit-command-line
fi

# enable bash autocompletion in zsh
autoload -U +X bashcompinit && bashcompinit

# Azure cli autocompletion
source /opt/azure-cli/bin/az.completion.sh

# Version managers: asdf and nvm
#source $HOME/.asdf/asdf.sh
#source $HOME/.asdf/completions/asdf.bash
#function cd {
#    builtin cd "$@"
#    if [ -f "bin/activate" ] ; then
#        source bin/activate
#    fi
#}
# nvm (node version manager)
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Bluetooth headset
headset_mac="04:52:C7:E1:98:F3"
alias bton='echo "power on\nconnect $headset_mac" | bluetoothctl'
alias btoff="bluetoothctl -- power off"

# Text files shortcuts
alias journal="vim ~/docs/notes/journal.md"
alias notes="vim ~/docs/notes"

# Print a random command line snippet from commandlinefu
api=https://www.commandlinefu.com/commands/browse/sort-by-votes/plaintext
cmd_db=$HOME/.cache/commandlinefu
if [ ! -f $cmd_db ]; then
    for offset in $(seq 0 25 125); do
        curl $api/$offset | tail +3 >> $cmd_db
    done
fi
line=$(($(seq 99 | shuf -n 1) * 3 + 1))
sed -n "$line{N;p}" $cmd_db

# k8s
alias k="kubectl"
[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)

# llama
oll() {
  model="llama3.2:3b"
  if [ -n "$1" ]; then
    echo "$1" | ollama run "$model"
  else
    ollama run "$model"
  fi
}


# Reset laptop monitor - sometimes it gets stuck after suspend, unknown root cause
alias screen-reset="swaymsg output eDP-1 disable; swaymsg output eDP-1 enable"

eval "$(zoxide init --cmd cd zsh)"
