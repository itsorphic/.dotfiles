#!/bin/bash

# Constant variable of the scripts' working directory to use for relative paths.
SYSTEM_SCRIPT_DIRECTORY=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Import log functions and flags.
source "$SYSTEM_SCRIPT_DIRECTORY/logs.sh"
source "$SYSTEM_SCRIPT_DIRECTORY/strings.sh"
source "$SYSTEM_SCRIPT_DIRECTORY/../../core/flags.sh"

update_system() {

    # Constant variable for the world wide mirror.
    local WORLDWIDE_MIRROR='https://geo.mirror.pkgbuild.com/$repo/os/$arch'

    # Check if AUR package manager is installed or not.
    local use_aur_manager=1
    if [[ -n "${AUR_PACKAGE_MANAGER// /}" ]] && command -v "$AUR_PACKAGE_MANAGER" >/dev/null; then
        use_aur_manager=0
    fi

    # Reset mirrors to the worldwide one before updating/upgrading.
    if [[ "$INITIAL_SETUP" -eq 0 ]]; then
        log_info "Resetting mirrors to the worldwide one before updating/upgrading..."
        echo 'Server = '"$WORLDWIDE_MIRROR" | sudo tee /etc/pacman.d/mirrorlist >/dev/null
    fi

    # Upgrade package database format if needed.
    sudo pacman-db-upgrade

    # Update package databases
    if [[ "$use_aur_manager" -eq 0 ]]; then
        $AUR_PACKAGE_MANAGER -Sy
    else
        sudo $ARCH_PACKAGE_MANAGER -Sy
    fi

    # Check if any package is upgradable.
    upgradable_packages=""
    if [[ "$use_aur_manager" -eq 0 ]]; then
        upgradable_packages=$($AUR_PACKAGE_MANAGER -Qu) || true
    else
        upgradable_packages=$(sudo $ARCH_PACKAGE_MANAGER -Qu) || true
    fi

    # Check if 'archlinux-keyring' package is upgradable.
    upgradable_keyring=$(echo "$upgradable_packages" | grep archlinux-keyring) || true

    # Update 'archlinux-keyring' package if it needs an update.
    if [[ -n "$upgradable_keyring" ]]; then
        log_info "Updating archlinux-keyring..."
        sudo $ARCH_PACKAGE_MANAGER -S --noconfirm --needed archlinux-keyring
    fi

    # Update system if any package is upgradable.
    if [[ -n "$upgradable_packages" ]]; then
        log_info "Updating system..."

        # Update using the corresponding package manager.
        if [[ "$use_aur_manager" -eq 0 ]]; then
            $AUR_PACKAGE_MANAGER -Su --noconfirm
        else
            sudo $ARCH_PACKAGE_MANAGER -Su --noconfirm --needed
        fi
    fi

    # Check if any orphaned packages are available to remove.
    orphan_packages=$(sudo $ARCH_PACKAGE_MANAGER -Qtdq) || true
    if [[ -n "$orphan_packages" ]]; then
        log_info "Removing orphaned packages..."
        sudo $ARCH_PACKAGE_MANAGER -Rns $orphan_packages --noconfirm
    fi

    # Clean up the package and directory cache.
    log_info "Cleaning up package and directory cache..."
    sudo $ARCH_PACKAGE_MANAGER -Scc --noconfirm
    sudo rm -rf ~/.cache/*
}
