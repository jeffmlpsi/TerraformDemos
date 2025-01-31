### can also pass vars in on cmmand line
### terraform apply -var 'container_name=AnotherxContainer'
### terraform apply -var 'container_name=AnotherxContainer' -var 'image_name=nginx:1.19.10'
### terraform apply -var "$SomeShellVar" -var "$SomeOtherShellVar"
variable "container_name" {
  description = "Value of the name for the Docker container"
  type        = string
  default     = "nginx"
}

variable "cmdline_var" {
  description = "Value of command line argument"
  type        = string
  default     = "notset"
}