#!/usr/bin/env bash
set -e

# Directory where your dotfiles live (the folder containing stow packages)
DOTFILES_DIR="$HOME/dotfiles"

# Packages to stow (or detect folders automatically)
PACKAGES=("$@")

# If no args passed, auto-detect packages (folders)
if [ ${#PACKAGES[@]} -eq 0 ]; then
  PACKAGES=($(find "$DOTFILES_DIR" -maxdepth 1 -mindepth 1 -type d ! -name ".*" -printf "%f\n"))
fi

echo "Using dotfiles directory: $DOTFILES_DIR"
echo "Packages to stow: ${PACKAGES[*]}"

# -------------------------------------------------------
# 1. Check if stow is installed
# -------------------------------------------------------

if ! command -v stow >/dev/null 2>&1; then
  echo "stow not found. Installing with pacman..."
  sudo pacman -S --needed --noconfirm stow
else
  echo "stow is already installed."
fi

# -------------------------------------------------------
# 2. Run stow on each package
# -------------------------------------------------------

cd "$DOTFILES_DIR"

for pkg in "${PACKAGES[@]}"; do
  echo "Stowing: $pkg"
  stow -v "$pkg"
done

echo "🎉 All dotfiles stowed successfully!"
