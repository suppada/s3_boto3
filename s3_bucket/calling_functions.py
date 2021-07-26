#!/usr/bin/python3


from botocore.retries import bucket
from s3_functions import create_bucket, upload_file, delete_obj, delete_bucket


try:
    create_bucket(bucket)
    upload_file(bucket)
except Exception as e:
    print(e)

try:
    delete_obj(bucket)
    delete_bucket(bucket)
except Exception as d:
    print (d)