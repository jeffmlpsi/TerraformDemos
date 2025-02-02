#!/bin/bash

terraform destroy -auto-approve
source "./clean-tf.sh"
docker network rm my_network