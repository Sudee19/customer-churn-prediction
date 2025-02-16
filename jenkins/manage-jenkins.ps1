param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('start','stop','restart')]
    [string]$Action
)

$composeFile = "../docker-compose.jenkins.yml"

switch ($Action) {
    "start" {
        Write-Host "Starting Jenkins..."
        docker-compose -f $composeFile up -d
    }
    "stop" {
        Write-Host "Stopping Jenkins..."
        docker-compose -f $composeFile down
    }
    "restart" {
        Write-Host "Restarting Jenkins..."
        docker-compose -f $composeFile down
        docker-compose -f $composeFile up -d
    }
}
