#!/bin/bash

HOME=/home/$USER/
DOTFILES=$HOME/.dotfiles

# Install very important packages
echo "[+] Installing Very Important Packages"
sudo pacman -Syu --noconfirm bluez tmux alacritty zsh bluez-utils base-devel git curl wget man-db neovim lua luarocks luacheck python3 python-pip ttf-firacode-nerd fzf helix bat less exa fastfetch
paru -S --noconfirm brave-bin rate-mirrors-bin

# Install paru package manager
echo "[+] Setting up Paru Package Manager"
cd /tmp/ && git git clone https://aur.archlinux.org/paru.git && cd /paru && makepkg -si
sudo rm /tmp/paru -rf

# Optimizing Mirror list with rate-mirrors
echo "[+] Optimizing Mirror List with rate-mirrors"
rate-mirrors --disable-comments-in-file --save mirrors.txt arch && cat mirrors.txt | head -n 5 | sudo tee /etc/pacman.d/mirrorlist && sudo rm mirrors.txt

# Setting up oh-my-zsh
if ! ls ~/.oh-my-zsh ; then
	echo "[+] Installing Oh-My-Zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
	echo "[+] Oh-My-Zsh is already installed, skipping..."
fi

# Set up dotfiles
echo "[+] Setting up .DOTFILES"
ln -sf $DOTFILES/sway/ $HOME/.config/
