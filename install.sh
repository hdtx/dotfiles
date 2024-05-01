#!/usr/bin/env bash

cd
# install packages
sudo apt install -y git tmux make curl gcc
# liquidprompt
git clone --branch stable https://github.com/nojhan/liquidprompt.git ~/liquidprompt
# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-zsh --no-fish --no-update-rc --key-bindings --completion
# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source ~/.cargo/env
# binstall
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
# utilities
cargo binstall --no-confirm eza
cargo binstall --no-confirm ripgrep
cargo binstall --no-confirm bat
cargo binstall --no-confirm fd-find

# kitty #########################################################################################################################################
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
# Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is in
# your system-wide PATH)
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
sudo cp ~/.local/kitty.app/share/applications/kitty.desktop /usr/share/applications/
# Update the paths to the kitty and its icon in the kitty desktop file(s)
sudo sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" /usr/share/applications/kitty*.desktop
sudo sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" /usr/share/applications/kitty*.desktop
# Use JetBrains Mono
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/v3.2.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d nerd-fonts
sudo mv nerd-fonts/*.ttf /usr/share/fonts/opentype/
fc-cache -fv
rm -rf nerd-fonts
rm JetBrainsMono.zip
# Use my config
ln -fs ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf

# neovim #######################################################################################################################################
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo tar -C .local -xzf nvim-linux64.tar.gz
# lazyvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
rm nvim-linux64.tar.gz
echo "please run :LazyHealth after starting nvim"

# rc file
echo "source ~/dotfiles/.mybashrc" >>.bashrc
