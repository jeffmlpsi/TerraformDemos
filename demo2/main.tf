terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

module "mydummy" {
  # source specifies the path to the modules
  source = "./dummy"
  # like Docker, Terraform has registies and can get modules and
  # resources from a registry. 
  # If you are using a module from a Terraform registry, you can specify
  # a version - for example: version = :1.0.0"
  # We do not need version here since we are using a module from a local paths

  # within a module block, you can define arguments to pass into the module
  # here we define the internal and external ports, the container_name, and 
  # and set the image-name to nginxs
  iport = 80
  # count.index will be 0,1,2,3 for this example, incrementing by 1 everytime
  # the dummy module is called
  oport = 8082 + count.index
  # HCL has a join function that can be used to concatenate strings
  # as well as many other built in functions
  container_name = join("", ["MyDummyApp", count.index])
  image_name = "nginx"

  # The HCL module specification specifes you can specify calling multiple instances of the module
  # by specifying a count parameter. Here we specify 4 instances of the module
  count = 4

  # each instacnce of dummy can be referenced by the index. For example:
  # module.mydummy[1], module.mydummy[2], module.mydummy[3], module.mydummy[4]
  # m

}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "GoodOleX"

  ports {
    internal = 80
    external = 8001
  }
}

output "module_info" {
  value = [
    for m in module.mydummy : {
      container_id = m.container_id
      container_name = m.container_name
      image_name = m.image_name
      port_mappings = m.port_mappings
    }
  ]
}