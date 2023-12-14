#!/bin/bash

# loggedInUser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
loggedInUser=$(/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }')

echo "loggedInUser: $loggedInUser"

# Specify the path to your Git repository
repositoryPath="/Users/$loggedInUser/.pssh"

echo "repositoryPath: $repositoryPath"

# Specify the current remote name (e.g., origin) and the new remote URL
currentRemoteName="sync"
newRemoteUrl="git@github.com:WebpageFX/webpagefx-ssh-config.git"

echo "currentRemoteName: $currentRemoteName"
echo "newRemoteUrl: $newRemoteUrl"

# Check if Git is installed
if command -v pssh >/dev/null 2>&1; then
    # Change the remote URL
    cd "$repositoryPath" || exit

    # Set the git repo as a safe directory
    git config --global --add safe.directory "$repositoryPath"

    # Verify that the git repo was added
    safe_directory=$(git config --global --get safe.directory)
    echo "Safe Directory: $safe_directory"

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

        # Remove the git repo as a safe directory
        git config --global --unset safe.directory "$repositoryPath"

        # Verify that the git repo was removed
        safe_directory=$(git config --global --get safe.directory)
        echo "Safe Directory: $safe_directory"
    else
        echo "Error: Git repository not found at $repositoryPath"
    fi
else
    echo "Error: pssh is not installed."
fi
