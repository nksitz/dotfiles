#!/bin/bash
set -e

install_if_missing() {
  local name=$1
  local check=$2
  local install_cmd=$3

  if ! command -v "$check" &>/dev/null; then
    echo "Installing $name..."
    eval "$install_cmd"
    echo "$name installed successfully!"
  else
    echo "$name already installed, skipping..."
  fi
}

# Homebrew
## Fix, it doesn't work with piping bash
install_if_missing "Homebrew" "brew" \
  "curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash"

# Rust
install_if_missing "Rust" "rustup" \
  "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"

# zsh stuff
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# MacOS appearance
brew services start sketchybar
defaults write com.apple.dock autohide -bool true

# Install icons for sketchybar
## TODO: make it idempotent
cd /tmp
git clone https://github.com/kvndrsslr/sketchybar-app-font.git
cd sketchybar-app-font
npm install
npm run build:install $HOME/.config/sketchybar/plugins/front_app.sh
cd ~/.dotfiles

(git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)
