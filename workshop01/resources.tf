locals {
    ports = [ for p in docker_container.dovbear_container[*].ports: p[0].external ]
}

resource digitalocean_ssh_key abc {
    name = "abc"
    public_key = file(var.public_key)
}

resource docker_image dovbear_image {
    name = "chukmunnlee/dov-bear:v2"
}

resource docker_container dovbear_container {
    count = var.replicas
    name = "dov-${count.index}"
    image = docker_image.dovbear_image.image_id
    ports {
        internal = 3000
        external = 31000 + count.index
    }
    env = [
        "INSTANCE_NAME=dov-${count.index}"
    ]
}

resource local_file nginx_conf {
    filename = "nginx.conf"
    content = templatefile("nginx.conf.tftpl", {
        docker_host = "157.245.202.70"
        container_ports = local.ports
    })
}

resource digitalocean_droplet nginx {
    name = "nginx"
    image = var.DO_image
    size = var.DO_size
    region = var.DO_region
    ssh_keys = [ digitalocean_ssh_key.abc.id ]

    connection {
      type = "ssh"
      user = "root"
      host = self.ipv4_address
      private_key = file(var.private_key)
    }

    // Install nginx
    provisioner remote-exec {
        inline = [
            "apt update",
            "apt install -y nginx",
            "systemctl enable nginx",
            "systemctl start nginx",
        ]
    }

    // Copy the nginx.conf to the droplet
    provisioner file {
        source = "./${local_file.nginx_conf.filename}"
        destination = "/etc/nginx/nginx.conf"
    }

    // Restart nginx
    provisioner remote-exec {
        inline = [
            "systemctl restart nginx"
        ]
    }
}

resource local_file root_at_ip {
    content = ""
    filename = "root@${digitalocean_droplet.nginx.ipv4_address}"
}

output nginx_ip {
    description = "Nginx IP"
    value = digitalocean_droplet.nginx.ipv4_address
}

output container_ports {
    description = "container ports"
    value = local.ports
}

