# Docker image for mongo backup to s3

Just run this image as so:

```shell
  docker run --rm \
  -e DBHOST=localhost \
  -e DBPORT=27017
  -e DBNAME=my-db
  -e S3DEST=s3://my-bucket/folder
# AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_DEFAULT_REGION

  fixate/mongodb-s3-backup
```
