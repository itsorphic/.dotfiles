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
