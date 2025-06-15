#!/bin/bash


# list of s3 buckets

echo "list of s3 buckets"
aws s3 ls

# list of ec2 instances

echo "list of ec2 instances"
aws ec2 describe-instances

# list of lambda functions

echo "list of lambda functions"
aws lambda list-functions

# list of iam users

echo "list of iam users"
aws iam list-users
