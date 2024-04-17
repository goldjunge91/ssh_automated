#!/bin/bash

# Directory to store SSH keys
KEY_DIR="$HOME/.ssh_custom_keys"
KEY_DIR_STD="$HOME/.ssh"
mkdir -p "$KEY_DIR"

# Function to list all keys
# List available SSH keys
list_keys() {

    # Standard key directory
    local key_dir_std="$HOME/.ssh"
    # Custom key directory
    local key_dir_custom="$HOME/.ssh2"
    # Check if standard directory exists
    if [ -d "$key_dir_std" ]; then
        echo "SSH Keys in $key_dir_std:"
        # Loop through private key files
        local private_keys=$(ls "$key_dir_std" | grep -v *.pub)
        for private_key in $private_keys; do
            echo "  $private_key"
        done
    # Notify if no private keys found
    else
        echo "No private keys in $key_dir_std"
    fi
    # Check if custom directory exists
    if [ -d "$key_dir_custom" ]; then

        echo "SSH Keys in $key_dir_custom:"

        # Loop through private key files
        local private_keys=$(ls "$key_dir_custom" | grep -v *.pub)
        for private_key in $private_keys; do
            echo "  $private_key"
        done

    # Notify if no private keys found
    else
        echo "No private keys in $key_dir_custom"
    fi
    # List keys loaded in SSH agent
    echo "Keys loaded in SSH Agent:"
    ssh-add -L
}

list_keys() {
    local found_key=false
    for key_dir in "$KEY_DIR_STD" "$KEY_DIR"; do
        found_key=false
        if [ -d "$key_dir" ]; then
            echo "SSH Keys in $key_dir:"
            local key_list=$(ls "$key_dir")
            for key_file in $key_list; do
                if [[ "$key_file" != *.pub ]]; then
                    echo "  $key_file"
                    found_key=true
                fi
            done
            # Check if no private keys were found in the current directory
            if [ "$found_key" = false ]; then
                echo "  No private keys found in $key_dir."
            fi
        else
            echo "Directory $key_dir does not exist."
        fi
    done
    echo "Keys loaded in SSH Agent:"
    ssh-add -l | cut -d ' ' -f 3 # Showing only the key file names, adjust if needed
}

# Function to create a new key
create_key() {
    echo -n "Enter the key name (default id_rsa): "
    read key_name
    key_name=${key_name:-id_rsa}
    echo -n "Enter your email address: "
    read email
    ssh-keygen -t rsa -b 4096 -C "$email" -f "$KEY_DIR/$key_name"
    echo "New key generated and stored as $KEY_DIR/$key_name"
}
