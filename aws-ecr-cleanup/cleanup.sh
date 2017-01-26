#!/bin/bash

if ! type jq &> /dev/null; then
    echo "please install jq"
    exit 1
fi

if [[ $# < 1 ]]; then
  echo "usage: $(basename $0) repo_name (use ./list_repos.sh)"
  exit 1
fi

REPONAME=$1

for i in $(aws ecr list-images --filter '{"tagStatus": "UNTAGGED"}' --repository-name $REPONAME | jq ".imageIds[]? .imageDigest" | tr -d '"'); do
   imageDigest="$imageDigest imageDigest=${i}"
done

imageDigest=( $imageDigest )

read -r -p "Are you sure to remove all untagged images? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
   if [ -n "$imageDigest" ]; then
     while [ "${#imageDigest[@]}" -gt 0 ]
     do
       aws ecr batch-delete-image --repository-name $REPONAME --image-ids ${imageDigest[@]:0:100}
       imageDigest=( ${imageDigest[@]:100} )
     done
   fi
else
 exit 1
fi

