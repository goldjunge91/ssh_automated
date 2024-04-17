#!/bin/bash

# Function to connect to a device and set up key-based authentication
setup_ssh_key_on_device() {
    echo -n "Enter the remote device's username@hostname (e.g., user@192.168.1.1): "
    read remote_device
    echo "Select a key from your list to use for remote login:"
    list_keys
    echo -n "Enter the key name to use: "
    read selected_key
    if [[ -f "$KEY_DIR/$selected_key.pub" ]]; then
        cat "$KEY_DIR/$selected_key.pub" | ssh "$remote_device" 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
        echo "Public key has been added to $remote_device"
    else
        echo "Key does not exist. Please check the key name and try again."
    fi
}
