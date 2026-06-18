# Set environment variables
set -gx PNPM_HOME "$HOME/.local/share/pnpm"

# Homebrew (Apple Silicon)
if test -d /opt/homebrew
    eval (/opt/homebrew/bin/brew shellenv)
end

set -gx PATH "$HOME/.cargo/bin" \
	"$HOME/.deno/bin" \
	$PNPM_HOME \
	"$HOME/go/bin" \
    "$HOME/.local/bin" \
	$PATH

# Setup aliases
source (dirname (status --current-filename))/aliases.fish

# Ensure nvm_data is set (fallback for nvm.fish plugin)
set --query nvm_data || set --global nvm_data "$HOME/.local/share/nvm"

# Cursor shape: line always
set fish_cursor_default line
set fish_cursor_insert line
set fish_cursor_visual line

# Setup thefuck
thefuck --alias | source

# Setup starship
starship init fish | source
