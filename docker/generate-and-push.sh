#!/bin/bash

image_name=$1
region=$2

if [ -z "$image_name" ]; then
    echo "Missing image name. Cannot proceed to generate and push image."
    echo "Operation ended unsuccessfully"
    exit 0
fi
if [ -z "$region" ]; then
    echo "Missing ECR region. Cannot proceed to generate and push image."
    echo "Operation ended unsuccessfully"
    exit 0
fi

echo "## Check if AWS account is logged... ##"
account_id=$(aws sts get-caller-identity --query Account --output text)

if ! [[ $account_id =~ ^[0-9]+$ ]] ; then
   echo "User not logged. Provide to connect to AWS with command 'aws configure ...'"; 
   echo "Operation ended unsuccessfully"
   exit 0
fi

echo "## User correctly logged. Proceed with the operation ##"
ecr_url="${account_id}.dkr.ecr.${region}.amazonaws.com"
final_image_url="${ecr_url}/${image_name}"

echo "## Authenticating to ECR with logged account id... ##"
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${ecr_url}

echo "## Start building a Docker image for the lambda function with name ${image_name}... ##"
cd ..
docker build . -t $image_name
docker tag $image_name $final_image_url

echo "## Start pushing the final Docker image to ECR. URL: ${final_image_url}... ##"
docker push $final_image_url
echo "## Operation ended ##"