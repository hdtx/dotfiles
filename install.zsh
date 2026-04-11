# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> /Users/hdtx/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> /Users/hdtx/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# KiTTY
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
kitten themes --reload-in=all duckbones

# JetBrains Mono
brew install font-jetbrains-mono-nerd-font

cat >> ~/.config/kitty/kitty.conf << EOF
font_family      family="JetBrainsMono Nerd Font Mono"
bold_font        auto
italic_font      auto
bold_italic_font auto
EOF

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
cargo binstall --no-confirm eza
cargo binstall --no-confirm ripgrep
cargo binstall --no-confirm bat
cargo binstall --no-confirm fd-find

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/fzf
~/.local/fzf/install --no-bash --no-fish --update-rc --key-bindings --completion

# GitHub CLI
brew install gh
# VS Code
brew install --cask visual-studio-code

# Git configs
git config --global core.editor "code --wait"
git config --global user.name "Henrique Daitx"
git config --global user.email "henrique.daitx@gmail.com"