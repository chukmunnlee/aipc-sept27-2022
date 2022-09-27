variable DO_token {
 type = string
 sensitive = true 
}

variable DO_region {
    type = string
    default = "sgp1"
}

variable DO_size {
    type = string
    default = "s-1vcpu-1gb"
}

variable DO_image {
    type = string
    default = "ubuntu-20-04-x64"
}

variable replicas {
    type = number
    default = 3
}

variable public_key {
    type = string
}

variable private_key {
    type = string
}