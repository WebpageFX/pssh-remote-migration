# Specify the path to your pssh install
$psshPath = "$HOME\bin\pssh"

# Specify the path to your Git repository
$repositoryPath = "$HOME\.pssh"

Write-Host "repositoryPath: $repositoryPath"

# Specify the current remote name (e.g., origin) and the new remote URL
$currentRemoteName = "sync"
$newRemoteUrl = "git@github.com:WebpageFX/webpagefx-ssh-config.git"

Write-Host "currentRemoteName: $currentRemoteName"
Write-Host "newRemoteUrl: $newRemoteUrl"

# Check if pssh is installed
if (Test-Path -Path $psshPath) {
    # Change the remote URL
    Set-Location $repositoryPath

    # Verify if the repository exists
    if ((Test-Path -Path $repositoryPath) -and (Test-Path -Path ".git" -PathType Container)) {
        # Get the current remote URL
        $currentRemoteUrl = git remote get-url $currentRemoteName

        # Display the current and new remote URLs
        Write-Host "Current Remote URL: $currentRemoteUrl"
        Write-Host "New Remote URL: $newRemoteUrl"

        # Set the new remote URL
        git remote set-url $currentRemoteName $newRemoteUrl

        Write-Host "Remote URL changed successfully!"
		
		$updatedRemoteUrl = git remote get-url $currentRemoteName
		Write-Host "Updated Remote URL: $updatedRemoteUrl"
		
    } else {
        Write-Host "Error: Git repository not found at $repositoryPath"
    }
} else {
    Write-Host "Error: pssh is not installed."
}
