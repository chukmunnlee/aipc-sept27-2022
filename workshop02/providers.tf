terraform {
  required_version = ">= 1.3"
  required_providers {
    digitalocean = {
        source = "digitalocean/digitalocean"
        version = "2.22.3"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "3.24.0"
    }
    local = {
        source = "hashicorp/local"
        version = "2.2.3"
    }
  }
}

provider cloudflare {
  api_token = var.CF_api_token
}

provider digitalocean {
    token = var.DO_token
}

provider local { }
