packages=(
    # Zsh
	'zsh-autosuggestions'
	'zsh-syntax-highlighting'
	'starship'
	'bat'
	'stow'
	'ruff'
	'tree'
	'fzf'
	'fd'
	'tmux'

    # Neovim and dependencies
	'lua'
	'luarocks'

    # Other
	'wget'
	'lazygit'
)

# Install with Homebrew
for package in "${packages[@]}"; do
    brew install $package
done