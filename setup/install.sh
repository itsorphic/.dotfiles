#!/bin/bash

# Catch exit signal (CTRL + C) to terminate the whole script.
trap "exit" INT

# Terminate script on error.
set -e

# Constant variable of the scripts' working directory to use for relative paths.
INSTALL_SCRIPT_DIRECTORY=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Constant variable for the flags script path.
FLAGS_SCRIPT_PATH="$INSTALL_SCRIPT_DIRECTORY/scripts/core/flags.sh"
CONSTANTS_SCRIPT_PATH="$INSTALL_SCRIPT_DIRECTORY/scripts/core/constants.sh"

# Scripts to run containing their completion flag, initial setup value and optional message, splitted by "|".
declare -A SCRIPTS=(
    ["essentials"]="ESSENTIALS_COMPLETED|1"
    ["interface"]="INTERFACE_COMPLETED|1|Would you like to set up the graphical login interface?"
    ["desktop"]="DESKTOP_COMPLETED|1|Would you like to set up the desktop environment?"
    ["development"]="DEVELOPMENT_COMPLETED|1|Would you like to set up the development environment?"
    ["security"]="SECURITY_COMPLETED|1"
)

declare -a ORDERED_SCRIPTS=("essentials" "interface" "desktop" "development" "security")

# Import functions and flags.
source "$INSTALL_SCRIPT_DIRECTORY/scripts/helpers/functions/ui.sh"
source "$INSTALL_SCRIPT_DIRECTORY/scripts/helpers/functions/system.sh"

update_system

# Iterate over the scripts and execute them accordingly.
for script in "${ORDERED_SCRIPTS[@]}"; do

	IFS="|" read -ra script_info <<<"${SCRIPTS[$script]}"
	completion_flag="${script_info[0]}"
	message="${script_info[2]}"

		if [[ "$message" ]]; then

            		# Ask user for approval before executing script and change the flag value accordingly.
            		user_answer=$(ask_user_before_execution "$message" "false" "$INSTALL_SCRIPT_DIRECTORY/scripts/utilities/$script.sh")
            		if [[ "$user_answer" == "y" ]]; then
                		user_choice=0
            		elif [[ "$user_answer" == "n" ]]; then
                		user_choice=1
            		fi
        	else
        		log_info "Executing $script script..."
        		sh "$INSTALL_SCRIPT_DIRECTORY/scripts/utilities/$script.sh"
        		log_success "${script^} script execution finished!"
        		user_choice=0
        	fi
        # Check if the user executed the script before marking as complete and reboot.
        if [[ "$user_choice" -eq 0 ]]; then

            # Set completion flag to 0 (true) if it's "desktop" or "development".
            [[ "$script" == "desktop" || "$script" == "development" ]] && change_flag_value "$completion_flag" 0 "$FLAGS_SCRIPT_PATH"

            # Reboot system for the rest of the scripts.
            if [[ "$script" == "essentials" || "$script" == "interface" ]]; then

                # Before rebooting, if the script is the first one the "essentials" one, change the INITIAL_SETUP flag to 1 (false).
                [[ "$script" == "essentials" ]] && change_flag_value "INITIAL_SETUP" 1 "$FLAGS_SCRIPT_PATH"

                # Change the completion flag value to 0 (true).
                change_flag_value "$completion_flag" 0 "$FLAGS_SCRIPT_PATH"
            elif [ "$script" == "security" ]; then
                log_success "Installation procedure finished!"
                log_success "Your system is ready to use!"

                # Do not log the rerun warning.
                reboot_system "${!completion_flag}" "$completion_flag" 1
            fi
        fi
done
