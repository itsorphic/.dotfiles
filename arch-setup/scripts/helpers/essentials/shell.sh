#!/bin/bash

# Catch exit signal (CTRL + C), to terminate the whole script.
trap "exit" INT

# Terminate script on error.
set -e

# Constant variable of the scripts' working directory to use for relative paths.
SHELL_SCRIPT_DIRECTORY=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Import functions.
source "$SHELL_SCRIPT_DIRECTORY/../functions/packages.sh"
source "$SHELL_SCRIPT_DIRECTORY/../functions/filesystem.sh"

ZSH_SHELL="zsh"
ZSH_BINARY_DIRECTORY="/usr/bin/zsh"

# Install shell package.
install_packages "$FISH_SHELL" "$AUR_PACKAGE_MANAGER" "Installing shell..."

# STILL NEED TO COMPLETE THIS
#############################

# Set default shell.
current_shell=$(basename "$SHELL")
if [ "$current_shell" != "$ZSH_SHELL" ]; then
    log_info "Setting default shell..."
    grep -qxF "$ZSH_BINARY_DIRECTORY" /etc/shells || echo "$ZSH_BINARY_DIRECTORY" | sudo tee -a /etc/shells >/dev/null
    sudo chsh -s "$ZSH_BINARY_DIRECTORY" $USER
fi
