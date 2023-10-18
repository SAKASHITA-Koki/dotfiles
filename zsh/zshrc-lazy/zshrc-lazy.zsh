# ------------------------------
# Inits
# ------------------------------

eval "$(rtx activate zsh)"
eval "$(zabrze init --bind-keys)"
eval "$(zoxide init zsh)"

# ------------------------------
# Options
# ------------------------------

setopt auto_cd
setopt no_beep

# ------------------------------
# Environments
# ------------------------------


export GPG_TTY=$(tty)
export EDITOR=nvim
export OPENER=open
export FZF_DEFAULT_OPTS="--cycle \
   --border=sharp \
   --height=45% \
   --info=inline \
   --layout=reverse "


# ------------------------------
# Functions
# ------------------------------


# fuzzy cd
function zd() {
  local dir
  dir=$(find ${1:-~} -type d -maxdepth 3 -print 2>/dev/null | fzf +m) && cd "$dir"
}
alias zdd='zd ~'
alias zdp='zd ~/Projects/'


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


# dispatch notification on mac
if [[ "${OSTYPE}" == "darwin"* ]]; then
  function _notify() {
    osascript -e 'display notification "Process is done" with title "Terminal"'
  }
  alias notify=_notify
  alias ntf=_notify
fi


# filter unnecessary history
zshaddhistory() {
    local line="${1%%$'\n'}"
    [[ ! "$line" =~ "^(cd|ls|exit|clear|nvim)($| )" ]]
}



# ------------------------------
# Aliases
# ------------------------------

alias tm='tmux'
alias cat='bat'
alias ls='exa'
alias find='fd'
alias grep='rg'
alias cd='z'
alias zz='zi'

alias pass="cat ${HOME}/.pass | fzf | cut -d ',' -f 4- | pbcopy"


# ------------------------------
# Variables
# ------------------------------

export mail='59007706+SAKASHITA-Koki@users.noreply.github.com'

