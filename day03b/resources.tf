data "digitalocean_ssh_key" "abc" {
    name = "abc"
}

resource digitalocean_droplet codeserver {
    name = "codeserver"
    image = var.DO_image
    size = var.DO_size
    region = var.DO_region
    ssh_keys = [ data.digitalocean_ssh_key.abc.id ]
}

resource local_file root_at_codeserver {
    content = "The IP address is ${digitalocean_droplet.codeserver.ipv4_address}"
    filename = "root@${digitalocean_droplet.codeserver.ipv4_address}"
    file_permission = 644
}

output codeserver_ip {
    value = digitalocean_droplet.codeserver.ipv4_address
}
