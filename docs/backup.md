# Backup Retrieval Instructions

Buckets are public and backups are in the format of `instanceName/instanceName-unixTimeStamp`.

They can be accessed through the following example.

```bash
s3BucketName="myBucketName"
instanceName="myInstanceName"

# List Bucket Contents
aws s3 ls ${myBucketName}/${instanceName}/ --no-sign-request

# Download file via HTTP
curl "https://${myBucketName}/${instanceName}/${instanceName}-1559912573.zip"
```
