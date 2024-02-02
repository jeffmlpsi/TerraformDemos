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
  oport = 8082 + count.index
  container_name = join("", ["MyDummyApp", count.index])
  image_name = "sha256:cd61b3665c275aa8c77550878a094f08db7b5ea9ff7d4b1d6f8ab3bee26b6c91"

  count = 4

}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "GoodOleX"

  ports {
    internal = 80
    external = 8001
  }
}
