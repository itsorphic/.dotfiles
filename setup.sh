#!/bin/bash

HOME=/home/$USER/
DOTFILES=$HOME/.dotfiles
PACMAN_CONFIGURATION="/etc/pacman.conf"
PACCACHE_HOOK_FILE="/usr/share/libalpm/hooks/paccache.hook"

# Install paru package manager
echo "[+] Setting up Paru Package Manager"
cd /tmp/ && git git clone https://aur.archlinux.org/paru.git && cd /paru && makepkg -si
sudo rm /tmp/paru -rf

# Optimizing Mirror list with rate-mirrors
echo "[+] Optimizing Mirror List with rate-mirrors"
rate-mirrors --disable-comments-in-file --save mirrors.txt arch && cat mirrors.txt | head -n 5 | sudo tee /etc/pacman.d/mirrorlist && sudo rm mirrors.txt

# Configuring Pacman
echo "[+] Configuring Pacman Package Manager"
echo "[+] Enabling colors in terminal..."
sudo sed -i '/^#.*Color/s/^#//' $PACMAN_CONFIGURATION
echo "[+] Enabling parallel downloads..."
sudo sed -i '/^#.*ParallelDownloads/s/^#//' $PACMAN_CONFIGURATION

# Enable cache clearing after package installation.
if [ ! -f "$PACCACHE_HOOK_FILE" ]; then
	echo "[+] Enabling cache clearing after package installation, update, or removal..."
    echo "[Trigger]
Operation = Upgrade
Operation = Install
Operation = Remove
Type = Package
Target = *

[Action]
Description = Cleaning pacman cache …
When = PostTransaction
Exec = /usr/bin/paccache -r" | sudo tee "$PACCACHE_HOOK_FILE" >/dev/null
fi

# Install very important packages
echo "[+] Installing Very Important Packages"
sudo pacman -Syu --noconfirm bluez tmux alacritty zsh bluez-utils base-devel git curl wget man-db neovim lua luarocks luacheck python3 python-pip ttf-firacode-nerd fzf helix bat less exa fastfetch
paru -S --noconfirm brave-bin rate-mirrors-bin

# Setting up ZSH
echo "[+] Setting ZSH as default shell..."
sudo chsh -s $(which zsh) $USER

if ! ls ~/.oh-my-zsh ; then
	echo "[+] Installing Oh-My-Zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
	echo "[+] Oh-My-Zsh is already installed, skipping..."
fi

# Set up dotfiles
echo "[+] Setting up .dotfiles ..."
ln -sf $DOTFILES/sway/ $HOME/.config/


