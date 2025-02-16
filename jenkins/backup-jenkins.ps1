param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('backup','restore')]
    [string]$Action
)

$backupDir = "jenkins-backup"
$containerName = "customerchurnprediction-jenkins-1"

if ($Action -eq "backup") {
    # Create backup directory if it doesn't exist
    if (-not (Test-Path $backupDir)) {
        New-Item -ItemType Directory -Path $backupDir
    }

    # Backup Jenkins configuration
    Write-Host "Backing up Jenkins configuration..."
    docker exec $containerName tar czf /tmp/jenkins-backup.tar.gz -C /var/jenkins_home .
    docker cp ${containerName}:/tmp/jenkins-backup.tar.gz $backupDir/

    Write-Host "Backup completed successfully to $backupDir/jenkins-backup.tar.gz"
}
elseif ($Action -eq "restore") {
    # Check if backup exists
    if (-not (Test-Path "$backupDir/jenkins-backup.tar.gz")) {
        Write-Error "Backup file not found at $backupDir/jenkins-backup.tar.gz"
        exit 1
    }

    # Copy backup file to container
    Write-Host "Restoring Jenkins configuration..."
    docker cp "$backupDir/jenkins-backup.tar.gz" ${containerName}:/tmp/
    docker exec $containerName tar xzf /tmp/jenkins-backup.tar.gz -C /var/jenkins_home

    Write-Host "Restore completed successfully"
    Write-Host "Restarting Jenkins container..."
    docker restart $containerName
}
