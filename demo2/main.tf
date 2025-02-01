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
  source = "./dummy"
  iport = 80
  oport = 8082 + count.index
  container_name = join("", ["MyDummyApp", count.index])
  image_name = "nginx"

  count = 4

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
  value = module.mydummy
}

