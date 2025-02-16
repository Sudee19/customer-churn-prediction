# Jenkins Setup for Customer Churn Prediction

This directory contains the Jenkins configuration for the Customer Churn Prediction project.

## Quick Start

1. Start Jenkins:
```powershell
.\manage-jenkins.ps1 -Action start
```

2. Access Jenkins at http://localhost:8081

## Managing Jenkins

### Starting and Stopping
- Start Jenkins: `.\manage-jenkins.ps1 -Action start`
- Stop Jenkins: `.\manage-jenkins.ps1 -Action stop`
- Restart Jenkins: `.\manage-jenkins.ps1 -Action restart`

### Backup and Restore
- Create backup: `.\backup-jenkins.ps1 -Action backup`
- Restore from backup: `.\backup-jenkins.ps1 -Action restore`

## Pipeline Configuration

The Jenkins pipeline is configured in the root `Jenkinsfile` and includes:
- Building the application
- Running tests
- Building and tagging Docker images

## Important Notes

1. Jenkins data is persisted in a Docker volume named `jenkins_home`
2. The initial admin password can be retrieved using:
   ```powershell
   docker-compose -f ../docker-compose.jenkins.yml exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
   ```
3. Make sure to backup regularly using the provided backup script
