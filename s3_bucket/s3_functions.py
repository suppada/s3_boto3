#!/usr/bin/python3

import boto3
from botocore.retries import bucket

s3 = boto3.client('s3')
s3_resource = boto3.resource('s3')

bucketname = ''
Account_id = ''
file_name = ''

def create_bucket(bucket):
    try:
        response = s3.create_bucket(
            ACL='private',
            Bucket=(bucketname),
            CreateBucketConfiguration={
                'LocationConstraint': 'us-east-2'
        },
        ObjectLockEnabledForBucket=False
        )
    except Exception as e:
        print (e)
create_bucket(bucket)

def upload_file(bucket):
    try:
        with open((file_name), 'rb') as data:
            upload =  s3.upload_fileobj(data, (bucketname), (file_name))
            return upload
    except Exception as e:
        print (e)
upload_file(bucket)

def delete_obj(bucket):
    try:
        response = s3.delete_object(
            Bucket=(bucketname),
            Key=(file_name),
        )
        print(response)
    except Exception as e:
        print (e)
delete_obj(bucket)

def delete_bucket(bucket):
    try:
        response = s3.delete_bucket(
            Bucket=(bucketname),
            ExpectedBucketOwner=(Account_id)
        )
        print(response)
    except Exception as d:
        print (d)
delete_bucket(bucket)