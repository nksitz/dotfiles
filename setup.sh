#!/bin/bash
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
stow -t ~ -d "$DOTFILES_DIR" "$@"
