#!/bin/bash

# Function to show SSH agent keys
show_agent_keys() {
    ssh-add -l
}
