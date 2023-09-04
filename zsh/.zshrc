
# ------------------------------
# Functions
# ------------------------------


# create symbolic link at Desktop
function dln() {
  ln -s "${1}" "${HOME}/Desktop/"
}
alias lnd=dln


function mkproject() {
  dir="${HOME}/Projects/${1}"
  mkdir "${dir}"
  ln -s "${dir}" "${HOME}/Desktop/"
}
alias mkprj='mkproject'


function mkmemo() {
  $1=${1:+_$1}
  name="~/Memo/$(date '+%Y%m%d_%H%M%S')${1}.md"
  touch $name
}

# print color list (useful for prompt customization)
function colorlist() {
  for color in {000..015}; do
    print -nP "%F{$color}$color %f"
  done
  printf "\n"
  for color in {016..255}; do
    print -nP "%F{$color}$color %f"
    if [ $(($((color-16))%6)) -eq 5 ]; then
      printf "\n"
    fi
  done
}

# fuzzy cd
function zd() {
  local dir
  dir=$(find ${1:-~} -type d -maxdepth 5 -print 2>/dev/null | fzf +m) && cd "$dir"
}
alias zdd='zd ~'
alias zdp='zd ~/Projects/'

# fuzzy nvim
function zv() {
  local file
  file=$(find ${1:-.} -type f -maxdepth 5 -print 2>/dev/null | fzf +m) && nvim "$file"
}
alias znv=zv



# dispatch notification on mac
function _notify() {
  osascript -e 'display notification "Process is done" with title "Terminal"'
}
alias notify=_notify
alias ntf=_notify


# view man page in vim
# function man() {
#   /usr/bin/man $* -P "col -b | nvim -Rc 'setl ft=man ts=8 nomod nolist nonu' -c 'nmap q :q<cr>' -"
# }


function rand() {
  echo $RANDOM > /dev/null
  rand=$(echo $RANDOM | md5sum | sed 's/[^a-zA-Z0-9]\{1,\}//g' | tr '[:upper:]' '[:lower:]')
  echo -n $RANDOM | md5sum | sed 's/[^a-zA-Z0-9]\{1,\}//g' | tr '[:upper:]' '[:lower:]'
}


# ------------------------------
# Aliases
# ------------------------------

alias x='exit'
alias cl='clear'
alias now='date "+%Y%m%d_%H%M%S"'
alias today='date "+%Y%m%d"'
alias td='today'
alias ls='COLUMNS=80 ls -G'
alias sl='ls'
alias v='nvim'
alias bim='nvim'
alias cim='nvim'
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gb='git branch'
alias nv='nvim'
alias tm='tmux'

alias pass="cat ${HOME}/.pass | fzf | cut -d ',' -f 4- | pbcopy"


# ------------------------------
# Plugins
# ------------------------------

eval "$(sheldon source)"


# ------------------------------
# Environment
# ------------------------------

export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export TERM=screen-256color

# gpg
export GPG_TTY=$(tty)

# fzf
# [ -f ~/.zsh/.fzf.zsh ] && source ~/.zsh/.fzf.zsh
# export FZF_DEFAULT_COMMAND='rg --files --hidden'


# ------------------------------
# General
# ------------------------------

# Prompt
# autoload -Uz colors; colors
# autoload -Uz vcs_info
# zstyle ':vcs_info:*' formats " %F{242}[%b]%f"
# zstyle ':vcs_info:*' actionformats " %F{242}[%b]%f %K{red}%F{black} %a %f%k"
# setopt PROMPT_SUBST
# precmd () { vcs_info }
# PROMPT='
# %F{blue}%~%f${vcs_info_msg_0_}
# %F{magenta}$%f '
PROMPT='
%F{blue}%~%f
%F{magenta}$%f '


# Misc
setopt auto_cd
setopt no_beep
export EDITOR=nvim
export OPENER=open
bindkey -v

