terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_network" "private_network" {
  name = "my_network"
}

resource "docker_image" "web" {
  name = "web"
  build {
    context = "."
  }
}

resource "docker_container" "web" {
  image = docker_image.web.image_id
  name = "web"

  ports {
    internal = "5000"
    external = "8000"
    ip = "127.0.0.1"
  }

  networks_advanced {
    name = docker_network.private_network.id
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
    name = docker_network.private_network.id
  }

}