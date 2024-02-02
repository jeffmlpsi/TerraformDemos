terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

resource "docker_container" "dummyapp" {
  image = var.image_name
  name = var.container_name

  ports {
    internal = var.iport
    external = var.oport
  }
}

output "container_id" {
  value = docker_container.dummyapp.id
}
