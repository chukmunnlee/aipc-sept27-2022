resource "digitalocean_ssh_key" "xyz" {
    name = "xyz"
    public_key = file("/opt/tmp/abc.pub")
}

resource "digitalocean_droplet" "mydroplet" {
    name = "mydroplet"
    image = var.DO_image
    size = var.DO_size
    region = var.DO_region
    ssh_keys = [ digitalocean_ssh_key.xyz.id ]
}

resource local_file root_at_mydroplet {
    content = "The IP address is ${digitalocean_droplet.mydroplet.ipv4_address}"
    filename = "root@${digitalocean_droplet.mydroplet.ipv4_address}"
    file_permission = 644
}

resource "local_file" "hosts" {
    filename = "hosts"
    file_permission = 644
    content = templatefile("hosts.tftpl", {
        droplet_ip = digitalocean_droplet.mydroplet.ipv4_address
        droplet_name = digitalocean_droplet.mydroplet.name
    })
}

resource "local_file" "inventory" {
    filename = "inventory.yaml"
    content = templatefile("inventory.yaml.tftpl", {
        private_key = var.private_key
        droplet_ip = digitalocean_droplet.mydroplet.ipv4_address
    })
}
output mydroplet_ip {
    value = digitalocean_droplet.mydroplet.ipv4_address
}
output abc_fingerprint {
    description = "fingerprint"
    value = digitalocean_ssh_key.xyz.fingerprint
}