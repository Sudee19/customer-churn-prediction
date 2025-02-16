#!/bin/bash

# Create backup directory if it doesn't exist
BACKUP_DIR="./backups/$(date +%Y-%m-%d)"
mkdir -p $BACKUP_DIR

# Backup DAGs
cp -r ./dags $BACKUP_DIR/dags_backup

# Backup database (assuming MySQL)
mysqldump -h localhost -u root -p customer_churn > $BACKUP_DIR/database_backup.sql

# Backup model files
cp ./ChurnClassifier.keras $BACKUP_DIR/
cp ./customer_churn_classifier.pkl $BACKUP_DIR/

# Create a compressed archive
tar -czf $BACKUP_DIR.tar.gz $BACKUP_DIR

# Remove the uncompressed backup directory
rm -rf $BACKUP_DIR

echo "Backup completed successfully at $(date)"
