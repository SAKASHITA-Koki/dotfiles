#!/usr/bin/env bash


set -u


source './zsh/.zshenv'


function check_pkg_manager() {
  if command -v brew >/dev/null 2>&1; then
    echo -e "$(brew --version) found"
  elif command -v apt >/dev/null 2>&1; then
    echo -e "$(apt --version) found"
  else
    echo -e \
      "No supported package manager found." \
      "Please install apt or brew."
    exit 1
  fi
}


function _install() {
  if ! command -v "${2:-$1}" >/dev/null 2>&1; then
    if command -v brew >/dev/null 2>&1; then
      brew install $1
    elif command -v apt >/dev/null 2>&1; then
      apt install -y $1
    fi
    echo -e "${1} installed"
  fi
}


function install_curl() {
  _install curl
}


function install_git() {
  _install git
}


function install_nvim() {
  _install neovim nvim
}


function install_fzf() {
  _install fzf
}


function install_rust() {
  if ! command -v rustup >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "${CARGO_HOME:-"${HOME}/.cargo"}/env"
    rustup self update
    rustup update
    echo -e "rustup, rustc, cargo installed"
  fi
}


function install_starship() {
  if ! command -v starship >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf "https://starship.rs/install.sh" \
    | sh -s -- -y
    echo -e "starship installed"
  fi
}


function _cargo_install() {
  if ! command -v "${2:-$1}" >/dev/null 2>&1; then
    if ! command -v cargo >/dev/null 2>&1; then
      install_rust
    fi
    cargo install $1
    echo -e "${1:-$2} installed"
  fi
}


function install_sheldon() {
  _cargo_install sheldon
}


function install_bat() {
  _cargo_install bat
}

function install_exa() {
  _cargo_install exa
}

function install_fd() {
  _cargo_install fd-find "fd"
}

function install_rg() {
  _cargo_install ripgrep "rg"
}



function install_rtx_cli() {
  _cargo_install rtx-cli "rtx"
}

function install_node() {
  if [ ! "$(rtx ls | grep 'node')" ]; then
    rtx install node@lts
    rtx global node@lts
  fi
}

function install_deno() {
  if [ ! "$(rtx ls | grep 'deno')" ]; then
    rtx install deno@latest
    rtx global deno@latest
  fi
}

function install_python() {
  if [ ! "$(rtx ls | grep 'python')" ]; then
    rtx install python@latest
    rtx global python@latest
  fi
}


# ------------------------------


function setup() {
  check_pkg_manager
  install_curl
  install_git
  install_nvim
  install_fzf
  install_rust
  install_starship
  install_sheldon
  install_rtx_cli
  install_node
  install_deno
  install_python
}


function create_links() {
  local DOTFILES="$(cd "$(dirname $0)" || exit 1; pwd)"
  local backup="${DOTFILES}/backup/$(date +%Y%m%d%H%M%S)"

  if [ ! -d $backup ]; then
    mkdir -p "$backup"
  fi

  local link_map="${DOTFILES}/link_map.csv"
  if [ ! -f "${link_map}" ]; then
    echo -e "${link_map} not found"
    exit 1
  fi
  if [[ "${HOME}" == "${DOTFILES}" ]]; then
    echo -e \
      "dotfiles directory cannot be the same" \
      "as your home directory."
    exit 1
  fi

  cat "${link_map}" |
  while read src_to_dest; do
    local raw_src=$(echo "${src_to_dest}" | awk -F ',' '{ print $1 }')
    local raw_dest=$(echo "${src_to_dest}" | awk -F ',' '{ print $2 }')

    local link_src="$(eval "echo ${raw_src}")"
    local link_dest="$(eval "echo ${raw_dest}")"

    if [[ -z "$link_src" || -z "$link_dest" ]]; then
      continue
    fi

    local link_dest_dir="$(dirname "${link_dest}")"
    if [[ ! -d "${link_dest_dir}" ]]; then
      mkdir -p "${link_dest_dir}"
    fi

    if [[ -L "${link_dest}" ]]; then
      rm -f "${link_dest}"
    fi

    if [[ -e "${link_dest}" ]]; then
      local backup_path="${backup}/$(echo "${link_dest}" | sed 's/^\/\{1,\}//')"

      mkdir -p "$(dirname $backup_path)"
      mv "${link_dest}" "${backup_path}"
    fi

    ln -snf "${link_src}" "${link_dest}"
  done

  rm -d "${backup}" 2>/dev/null
}


function main() {
  while [ $# -gt 0 ]; do
    case ${1} in
      --debug | -d)
        set -uex
        ;;
      --help | -h)
        echo -e "usage"
        exit 1
        ;;
      --link | -l)
        create_links
        exit 0
        ;;
    esac
    shift
  done

  setup
  create_links
}


main "$@"
