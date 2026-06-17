#!/usr/bin/env bash
set -euo pipefail

install_packages() {
  if ! command -v sudo >/dev/null 2>&1 || ! sudo -n true 2>/dev/null; then
    echo "sudo is unavailable; skipping system package installation."
    return
  fi

  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y zsh git vim curl ripgrep
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y zsh git vim curl ripgrep
  elif command -v brew >/dev/null 2>&1; then
    brew install zsh git vim curl ripgrep
  else
    echo "Install zsh, git, vim, curl, and ripgrep with this system's package manager."
  fi
}

require_commands() {
  local missing=()

  for command_name in "$@"; do
    if ! command -v "$command_name" >/dev/null 2>&1; then
      missing+=("$command_name")
    fi
  done

  if ((${#missing[@]})); then
    echo "Missing required commands: ${missing[*]}" >&2
    echo "Install them with your system package manager or ask an administrator." >&2
    exit 1
  fi
}

clone_if_missing() {
  local repo="$1"
  local dest="$2"

  if [[ ! -d "$dest/.git" ]]; then
    git clone --depth=1 "$repo" "$dest"
  fi
}

install_packages
require_commands zsh git vim curl

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

clone_if_missing https://github.com/romkatv/powerlevel10k.git \
  "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions.git \
  "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/MichaelAquilina/zsh-you-should-use.git \
  "$HOME/.oh-my-zsh/custom/plugins/you-should-use"

if [[ ! -d "$HOME/.nvm" ]]; then
  git clone https://github.com/nvm-sh/nvm.git "$HOME/.nvm"
  git -C "$HOME/.nvm" checkout "$(git -C "$HOME/.nvm" describe --abbrev=0 --tags)"
fi

mkdir -p "$HOME/.vim/autoload"
if [[ ! -f "$HOME/.vim/autoload/plug.vim" ]]; then
  curl -fLo "$HOME/.vim/autoload/plug.vim" \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +'PlugInstall --sync' +qa

if [[ "$SHELL" != */zsh ]] && command -v chsh >/dev/null 2>&1; then
  chsh -s "$(command -v zsh)"
fi
