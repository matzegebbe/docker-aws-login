#!/bin/bash

if [[ -z $1 || -z $2  || -z $3 ]]; then
 echo 'Usage entrypoint.sh $aws_access_key_id $aws_secret_access_key $region'
 echo "./entrypoint.sh 342342342 13209344545320 eu-west-1"
 exit 1;
fi

aws_access_key_id=$1
aws_secret_access_key=$2
region=$3

mkdir -p ~/.aws/
printf "[default]\nregion = ${region}\n" > ~/.aws/config
printf "[default]\naws_access_key_id = ${aws_access_key_id}\naws_secret_access_key = ${aws_secret_access_key}\n" > ~/.aws/credentials

aws ecr get-login
