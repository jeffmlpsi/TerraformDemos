# Specifying Docker provider
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

# use a data section to reference an exsiting docker image
data "docker_image" "local_image" {
  name = "pure_image"
}
resource "docker_container" "web" {
  image = data.docker_image.local_image.id
  name = "web"

  ports {
    internal = "5000"
    external = "8000"
    ip = "127.0.0.1"
  }

  networks_advanced {
    name = "my_network"
  }


  

}

resource "docker_image" "redis" {
  name         = "redis"
}

resource "docker_container" "redis" {
  image = docker_image.redis.image_id
  name  = "redis"
  hostname = "redis"

  networks_advanced {
    name = "my_network"
  }

}