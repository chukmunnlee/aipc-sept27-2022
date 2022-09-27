terraform {
  required_version = ">= 1.3"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.22.0"
    }
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "2.22.3"
    }
    local = {
        source = "hashicorp/local"
        version = "2.2.3"
    }
  }
}

provider docker {
    //host = "unix:///var/run/docker.sock"
    host = "tcp://157.245.202.70:2376"
    cert_path = pathexpand("/home/cmlee/.docker/machine/machines/aipc-csf")
}

provider digitalocean {
    token = var.DO_token
}

provider local { }
