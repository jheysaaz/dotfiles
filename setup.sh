#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.config/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
LINKS=(
  "fish:$HOME/.config/fish"
  "ghostty:$HOME/.config/ghostty"
  "nvim:$HOME/.config/nvim"
  "starship.toml:$HOME/.config/starship.toml"
)

link() {
  local src="$1"
  local dst="$2"

  if [ ! -e "$src" ] && [ ! -L "$src" ]; then
    echo "  [skip] source missing: $src"
    return 1
  fi

  if [ -L "$dst" ]; then
    local current
    current="$(readlink "$dst")"
    if [ "$current" = "$src" ]; then
      echo "  [ok]   $dst already points to $src"
      return 0
    fi
    echo "  [fix]  replacing symlink $dst -> $current"
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "  [back] backing up $dst -> $BACKUP_DIR/"
    mkdir -p "$BACKUP_DIR/$(dirname "$dst")"
    mv "$dst" "$BACKUP_DIR/$dst"
  fi

  ln -s "$src" "$dst"
  echo "  [link] $dst -> $src"
}

echo "==> Linking dotfiles into ~/.config"

for entry in "${LINKS[@]}"; do
  src="$DOTFILES/${entry%%:*}"
  dst="${entry##*:}"
  link "$src" "$dst"
done

echo ""
echo "==> Linking Ghostty (macOS legacy path)"

GHOSTTY_LIB="$HOME/Library/Application Support/com.mitchellh.ghostty"
if [ -d "$GHOSTTY_LIB" ]; then
  link "$DOTFILES/ghostty/config.ghostty" "$GHOSTTY_LIB/config.ghostty"
fi

echo ""
echo "==> Installing Homebrew packages"

if command -v brew &>/dev/null; then
  if [ -f "$DOTFILES/Brewfile" ]; then
    echo "  [run]  brew bundle"
    brew bundle --file="$DOTFILES/Brewfile" || echo "  [warn] some packages may already be installed" >&2
  fi
else
  echo "  [skip] brew not found"
fi

echo ""
echo "==> Installing fisher plugins"

if command -v fish &>/dev/null; then
  if fish -c "functions -q fisher" 2>/dev/null; then
    echo "  [ok]   fisher already installed"
  else
    echo "  [inst] installing fisher..."
    fish -c "
      curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
      and fisher install jorgebucaran/fisher
    " || {
      echo "  [err]  failed to install fisher" >&2
      exit 1
    }
  fi

  echo "  [run]  fisher update"
  fish -c "fisher update" || echo "  [warn] fisher update failed" >&2
else
  echo "  [skip] fish not found — install it first, then run: fisher update"
fi

echo ""
echo "Done."
