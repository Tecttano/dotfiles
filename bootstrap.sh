#!/bin/bash

echo "[*] Starting bootstrap setup..."

# Update system
sudo apt update && sudo apt upgrade -y

# Core packages
sudo apt install -y zsh git curl wget tmux fzf eza bat fastfetch build-essential unzip

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "[*] Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Zsh plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions 2>/dev/null
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting 2>/dev/null

# Link dotfiles
echo "[*] Linking dotfiles..."
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# Tools folder
mkdir -p ~/tools
cd ~/tools

# Clone useful tools (Potentially)
#git clone https://github.com/danielmiessler/SecLists.git 2>/dev/null
#git clone https://github.com/carlospolop/PEASS-ng.git 2>/dev/null

# Scripts folder
mkdir -p ~/scripts
chmod +x ~/scripts/*.sh 2>/dev/null

# Shell identity
chsh -s $(which zsh)

echo "[*] Bootstrap complete. Run 'source ~/.zshrc' or restart your shell."
