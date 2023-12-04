#!/bin/bash

# Specify the path to your Git repository
repositoryPath="$HOME/.pssh"

# Specify the current remote name (e.g., origin) and the new remote URL
currentRemoteName="sync"
newRemoteUrl="git@github.com:WebpageFX/webpagefx-ssh-config.git"

# Check if Git is installed
if command -v pssh > /dev/null 2>&1; then
    # Change the remote URL
    cd "$repositoryPath" || exit

    # Verify if the repository exists
    if [ -d ".git" ]; then
        # Get the current remote URL
        currentRemoteUrl=$(git remote get-url "$currentRemoteName")

        # Display the current and new remote URLs
        echo "Current Remote URL: $currentRemoteUrl"
        echo "New Remote URL: $newRemoteUrl"

        # Set the new remote URL
        git remote set-url "$currentRemoteName" "$newRemoteUrl"

        echo "Remote URL changed successfully!"
    else
        echo "Error: Git repository not found at $repositoryPath"
    fi
else
    echo "Error: pssh is not installed."
fi