# arch-setup - Ansible Playbook for ArchLinux Configuration

## Install a Base System
Install a minimal ArchLinux base system before using this playbook. Make sure you have `git` and `ansible` installed.

## How To Run the Playbook
After the initial minimal Arch installation:
```bash
git clone https://github.com/itsorphic/.dotfiles.git
cd arch-setup
vim group_vars/all # Edit the variables as you please
ansible-playbook -i inventory/localhost playbook.yml
# OR, if you want to run any specific part of the playbook:
ansible-playbook -i inventory/localhost playbook.yml [--tags $LIMIT_TO_TAG]
```

Available tags:
- `essentials` - Set up core packages, utilities, and optimize your terminal experience.
- `interface` - Streamline the installation of GPU drivers and display managers.
- `desktop` - Set up your desktop with essential applications.
- `development` - Elevate your coding environment with tools and programming languages.
- `hacking` - Set up the most important tools for hacking/pentesting and bug bounty.
- `security` - Strengthen your installation with best security practices.

## WARNING !
I won't be responsible if you break your system by using this playbook.
If such happens, then, Try Harder. ;)
