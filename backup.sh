#!/bin/sh
set -e

# Envirnoment variables
# DBHOST, DBPORT, DBNAME
# S3DEST
# AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_DEFAULT_REGION

DBHOST=${DBHOST:=localhost}
DBPORT=${DBPORT:=27017}

# Current time
TIME=`/bin/date +%d_%m_%Y_%H%M%S`

echo "Backing up $DBHOST/$DBNAME to $S3DEST on $TIME";

TMPDIR=`mktemp -d`
TAR=$TIME.tar

echo "Dumping database"
/usr/bin/mongodump -h $DBHOST -p $DBPORT -d $DBNAME -o $TMPDIR

# Create tar of backup directory
echo "Compressing"
/bin/tar cvf $TAR -C $TMPDIR .

# Upload tar to s3
echo "Uploading"
aws s3 cp $TAR $S3DEST

# Clean up
/bin/rm -f $TAR
/bin/rm -rf $TMPDIR

echo "Backup available at $S3DEST/$TIME.tar"
