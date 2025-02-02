#!/bin/bash

#To create
docker image ls | grep pure_image > /dev/null

if [ $? -ne 0 ]; then
    echo "building docker image"
    docker build -t pure_image:latest .
    if [ $? -ne 0 ]; then
        echo "Error Building Docker Image"
        exit 1
    fi
else 
    echo "docker image already exists"
fi

#read -pr "Press enter to continue to check Docker Network"

docker network ls | grep my_network
if [ $? -eq 0 ]; then
    echo "deleting docker network my_network"
    docker network rm my_network
fi

echo "creating docker network"
docker network create my_network
if [ $? -ne 0 ]; then
    echo "Error Creating Docker Network"
    exit 1
fi

#read -pr "Press enter to continue to Terraform"

# if we do not see file terraform,tfstate, will assume
# terraform init has to be run 
if [ ! -f "./terraform.tfstate" ]; then
    terraform init
fi

terraform plan

terraform apply -auto-approve

# shellcheck disable=SC2034
for i in {1..5}
do
    curl http://localhost:8000
done