terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"

  ports {
    internal = 80
    external = 8000
    ### change 01
    ### external = 8001
  }
}

### change 02
### output "image_id_web01" {
output "image_id" {
  value = docker_image.nginx.image_id
}

### equivalent docker command
### docker run -dp 127.0.01:8000:80 --name tutorial nginx