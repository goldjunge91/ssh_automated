#!/bin/bash

# Source other scripts
source ssh_key_operations.sh
source ssh_agent_operations.sh
source remote_ssh_setup.sh

# Main menu
PS3='Please enter your choice: '
options=("List SSH Keys" "Create New SSH Key" "Show SSH Agent Keys" "Setup SSH Key on Remote Device" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "List SSH Keys")
            list_keys
            ;;
        "Create New SSH Key")
            create_key
            ;;
        "Show SSH Agent Keys")
            show_agent_keys
            ;;
        "Setup SSH Key on Remote Device")
            setup_ssh_key_on_device
            ;;
        "Quit")
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done