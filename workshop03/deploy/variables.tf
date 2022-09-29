variable "DO_token" {
  description = "my DO token"
  type        = string
  sensitive   = true
}

variable "DO_region" {
  type    = string
  default = "sgp1"
}

variable "DO_size" {
  type    = string
  default = "s-1vcpu-1gb"
}

variable "DO_image" {
  type    = string
  default = "ubuntu-20-04-x64"
}

variable CF_api_token {
  type = string
  sensitive = true
}

variable "codeserver_password" {
  type      = string
  sensitive = true
}

variable codeserver_domain {
  type = string
}
variable codeserver_fqdn {
  type = string
}

variable "private_key" {
  type = string
}