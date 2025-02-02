This is a combination os demo3, which does not work - see below,
and an idea from https://blog.purestorage.com/purely-educational/how-to-deploy-a-docker-image-with-terraform/ - to prebuild the docker image

In Demo3, the Docker terraform provider cannot build (apply) the web image with Python , with error - 
    failed to read downloaded context: failed to load cache key

This error is described in stack overflow in: 

https://stackoverflow.com/questions/79267868/docker-image-build-fails-in-terraform-failed-to-read-downloaded-context-faile

It looks like terraform-provider-docker doesn't work with the new docker versions. 

The page further says:
I got it to work by downgrading to Docker Desktop 4.31.0, Docker Engine 26.1.4.

Downgrading to Docker Desktop 4.31.0 and DOcker Enging 26.1.4 (packaged together)
in the downlaod - DID NOT WORK FOR ME.

---------------------

So demo4 builds the image with python and flask first. It than access the existing image using  - data "docker_image ... 

***run.sh do the following:
will build the docker image with python if needed
destory and recreate the docker network
terraform init
terraform plan
terraform apply --auto-approve
run curl http://localhost:8000 5 times. 
    You will see each time curl is called the counter increments,
    meaning that the python web/flask app is use the redis database

**cleanup.sh runs
terraform destory --auto-approve
runs: source "./clean-tf.sh" to delete terraform state files
deletes docker network my_network