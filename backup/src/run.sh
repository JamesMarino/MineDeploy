#!/usr/bin/env ash

backupDate=$(date +%s)
remoteBackupAddress="s3://${S3_BUCKET_NAME}/${INSTANCE_NAME}/backup-${backupDate}.zip"
localBackupAddress=/root/backup.zip

echo "Backing up using Namespace '${INSTANCE_NAME}'"
zip -r ${localBackupAddress} /data

echo "Copying to S3 Bucket '${S3_BUCKET_NAME}'"
aws s3 cp ${localBackupAddress} ${remoteBackupAddress}
echo "Backup Address is: '${remoteBackupAddress}'"
