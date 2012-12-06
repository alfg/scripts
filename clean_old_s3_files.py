#!/usr/bin/env python

""" clean_old_s3_files.py - Purges old objects stored in S3 based on last_modified date

Author: Alfred Gutierrez (alfg.co)

Requires: boto

Usage: Configure Date, AWS and Bucket variables below. Then run as 'python clean_old_s3_files.py'

Disclaimer: Use at your own risk. I wrote this in 10 minutes.

"""

import boto
import datetime

YEAR, MONTH, DAY = 2012, 10, 31 
AWS_KEY, AWS_SECRET = 'accesskey', 'secretkey'
BUCKET = 'bucketname'

conn = boto.connect_s3(AWS_KEY, AWS_SECRET)

rs = conn.get_all_buckets()
b = conn.get_bucket(BUCKET)

for item in b:
    if item.last_modified < datetime.date(YEAR, MONTH, DAY).isoformat():
        print "Deleting ", item.name
        item.delete()
print "No remaining files to delete"
