#!/bin/bash

if ! type jq &> /dev/null; then
    echo "please install jq"
    exit 1
fi

aws ecr describe-repositories | jq ".repositories[]? .repositoryName"
