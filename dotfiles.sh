#!/sbin/bash

echo '---> Setting up i3'
ln -sf /home/$USER/.dotfiles/i3/ /home/$USER/.config/
echo '---> Setting up i3status'
ln -sf /home/$USER/.dotfiles/i3/i3status/ /home/$USER/.config/
echo '---> Setting up Alacritty'
ln -sf /home/$USER/.dotfiles/alacritty.toml /home/$USER/.config/
echo '---> Setting up tmux'
ln -sf /home/$USER/.dotfiles/.tmux.conf /home/$USER/
echo '---> Setting up .zshrc'
ln -sf /home/$USER/.dotfiles/.zshrc /home/$USER/
echo '---> Setting up .oh-my-zsh'
ln -sf /home/$USER/.dotfiles/.oh-my-zsh /home/$USER/
echo '---> Setting up picom'
ln -sf /home/$USER/.dotfiles/picom.conf /home/$USER/.config/
echo '---> Setting up neovim'
ln -sf /home/$USER/.dotfiles/nvim/ /home/$USER/.config/
