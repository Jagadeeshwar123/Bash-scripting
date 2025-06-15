#!/bin/bash

#######################################################################################
# This script lists all AWS resources in the current account and region.
# author: Jagadeeshwar Reddy
# following are the list of supported aws resources by this script
# ec2, rds, s3, dynamodb, lambda, sns, sqs, elb, vpc, iam, cloudwatch
# Usage: ./aws_resource_list.sh <region> <servicename>
#example: ./aws_resource_list.sh us-east-1 ec2
#######################################################################################

#check if the required arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <region> <servicename>"
    exit 1
fi

#check if the aws cli is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it and try again."
    exit 1
fi

#check if the aws cli is configured
if ! aws sts get-caller-identity &> /dev/null; then
    echo "AWS CLI is not configured. Please configure it and try again."
    exit 1
fi

#execute the aws cli command based on the service name
case "$2" in
    ec2)
        aws ec2 describe-instances --region "$1" --query 'Reservations[*].Instances[*].[InstanceId,State.Name,PublicIpAddress,PrivateIpAddress,InstanceType,LaunchTime]' --output table
        ;;
    rds)
        aws rds describe-db-instances --region "$1" --query 'DBInstances[*].[DBInstanceIdentifier,DBInstanceStatus,Endpoint.Address,DBInstanceClass,Engine,MasterUsername]' --output table
        ;;
    s3)
        aws s3 ls --region "$1"
        ;;
    dynamodb)
        aws dynamodb list-tables --region "$1" --output table
        ;;
    lambda)
        aws lambda list-functions --region "$1" --query 'Functions[*].[FunctionName,Runtime,LastModified]' --output table
        ;;
    sns)
        aws sns list-topics --region "$1" --output table
        ;;
    sqs)
        aws sqs list-queues --region "$1" --output table
        ;;
    elb)
        aws elbv2 describe-load-balancers --region "$1" --query 'LoadBalancers[*].[LoadBalancerName,DNSName,State.Code]' --output table
        ;;
    vpc)
        aws ec2 describe-vpcs --region "$1" --query 'Vpcs[*].[VpcId,CidrBlock,State]' --output table
        ;;
    iam)
        aws iam list-users --query 'Users[*].[UserName,CreateDate]' --output table
        ;;
    cloudwatch)
        aws cloudwatch list-metrics --region "$1" --output table
        ;;
    *)
        echo "Unsupported service: $2"
        exit 1
        ;;
esac
