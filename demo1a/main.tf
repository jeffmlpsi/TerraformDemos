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
  name         = var.container_name
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial1a"

  ports {
    internal = 80
    external = 8002
  }
}

output "image_id" {
  value = docker_image.nginx.image_id
}
output "cmdline_var" {
  value = var.cmdline_var
}

### equivalent docker command
### docker run -dp 127.0.01:8000:80 --name tutorial nginx