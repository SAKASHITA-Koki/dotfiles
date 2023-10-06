export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
# export TERM=screen-256color
export TERM='xterm-256color'


export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# zsh
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# gnupg
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"

# rust (cargo)
export RUSTUP_HOME="${XDG_CONFIG_HOME}/rustup"
export CARGO_HOME="${XDG_CONFIG_HOME}/cargo"
. "${CARGO_HOME}/env"

# python
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc.py"

# terminfo
export TERMINFO="${XDG_DATA_HOME}/terminfo"

# less
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"

# navi
export NAVI_CONFIG="$XDG_CONFIG_HOME/navi/config.yaml"
